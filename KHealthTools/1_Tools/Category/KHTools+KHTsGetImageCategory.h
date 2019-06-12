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

+ (UIFont  *)naviTitleFont;
+ (UIColor *)naviTitleColor;
+ (UIImage *)naviBackImg;
+ (UIImage *)naviBackImg_White;

///主题颜色
+ (UIColor *)themeColor;
///副主题颜色
+ (UIColor *)themeColor2;

+ (UIImage *)arrowImg_Right;
+ (UIImage *)arrowImg_Up;
+ (UIImage *)arrowImg_Down;

+ (UIImage *)chooseImg_Sel;
+ (UIImage *)chooseImg_Sel_White;
+ (UIImage *)chooseImg_Nor;
+ (UIImage *)chooseImg_End;

@end
