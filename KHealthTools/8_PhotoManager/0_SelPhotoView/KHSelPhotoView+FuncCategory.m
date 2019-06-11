//
//  KHSelPhotoView+FuncCategory.m
//  KHealthModules
//
//  Created by kim on 2019/3/19.
//  Copyright © 2019年 李云新. All rights reserved.
//

#import "KHealthToolsHeader.h"
#import "KHSelPhotoView+FuncCategory.h"
#import "KHPhotoModel+AssetDataCategory.h"

@implementation KHSelPhotoView (FuncCategory)

- (void)c_openCameraVC {
    dispatch_async(dispatch_get_main_queue(), ^{
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (status == AVAuthorizationStatusDenied || status == AVAuthorizationStatusRestricted) {
            [[KHTools kh_getNaviVC] kh_simpleAlertWithTitle:@"" Message:@"应用相机权限受限，请到隐私设置中允许应用访问相机" CompleteTitle:@"确认" Complete:nil];
            return;
        }
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.allowsEditing = NO;
        [[KHTools kh_getNaviVC] presentViewController:picker animated:YES completion:nil];
    });
}

///打开图片库
- (void)c_openPhotoLibVCWithMaxCount:(NSInteger)maxCount {
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusDenied || status == PHAuthorizationStatusRestricted) {
        [[KHTools kh_getNaviVC] kh_simpleAlertWithTitle:@"" Message:@"应用相册权限受限，请到隐私设置中允许应用访问相册" CompleteTitle:@"确认" Complete:nil];
        return;
    }
    UINavigationController *nvc = [KHPhotoLibraryVC initWithMaxCount:maxCount delegate:self];
    [[KHTools kh_getNaviVC] presentViewController:nvc animated:YES completion:nil];
}

#pragma mark - KHPhotoLibVCDelegate
- (void)photoLibraryVC:(KHPhotoLibraryVC *)photoLibraryVC photoArr:(NSArray<KHPhotoModel *> *)photoArr {
    [self.modelArray addObjectsFromArray:photoArr];
    [self reloadUI];
}

#pragma mark - KHShowPhotoVCDelegate
- (void)showPhotoVC:(KHShowPhotoVC *)showPhotoVC refreshPhotoArr:(NSArray<KHPhotoModel *> *)photoArr {
    [showPhotoVC.navigationController popViewControllerAnimated:YES];
    self.modelArray = [NSMutableArray arrayWithArray:photoArr];
    [self reloadUI];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image;
    if (picker.allowsEditing) {
        image = info[UIImagePickerControllerEditedImage];
    } else {
        image = info[UIImagePickerControllerOriginalImage];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self savePhotoWithImage:image];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

///保存图片并刷新UI
- (void)savePhotoWithImage:(UIImage *)image {
    UIImage *currentImg = [self imageWithRightOrientation:image];
    KHWeakObj(self);
    [KHPhotoModel saveImageToAlbumWithImage:currentImg error:^(NSString *errorStr) {
        KHLog(@"%@",errorStr);
    } success:^(PHAsset *asset) {
        KHPhotoModel *model = [[KHPhotoModel alloc] init];
        model.is_sel = YES;
        model.asset = asset;
        [weakSelf.modelArray addObject:model];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf reloadUI];
        });
    }];
}

- (void)c_getImageArray:(void (^)(NSArray <NSData *> *pDataS, NSArray *pIndexS, NSArray *pUrlS))cOption {
    if(self.modelArray.count == 0) {
        cOption(@[],@[],@[]);
        return;
    }
    __block NSInteger resultIndex = 0;
    __block NSMutableArray *dataPArray  = [NSMutableArray arrayWithCapacity:self.modelArray.count];
    __block NSMutableArray *indexPArray = [NSMutableArray arrayWithCapacity:self.modelArray.count];
    __block NSMutableArray *urlPArray    = [NSMutableArray arrayWithCapacity:self.modelArray.count];
    KHWeakObj(self);
    for (KHPhotoModel *model in self.modelArray) {
        if (model.imageUrlStr) {
            ///网络图片
            resultIndex ++;
            [urlPArray addObject:model.imageUrlStr];
            if (resultIndex == weakSelf.modelArray.count) {
                if (cOption) {
                    cOption(dataPArray, indexPArray, urlPArray);
                    [dataPArray removeAllObjects];
                }
            }
            continue;
        }
        ///系统图片资源
        [KHPhotoModel getDataWithAsset:model.asset Complete:^(BOOL success, NSData *imageData) {
            if (success) {
                [dataPArray addObject:imageData];
                [indexPArray  addObject:@(resultIndex)];
            }
            resultIndex ++;
            if (resultIndex == weakSelf.modelArray.count) {
                if (cOption) {
                    cOption(dataPArray, indexPArray,urlPArray);
                    [dataPArray removeAllObjects];
                }
            }
        }];
    }
}

///获取当前视图的图片资源
- (void)c_getImageImageArray:(void(^)(NSArray <UIImage *> *pImgS))cOption {
    if (self.modelArray.count == 0) {
        cOption(@[]);
        return;
    }
    __block NSMutableArray <UIImage *>*blockArr = [NSMutableArray arrayWithCapacity:self.modelArray.count];
    __block NSInteger resultIndex = 0;
    NSInteger count = self.modelArray.count;
    for (KHPhotoModel *model in self.modelArray) {
        if (model.asset) {
            [KHPhotoModel getBetterImageWithAsset:model.asset Complete:^(UIImage *image) {
                if (image) {
                    [blockArr addObject:image];
                }
                resultIndex++;
                if (resultIndex == count) {
                    if(cOption) {
                        cOption(blockArr);
                    }
                }
            }];
        } else {
            resultIndex++;
            if (resultIndex == count) {
                if(cOption) {
                    cOption(blockArr);
                }
                break;
            }
        }
    }
}

///对拍照的图片进行旋转角度处理
- (UIImage *)imageWithRightOrientation:(UIImage *)aImage {
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

@end
