//
//  UIButton+KHEdgeInsets.m
//  KHealthTools
//
//  Created by kim on 2019/2/12.
//  Copyright © 2019年 lambert. All rights reserved.
//

#import "UIButton+KHEdgeInsets.h"

@implementation UIButton (KHEdgeInsets)

- (void)kh_layoutButtonWithEdgeInsetsStyle:(KHButtonEdgeInsetsStyle)style imageTitlespace:(CGFloat)space {
    
    CGFloat imageWith = self.currentImage.size.width;
    CGFloat imageHeight = self.currentImage.size.height;
    
    CGFloat labelWidth = 0.0;
    CGFloat labelHeight = 0.0;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        //iOS8中titleLabel的size为0
        labelWidth = self.titleLabel.intrinsicContentSize.width;
        labelHeight = self.titleLabel.intrinsicContentSize.height;
    } else {
        labelWidth = self.titleLabel.frame.size.width;
        labelHeight = self.titleLabel.frame.size.height;
    }
    
    //0.声明全局的imageEdgeInsets和labelEdgeInsets
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    
    //1.根据style和space得到imageEdgeInsets和labelEdgeInsets的值
    switch (style) {
            case KHButtonEdgeInsetsStyleImageTop: {
                imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-space, 0, 0, -labelWidth);
                labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight-space, 0);
            }
            break;
            case KHButtonEdgeInsetsStyleImageLeft: {
                imageEdgeInsets = UIEdgeInsetsMake(0, -space, 0, space);
                labelEdgeInsets = UIEdgeInsetsMake(0, space, 0, -space);
            }
            break;
            case KHButtonEdgeInsetsStyleImageBottom: {
                imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight-space, -labelWidth);
                labelEdgeInsets = UIEdgeInsetsMake(-imageHeight-space, -imageWith, 0, 0);
            }
            break;
            case KHButtonEdgeInsetsStyleImageRight: {
                imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+space, 0, -labelWidth-space);
                labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith-space, 0, imageWith+space);
            }
            break;
        default:
            break;
    }
    //2.赋值
    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
}

@end
