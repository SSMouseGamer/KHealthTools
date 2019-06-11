//
//  CALayer+SDWebImage.m
//  KHealthTools
//
//  Created by kim on 2019/2/22.
//  Copyright © 2019年 lambert. All rights reserved.
//

#import "CALayer+SDWebImage.h"
#import "KHealthToolsMacro.h"

#import "CALayer+WebCache.h"
#import "KHTools+KHTsGetImageCategory.h"

#define DYSDWebImageOptions (SDWebImageRetryFailed | SDWebImageLowPriority | SDWebImageAllowInvalidSSLCertificates)

@implementation CALayer (SDWebImage)

- (void)kh_setHeaderWithURLStr:(NSString *)urlStr {
    [self kh_setHeaderWithURLStr:urlStr placeholderImage:[KHTools kh_getImage_head_placeholder]];
}

- (void)kh_setHeaderWithURLStr:(NSString *)urlStr placeholderImage:(UIImage *)placeholderImage {
    NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    [self kh_setHeaderWithURL:url placeholderImage:placeholderImage];
}

- (void)kh_setHeaderWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholderImage {
    self.contentsGravity = kCAGravityResizeAspectFill;
    [self kh_baseSetImageLayerWithURL:url placeholderImage:placeholderImage completed:nil];
}

- (void)kh_setImageWithURLStr:(NSString *)urlStr {
    [self kh_setImageWithURLStr:urlStr
               placeholderImage:[KHTools kh_getImage_normal_placeholder]
                      completed:nil];
}

- (void)kh_setImageWithURLStr:(NSString *)urlStr placeholderImage:(UIImage *)placeholderImage completed:(SDExternalCompletionBlock)completedBlock {
    
    NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    
    [self kh_setImageWithURL:url placeholderImage:placeholderImage completed:completedBlock];
}

- (void)kh_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholderImage completed:(SDExternalCompletionBlock)completedBlock {
    [self kh_baseSetImageLayerWithURL:url placeholderImage:placeholderImage completed:completedBlock];
}


-(void)kh_baseSetImageLayerWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholderImage completed:(SDExternalCompletionBlock)completedBlock{
    CALayer *imageLayer = (CALayer *)self;
    imageLayer.contents = (id)placeholderImage.CGImage;
    
    [imageLayer sd_setImageWithURL:url placeholderImage:placeholderImage options:DYSDWebImageOptions progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {

    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (completedBlock){
            completedBlock(image,error,cacheType,imageURL);
        }
    }];
}
@end
