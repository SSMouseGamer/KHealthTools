//
//  UIView+SDWebImage.h
//  globalDuoBao
//
//  Created by 李云新 on 17/3/24.
//  Copyright © 2017年 GlobalDuoBao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDWebImageManager.h"

@interface UIView (SDWebImage)

- (void)kh_setHeaderWithURLStr:(NSString *)urlStr;
- (void)kh_setHeaderWithURLStr:(NSString *)urlStr placeholderImage:(UIImage *)placeholderImage;
- (void)kh_setHeaderWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholderImage;

- (void)kh_setImageWithURLStr:(NSString *)urlStr;
- (void)kh_setImageWithURLStr:(NSString *)urlStr placeholderImage:(UIImage *)placeholderImage completed:(SDExternalCompletionBlock)completedBlock;

- (void)kh_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholderImage completed:(SDExternalCompletionBlock)completedBlock;


#pragma mark - 下载图片
///下载图片
+ (void)kh_downloadImage:(NSString *)urlStr
                Complete:(void (^)(UIImage * image))cBlock;

///下载头像
+ (void)kh_downloadHeader:(NSString *)urlStr
                 Complete:(void (^)(UIImage * image))cBlock;

///下载图片 - 指定占位图的形式
+ (void)kh_downloadImage:(NSString *)urlStr
        PlaceholderImage:(UIImage *)placeholderImage
                Complete:(void (^)(UIImage * image))cBlock;

///下载图片组
+ (void)kh_downloadImages:(NSArray *)urlArray
                 Complete:(void (^)(NSArray<UIImage *> * imageArray))cBlock;

///下载图片组
+ (void)kh_downloadImages:(NSArray *)urlArray
         PlaceholderImage:(UIImage *)placeholderImage
                 Complete:(void (^)(NSArray<UIImage *> * imageArray))cBlock;


@end

