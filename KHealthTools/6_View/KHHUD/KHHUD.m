//
//  KHHUD.m
//
//  Created by Lambert on 16/7/13.
//  Copyright © 2016年 Lambert. All rights reserved.
//

#import "KHHUD.h"
#import "KHProgressHUD+Category.h"

@interface KHHUD()

@end

@implementation KHHUD

+ (void)kh_showSuccess{
    [KHProgressHUD kh_showSuccess];
}

+ (void)kh_showSuccess:(NSString *)success{
    [KHProgressHUD kh_showSuccess:success];
}

+ (void)kh_showSuccess:(NSString *)success toView:(UIView *)view{
    [KHProgressHUD kh_showSuccess:success toView:view];
}

+ (void)kh_showFailure{
    [KHProgressHUD kh_showFailure];
}

+ (void)kh_showFailure:(NSString *)failure{
    [KHProgressHUD kh_showFailure:failure];
}

+ (void)kh_showFailure:(NSString *)failure toView:(UIView *)view{
    [KHProgressHUD kh_showFailure:failure toView:view];
}

+ (void)kh_showMessage:(NSString *)message{
    [KHProgressHUD kh_showMessage:message];
}

+ (void)kh_showMessage:(NSString *)message toView:(UIView *)view{
    [KHProgressHUD kh_showMessage:message toView:view];
}

+ (void)kh_showMessage:(NSString *)message delay:(CGFloat)delay{
    [KHProgressHUD kh_showMessage:message delay:delay];
}

+ (void)kh_showMessage:(NSString *)message toView:(UIView *)view delay:(CGFloat)delay{
    [KHProgressHUD kh_showMessage:message toView:view delay:delay];
}

+ (KHProgressHUD *)kh_showLoad{
    return [KHProgressHUD kh_showLoad:@"加载中..."];
}

+ (KHProgressHUD *)kh_showLoadToView:(UIView *)view{
    return [KHProgressHUD kh_showLoad:@"加载中..." toView:view];
}

+ (KHProgressHUD *)kh_showLoad:(NSString *)message{
    return [KHProgressHUD kh_showLoad:message];
}

+ (KHProgressHUD *)kh_showLoad:(NSString *)message toView:(UIView *)view{
    return [KHProgressHUD kh_showLoad:message toView:view];
}

+ (KHProgressHUD *)kh_showLoad:(NSString *)message toView:(UIView *)view delay:(CGFloat)delay{
    return [KHProgressHUD kh_showLoad:message toView:view delay:delay];
}

+ (void)kh_hideHUDForView:(UIView *)view{
    [KHProgressHUD kh_hideHUDForView:view];
}

+ (void)kh_hideHUD{
    [KHProgressHUD kh_hideHUD];
}

@end
