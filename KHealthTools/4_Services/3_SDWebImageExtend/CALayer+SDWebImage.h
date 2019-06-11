//
//  CALayer+SDWebImage.h
//  KHealthTools
//
//  Created by kim on 2019/2/22.
//  Copyright © 2019年 lambert. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import "SDWebImageManager.h"

@interface CALayer (SDWebImage)

- (void)kh_setHeaderWithURLStr:(NSString *)urlStr;
- (void)kh_setHeaderWithURLStr:(NSString *)urlStr placeholderImage:(UIImage *)placeholderImage;
- (void)kh_setHeaderWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholderImage;

- (void)kh_setImageWithURLStr:(NSString *)urlStr;
- (void)kh_setImageWithURLStr:(NSString *)urlStr placeholderImage:(UIImage *)placeholderImage completed:(SDExternalCompletionBlock)completedBlock;

- (void)kh_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholderImage completed:(SDExternalCompletionBlock)completedBlock;

@end
