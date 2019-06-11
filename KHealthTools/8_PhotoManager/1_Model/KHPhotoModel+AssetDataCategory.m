//
//  KHPhotoModel+AssetDataCategory.m
//  KHealthModules
//
//  Created by kim on 2019/3/22.
//  Copyright © 2019年 李云新. All rights reserved.
//

#import "KHealthToolsHeader.h"
#import "KHPhotoModel+AssetDataCategory.h"

@implementation KHPhotoModel (AssetDataCategory)

///判断是否iCloud图片并且能正常加载
+ (void)makeSureIsICloudDataWithAsset:(PHAsset *)asset Complete:(void(^)(BOOL isSuccess))cBlock {
    if (!asset) {
        if (cBlock) {
            cBlock(NO);
        }
        return;
    }
    
    PHImageRequestOptions *opts = [[PHImageRequestOptions alloc] init];
    __block BOOL isICloud = NO;
    ///PhotosDefines.h
    opts.progressHandler = ^(double progress, NSError * _Nullable error, BOOL * _Nonnull stop, NSDictionary * _Nullable info) {
        if (!isICloud) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [KHHUD kh_showLoad:@"从iCloud加载图片"];
            });
        }
        isICloud = YES;
    };
    opts.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    opts.synchronous  = NO;///为了保证图片被获取必须使用同步
    opts.networkAccessAllowed = YES;///为了避免获取失败，必须允许从icloud加载
    
    @autoreleasepool {
        [[PHImageManager defaultManager] requestImageDataForAsset:asset options:opts resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
            KHLog(@"图片大小：%ldKB \n图片信息：\n%@", (long)[imageData length]/1024, info);
            [KHHUD kh_hideHUD];
            if (cBlock) {
                cBlock(!(isICloud && !imageData));
            }
        }];
    }
}

///获取资源对应的图片
+ (void)getThumialImageWithAsset:(PHAsset *)asset Complete:(void (^)(UIImage *image, NSDictionary *info))cBlock {
    CGFloat bW = (KHScreenWidth - 25.0) / 4.0;
    NSInteger retinaScale = [UIScreen mainScreen].scale;
    CGSize retinaSquare = CGSizeMake(bW * retinaScale, bW * retinaScale);
    CGFloat cropSideLength = MIN(asset.pixelWidth, asset.pixelHeight);
    CGRect square = CGRectMake(0, 0, cropSideLength, cropSideLength);
    CGRect cropRect = CGRectApplyAffineTransform(square, CGAffineTransformMakeScale((1.0 / asset.pixelWidth), (1.0 / asset.pixelHeight)));
    
    PHImageRequestOptions *opts = [[PHImageRequestOptions alloc] init];
    opts.normalizedCropRect = cropRect;
    opts.resizeMode   = PHImageRequestOptionsResizeModeExact;
    
    @autoreleasepool {
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:retinaSquare contentMode:PHImageContentModeAspectFit options:opts resultHandler:cBlock];
    }
}

///获取资源对应的质量最好的图片
+ (void)getBetterImageWithAsset:(PHAsset *)asset Complete:(void (^)(UIImage *image))cBlock {
    //PHImageRequestOptionsResizeMode 自定义设置图片的大小 枚举类型*
    //PHImageRequestOptionsResizeModeNone , //保持原size
    //PHImageRequestOptionsResizeModeFast , //高效、但不保证图片的size为自定义size
    //PHImageRequestOptionsResizeModeExact, //严格按照自定义size
    
    PHImageRequestOptions *opts = [[PHImageRequestOptions alloc] init];
    opts.synchronous = YES;
    opts.resizeMode   = PHImageRequestOptionsResizeModeNone;
    opts.deliveryMode = PHImageRequestOptionsDeliveryModeOpportunistic;
    CGSize targetSize = CGSizeMake([UIScreen mainScreen].bounds.size.width  * [UIScreen mainScreen].scale,
                                   [UIScreen mainScreen].bounds.size.height * [UIScreen mainScreen].scale);
    @autoreleasepool {
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:targetSize contentMode:PHImageContentModeAspectFill options:opts resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            if (cBlock) {
                cBlock(result);
            }
        }];
    }
}

///获取图片资源对应的data
+ (void)getDataWithAsset:(PHAsset *)asset Complete:(void (^)(BOOL success, NSData *imageData))cBlock {
    if (!asset) {
        if (cBlock) {
            cBlock(NO,nil);
        }
        return;
    }
    PHImageRequestOptions *opts = [[PHImageRequestOptions alloc] init];
    opts.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    opts.synchronous  = NO;///为了保证图片被获取必须使用同步
    opts.networkAccessAllowed = YES;///为了避免获取失败，必须允许从icloud加载
    @autoreleasepool {
        [[PHImageManager defaultManager] requestImageDataForAsset:asset options:opts resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
            KHLog(@"图片大小：%ldKB \n图片信息：\n%@", (long)[imageData length]/1024, info);
            if (cBlock) {
                if ([dataUTI containsString:@"public.heic"]) {
                    UIImage *image = [UIImage imageWithData:imageData];
                    cBlock(!(!imageData), UIImageJPEGRepresentation(image, 0.81));
                } else {
                    cBlock(!(!imageData), imageData);
                }
            }
        }];
    }
}

///保存图片，并且获取相册资源对象
+ (void)saveImageToAlbumWithImage:(UIImage *)image error:(void (^)(NSString *))errorBlock success:(void (^)(PHAsset *))successBlock {
    if (!image) {
        if (errorBlock) {
            errorBlock(@"未获取到图片");
        }
        return;
    }
    __block NSMutableArray *imageIds = [NSMutableArray array];
    @autoreleasepool {
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            PHAssetChangeRequest *req = [PHAssetChangeRequest creationRequestForAssetFromImage:image];
            [imageIds addObject:req.placeholderForCreatedAsset.localIdentifier];
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                PHFetchResult *result = [PHAsset fetchAssetsWithLocalIdentifiers:imageIds options:nil];
                if (successBlock) {
                    successBlock(result.firstObject);
                }
            } else {
                if (errorBlock) {
                    errorBlock(@"保存失败");
                }
            }
        }];
    }
}

@end
