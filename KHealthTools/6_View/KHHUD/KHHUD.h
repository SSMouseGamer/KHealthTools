//
//  KHHUD.h
//
//  Created by Lambert on 16/7/13.
//  Copyright © 2016年 Lambert. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KHProgressHUD.h"

@interface KHHUD : NSObject

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

+ (KHProgressHUD *)kh_showLoad;
+ (KHProgressHUD *)kh_showLoadToView:(UIView *)view;
+ (KHProgressHUD *)kh_showLoad:(NSString *)message;
+ (KHProgressHUD *)kh_showLoad:(NSString *)message toView:(UIView *)view;
+ (KHProgressHUD *)kh_showLoad:(NSString *)message toView:(UIView *)view delay:(CGFloat)delay;
+ (void)kh_hideHUDForView:(UIView *)view;
+ (void)kh_hideHUD;

@end
