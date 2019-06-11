//
//  KHTools.h
//  KHealthDoctor
//
//  Created by 李云新 on 2018/8/18.
//  Copyright © 2018年 lambert. All rights reserved.
//

#define KHScreenWidth   ([KHTools share].screenW)
#define KHScreenHeight  ([KHTools share].screenH)
#define KHScale_iPhone6 ([KHTools share].scale_i6)
#define KHScale         ([KHTools share].scale)
#define KHMargin        ([KHTools share].margin)
#define KH15Margin      ([KHTools share].margin15)

#define KH_StatusBar_Height  ([KHTools statusBar_Height])
#define KH_IS_iPhoneX        ([KHTools is_iPhoneX])
#define KH_Navi_Title_Height ([KHTools navi_Title_Height])
#define KH_Navi_Height       ([KHTools navi_Height])
#define KH_Bottom_Height     ([KHTools bottom_Height])

#import "KHToolsBaseFont.h"

@interface KHTools : KHToolsBaseFont

///是否为调试版本
+ (BOOL)isDEBUG;

///屏幕宽
@property (nonatomic, assign, readonly) CGFloat screenW;
///屏幕高
@property (nonatomic, assign, readonly) CGFloat screenH;
///以iPhone6为比例等比缩放
@property (nonatomic, assign, readonly) CGFloat scale_i6;
///以宽320为临界点缩放
@property (nonatomic, assign, readonly) CGFloat scale;
///默认间隙 - 这里是8
@property (nonatomic, assign, readonly) CGFloat margin;
///默认横向间隙 - 这里是15
@property (nonatomic, assign, readonly) CGFloat margin15;

///状态栏高度
+ (CGFloat)statusBar_Height;
///判断是否为iPhoneX
+ (BOOL)is_iPhoneX;
///导航栏内容高度
+ (CGFloat)navi_Title_Height;
///导航栏的高度
+ (CGFloat)navi_Height;
///底部的高度
+ (CGFloat)bottom_Height;

@end
