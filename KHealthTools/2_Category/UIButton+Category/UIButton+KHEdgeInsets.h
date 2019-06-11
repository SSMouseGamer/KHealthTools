//
//  UIButton+KHEdgeInsets.h
//  KHealthTools
//
//  Created by kim on 2019/2/12.
//  Copyright © 2019年 lambert. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, KHButtonEdgeInsetsStyle) {
    ///图片在左
    KHButtonEdgeInsetsStyleImageLeft,
    ///图片在右
    KHButtonEdgeInsetsStyleImageRight,
    ///图片在上
    KHButtonEdgeInsetsStyleImageTop,
    ///图片在下
    KHButtonEdgeInsetsStyleImageBottom
};

@interface UIButton (KHEdgeInsets)

/**
 重新调整btn的imageView和titleLabel的位置

 @param style 风格
 @param space 图片和imageView的距离
 */
- (void)kh_layoutButtonWithEdgeInsetsStyle:(KHButtonEdgeInsetsStyle)style imageTitlespace:(CGFloat)space;

@end
