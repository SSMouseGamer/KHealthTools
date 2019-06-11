//
//  KHProgressHUD+Category.h
//  KHTools
//
//  Created by 李云新 on 2018/8/7.
//

#import "KHProgressHUD.h"

@interface KHProgressHUD (Category)

+ (void)kh_showSuccess;
+ (void)kh_showSuccess:(NSString *)success;
+ (void)kh_showSuccess:(NSString *)success toView:(UIView *)view;

+ (void)kh_showFailure;
+ (void)kh_showFailure:(NSString *)failure;
+ (void)kh_showFailure:(NSString *)failure toView:(UIView *)view;

+ (void)kh_showMessage:(NSString *)message;
+ (void)kh_showMessage:(NSString *)message toView:(UIView *)view;
+ (void)kh_showMessage:(NSString *)message delay:(CGFloat)delay;
+ (void)kh_showMessage:(NSString *)message toView:(UIView *)view delay:(CGFloat)delay;

+ (KHProgressHUD *)kh_showLoad:(NSString *)message;
+ (KHProgressHUD *)kh_showLoad:(NSString *)message toView:(UIView *)view;
+ (KHProgressHUD *)kh_showLoad:(NSString *)message toView:(UIView *)view delay:(CGFloat)delay;
+ (void)kh_hideHUDForView:(UIView *)view;
+ (void)kh_hideHUD;

@end
