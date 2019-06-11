//
//  KHTools.m
//  KHealthDoctor
//
//  Created by 李云新 on 2018/8/18.
//  Copyright © 2018年 lambert. All rights reserved.
//

#import "KHTools.h"

@interface KHTools()

@end

@implementation KHTools

///是否为调试版本
+ (BOOL)isDEBUG {
#ifdef DEBUG
    return YES;
#else
    return NO;
#endif
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _screenW  = [UIScreen mainScreen].bounds.size.width;
        _screenH  = [UIScreen mainScreen].bounds.size.height;
        _scale_i6 = self.screenW / 375.0;
        _scale    = self.screenW <= 320 ? self.scale_i6 : 1;
        _margin   = 8;
        _margin15 = 15 * self.scale;
    }
    return self;
}

#pragma mark -
///状态栏高度
+ (CGFloat)statusBar_Height {
    return [UIApplication sharedApplication].statusBarFrame.size.height;
}

///判断是否为iPhoneX
+ (BOOL)is_iPhoneX {
    return [KHTools statusBar_Height] == 20 ? NO : YES;
}

///导航栏内容高度
+ (CGFloat)navi_Title_Height {
    return 44;
}
///导航栏的高度
+ (CGFloat)navi_Height {
    return [KHTools statusBar_Height] + [KHTools navi_Title_Height];
}
///底部的高度
+ (CGFloat)bottom_Height {
    return [KHTools is_iPhoneX] ? 34 : 0;
}

@end
