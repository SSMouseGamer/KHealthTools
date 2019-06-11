//
//  KHPhotoModel.h
//  KHealthModules
//
//  Created by kim on 2018/12/29.
//  Copyright © 2018年 李云新. All rights reserved.
//

///选择照片的风格
typedef enum {
    ///编辑模式，可增删
    KHSelPhotoViewStyleEdit,
    ///编辑模式，只增加
    KHSelPhotoViewStyleJustAdd,
    ///只是展示
    KHSelPhotoViewStyleShow
    
} KHSelPhotoViewStyle;

#import <Photos/Photos.h>
#import "KHBaseModel.h"

@interface KHPhotoModel : KHBaseModel
///是否选中
@property (nonatomic, assign) BOOL is_sel;
///图片资源
@property (nonatomic, strong) PHAsset *asset;
///缓存Image 可用来接收外部传进来的Image
@property (nonatomic, strong) UIImage *cacheImage;
///缩略图片
@property (nonatomic, strong) UIImage *thumialImage;
///图片的url 外部传进来的url，以上两个对象不起作用
@property (nonatomic,   copy) NSString *imageUrlStr;

/**
 构建model

 @param asset 资源对象
 @param cacheImage 图片
 @param urlStr 链接
 @return KHPhotoModel
 */
+ (instancetype)initWithAsset:(PHAsset *)asset cacheImage:(UIImage *)cacheImage urlStr:(NSString *)urlStr;



@end
