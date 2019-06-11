//
//  KHPhotoToolsManager.m
//  KHealthModules
//
//  Created by kim on 2019/3/18.
//  Copyright © 2019年 李云新. All rights reserved.
//

#import "KHPhotoTool.h"
#import <Photos/Photos.h>

@implementation KHPhotoTool
#pragma mark - action
+ (KHSelPhotoView *)initPhotoViewWithFrame:(CGRect)frame style:(KHSelPhotoViewStyle)style maxCount:(NSInteger)maxCount imageArr:(NSArray *)imageArray updateUIBlock:(void(^)(void))updateUIBlock {
    return [[KHSelPhotoView alloc] initWithLineCount:4 style:style maxCount:maxCount frame:frame imageArr:imageArray updateUIBlock:updateUIBlock];
}

#pragma mark - init

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    static KHPhotoTool *manager = nil;
    dispatch_once(&onceToken, ^{
        manager = [[KHPhotoTool alloc] init];
    });
    return manager;
}

- (void)initPhotoAssetData {
    NSMutableArray *nameArr = [NSMutableArray array];
    NSMutableArray *assetArr = [NSMutableArray array];
    //1.获取系统设置的相册
    NSInteger subType = PHAssetCollectionSubtypeAny;
    
    NSInteger type  = PHAssetCollectionTypeSmartAlbum;
    PHFetchResult *systemAlbums = [PHAssetCollection fetchAssetCollectionsWithType:type subtype:subType options:nil];
    
    for (PHAssetCollection *collection in systemAlbums) {
        PHFetchResult *results = [PHAsset fetchAssetsInAssetCollection:collection options:nil];
        if (results.count == 0) {
            continue;
        }
        /*************移除不需要的文件来源，比如视频****************/
        if (collection.assetCollectionSubtype == 4 || collection.assetCollectionSubtype == 100 || collection.assetCollectionSubtype == 101 || collection.assetCollectionSubtype == 202 || collection.assetCollectionSubtype == 204 || collection.assetCollectionSubtype == 208  ) {
            continue;
        }
        if (@available(iOS 10.3, *)) {
            if (collection.assetCollectionSubtype == PHAssetCollectionSubtypeSmartAlbumLivePhotos) {
                continue;
            }
        }
        if (@available(iOS 11.0, *)) {
            if (collection.assetCollectionSubtype == PHAssetCollectionSubtypeSmartAlbumAnimated) {
                continue;
            }
        }
        /*************移除不需要的文件来源，比如视频****************/
        if (collection.assetCollectionSubtype == 209){
            //相机胶卷
            [nameArr insertObject:collection.localizedTitle atIndex:0];
            [assetArr insertObject:results atIndex:0];
        } else {
            [nameArr addObject:collection.localizedTitle];
            [assetArr addObject:results];
        }
    }
    
    //2.用户自定义的资源
    NSInteger ctype  = PHAssetCollectionTypeAlbum;
    PHFetchResult *customAlbums = [PHAssetCollection fetchAssetCollectionsWithType:ctype subtype:subType options:nil];
    
    for (PHAssetCollection *collection in customAlbums) {
        PHFetchResult *results = [PHAsset fetchAssetsInAssetCollection:collection options:nil];
        if (results.count == 0) {
            continue;
        }
        [nameArr addObject:collection.localizedTitle];
        [assetArr addObject:results];
    }
    
    self.nameArr = [NSArray arrayWithArray:nameArr];
    self.assetArr = [NSArray arrayWithArray:assetArr];
}

@end
