//
//  UIView+SDWebImage.m
//  globalDuoBao
//
//  Created by 李云新 on 17/3/24.
//  Copyright © 2017年 GlobalDuoBao. All rights reserved.
//

#import "UIView+SDWebImage.h"
#import "KHealthToolsMacro.h"

#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "KHTools+KHTsGetImageCategory.h"

#define DYSDWebImageOptions (SDWebImageRetryFailed | SDWebImageLowPriority | SDWebImageAllowInvalidSSLCertificates)

@implementation UIView (SDWebImage)

#pragma mark 加载头像
-(void)kh_setHeaderWithURLStr:(NSString *)urlStr {
    [self kh_setHeaderWithURLStr:urlStr placeholderImage:[KHTools kh_getImage_head_placeholder]];
}

-(void)kh_setHeaderWithURLStr:(NSString *)urlStr placeholderImage:(UIImage *)placeholderImage {
    NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    [self kh_setHeaderWithURL:url placeholderImage:placeholderImage];
}

-(void)kh_setHeaderWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholderImage {
    [self kh_baseSetImageWithURL:url placeholderImage:placeholderImage completed:nil];
}

#pragma mark View加载图片
-(void)kh_setImageWithURLStr:(NSString *)urlStr {
    [self kh_setImageWithURLStr:urlStr
               placeholderImage:[KHTools kh_getImage_normal_placeholder]
                      completed:nil];
}

#pragma mark View加载图片
-(void)kh_setImageWithURLStr:(NSString *)urlStr placeholderImage:(UIImage *)placeholderImage completed:(SDExternalCompletionBlock)completedBlock{
    
    NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    
    [self kh_setImageWithURL:url placeholderImage:placeholderImage completed:completedBlock];
}

-(void)kh_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholderImage completed:(SDExternalCompletionBlock)completedBlock {

    [self kh_baseSetImageWithURL:url placeholderImage:placeholderImage completed:completedBlock];
}

#pragma mark BaseView加载图片
-(void)kh_baseSetImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholderImage completed:(SDExternalCompletionBlock)completedBlock{
    
    if ([self isKindOfClass:[UIImageView class]]) {
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
    }
    
    if ([self isKindOfClass:[UIButton class]]) {
        UIButton *btn = (UIButton *)self;
        [btn.imageView setContentMode:UIViewContentModeScaleAspectFill];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentFill;
        btn.contentVerticalAlignment   = UIControlContentVerticalAlignmentFill;
    }
    
    if ([[self class] isSubclassOfClass:[UIImageView class]]){
        [self kh_baseSetImageViewWithURL:url placeholderImage:placeholderImage completed:completedBlock];
        return;
    }
    
    if ([[self class] isSubclassOfClass:[UIButton class]]){
        [self kh_baseSetButtonWithURL:url placeholderImage:placeholderImage completed:completedBlock];
        return;
    }
}

#pragma mark UIButton加载图片
-(void)kh_baseSetButtonWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholderImage completed:(SDExternalCompletionBlock)completedBlock{
    UIButton *button = (UIButton *)self;
    
    [button sd_setImageWithURL:url forState:UIControlStateNormal placeholderImage:placeholderImage options:DYSDWebImageOptions completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        if (completedBlock){
            completedBlock(image,error,cacheType,imageURL);
        }
    }];
}

#pragma mark UIImageView加载图片
-(void)kh_baseSetImageViewWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholderImage completed:(SDExternalCompletionBlock)completedBlock{
    UIImageView *imageView = (UIImageView *)self;
    imageView.image = placeholderImage;
    
    KHWeakObj(self);
    [imageView sd_setImageWithURL:url placeholderImage:placeholderImage options:DYSDWebImageOptions progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        if (receivedSize == expectedSize){
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.alpha = 0;
                [UIView animateWithDuration:0.2f animations:^{
                    weakSelf.alpha = 1;
                }];
            });
        }
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (completedBlock){
            completedBlock(image,error,cacheType,imageURL);
        }
    }];
}

#pragma mark - 下载图片
+ (void)kh_downloadImage:(NSString *)urlStr Complete:(void (^)(UIImage * image))cBlock {
    [UIView kh_downloadImage:urlStr
            PlaceholderImage:[KHTools kh_getImage_normal_placeholder]
                    Complete:cBlock];
}

///下载头像
+ (void)kh_downloadHeader:(NSString *)urlStr
                 Complete:(void (^)(UIImage * image))cBlock {
    [UIView kh_downloadImage:urlStr
            PlaceholderImage:[KHTools kh_getImage_head_placeholder]
                    Complete:cBlock];
}

+ (void)kh_downloadImage:(NSString *)urlStr PlaceholderImage:(UIImage *)placeholderImage Complete:(void (^)(UIImage * image))cBlock {
    if (urlStr == nil) {
        if (cBlock) {
            cBlock(nil);
        }
        return;
    }
    
    [UIView kh_downloadImages:@[urlStr] PlaceholderImage:placeholderImage Complete:^(NSArray<UIImage *> *imageArray) {
        if (cBlock) {
            cBlock([imageArray lastObject]);
        }
    }];
}

+ (void)kh_downloadImages:(NSArray *)urlArray Complete:(void (^)(NSArray<UIImage *> * imageArray))cBlock {
    [UIView kh_downloadImages:urlArray
             PlaceholderImage:[KHTools kh_getImage_normal_placeholder]
                     Complete:cBlock];
}

+ (void)kh_downloadImages:(NSArray *)urlArray PlaceholderImage:(UIImage *)placeholderImage Complete:(void (^)(NSArray<UIImage *> * imageArray))cBlock {
    
    SDWebImageDownloader *manager = [SDWebImageDownloader sharedDownloader];
    manager.downloadTimeout = 3 * MAX(urlArray.count, 1);
    
    __block NSMutableDictionary *resultDict = [NSMutableDictionary new];
    for (int i = 0; i<urlArray.count; i++) {
        NSString *imgUrl = [urlArray objectAtIndex:i];
        if (imgUrl == nil) {
            imgUrl = @"";
        }
        
        [manager downloadImageWithURL:[NSURL URLWithString:imgUrl] options:SDWebImageDownloaderUseNSURLCache|SDWebImageDownloaderScaleDownLargeImages progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
            
            if (!image) {
                [resultDict setObject:placeholderImage == nil ? [[UIImage alloc] init] : placeholderImage forKey:@(i)];
                
            } else {
                [resultDict setObject:image forKey:@(i)];
            }
            
            if (resultDict.count == urlArray.count) {
                //全部下载完成
                NSMutableArray *resultArray = [NSMutableArray new];
                for(int i = 0; i< urlArray.count; i++) {
                    NSObject *obj = [resultDict objectForKey:@(i)];
                    [resultArray addObject:obj];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    if(cBlock){
                        cBlock(resultArray);
                    }
                });
            }
        }];
    }
}

@end
