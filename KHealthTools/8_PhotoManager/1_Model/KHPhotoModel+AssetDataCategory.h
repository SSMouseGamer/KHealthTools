//
//  KHPhotoModel+AssetDataCategory.h
//  KHealthModules
//
//  Created by kim on 2019/3/22.
//  Copyright © 2019年 李云新. All rights reserved.
//

#import "KHPhotoModel.h"

@interface KHPhotoModel (AssetDataCategory)

///判断是否iCloud图片并且能正常加载
+ (void)makeSureIsICloudDataWithAsset:(PHAsset *)asset Complete:(void(^)(BOOL isSuccess))cBlock;

/**
 获取资源对应的缩略图片
 */
+ (void)getThumialImageWithAsset:(PHAsset *)asset Complete:(void (^)(UIImage *image, NSDictionary *info))cBlock;

/**
 获取资源对应的质量最好的图片
 */
+ (void)getBetterImageWithAsset:(PHAsset *)asset Complete:(void (^)(UIImage *image))cBlock;

///获取图片资源对应的二进制数据
+ (void)getDataWithAsset:(PHAsset *)asset Complete:(void (^)(BOOL success, NSData *imageData))cBlock;

/**
 保存图片，并且获取相册资源对象
 
 @param image 需要保存的图片
 @param errorBlock 错误的回调
 @param successBlock 正确的回调会返回PHAsset对象
 */
+ (void)saveImageToAlbumWithImage:(UIImage *)image error:(void(^)(NSString *errorStr))errorBlock success:(void(^)(PHAsset *asset))successBlock;

@end
