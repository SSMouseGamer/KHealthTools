//
//  KHTools+KHTsGetImageCategory.h
//  KHealthTools
//
//  Created by 李云新 on 2018/10/19.
//

#import "KHTools.h"

@interface KHTools (KHTsGetImageCategory)

///获取头像占位图
+ (UIImage *)kh_getImage_head_placeholder;
///获取占位图
+ (UIImage *)kh_getImage_normal_placeholder;

///获取导航栏配置 - 字体大小
+ (UIFont  *)kh_getNaviTitleFont;
///获取导航栏配置 - 文字颜色
+ (UIColor *)kh_getNaviTitleColor;
///获取配置 - 主题颜色
+ (UIColor *)kh_getThemeColor;

///获取导航栏图标
+ (UIImage *)kh_getImage_naviBack;
///获取导航栏图标 - 白色
+ (UIImage *)kh_getImage_naviBack_White;

+ (UIImage *)kh_getImage_Aarrow_Right;
+ (UIImage *)kh_getImage_Aarrow_Up;
+ (UIImage *)kh_getImage_Aarrow_Down;

+ (UIImage *)kh_getImage_Choose_Sel;
+ (UIImage *)kh_getImage_Choose_Sel_White;
+ (UIImage *)kh_getImage_Choose_Nor;
+ (UIImage *)kh_getImage_Choose_End;

@end
