//
//  UIViewController+KHTsCategory.h
//  AFNetworking
//
//  Created by 李云新 on 2018/12/8.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, KHNAV_STYLE) {
    ///导航栏字体黑色，状态栏黑色
    KHNAV_STYLE_B_B = 0,
    ///导航栏字体白色，状态栏白色
    KHNAV_STYLE_W_W = 1,
    ///导航栏字体白色，状态栏黑色
    KHNAV_STYLE_W_B = 2,
    ///导航栏字体透明，状态栏白色
    KHNAV_STYLE_W_C = 3,
};

@interface UIViewController (KHTsCategory)

///添加键盘的监听 - 记得在dealloc中移除监听
- (void)kh_addKeyBoardNoti;

/**
 设置导航栏风格
 
 @param style 0:黑字，黑状态栏；1:白字，白状态栏；2:白字，黑状态栏；3:透明字，白状态栏
 */
- (void)kh_setNaviStyle:(KHNAV_STYLE)style;

@end
