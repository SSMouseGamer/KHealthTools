//
//  KHProgressHUD+Category.m
//  KHTools
//
//  Created by 李云新 on 2018/8/7.
//

#import "KHealthToolsHeader.h"
#import "KHProgressHUD+Category.h"

#define DEFAULT_DELAY 6.0

@implementation KHProgressHUD (Category)

#pragma mark - 显示信息，没有图标
+ (void)kh_showMessage:(NSString *)message{
    [self kh_showMessage:message toView:nil];
}

+ (void)kh_showMessage:(NSString *)message delay:(CGFloat)delay{
    [self show:message icon:nil view:nil delay:delay];
}

+ (void)kh_showMessage:(NSString *)message toView:(UIView *)view{
    [self show:message icon:nil view:view];
}

+ (void)kh_showMessage:(NSString *)message toView:(UIView *)view delay:(CGFloat)delay{
    [self show:message icon:nil view:view delay:delay];
}

#pragma mark - 显示信息，有图标
+ (void)kh_showSuccess{
    [self kh_showSuccess:@"成功" toView:nil];
}

+ (void)kh_showSuccess:(NSString *)success{
    [self kh_showSuccess:success toView:nil];
}

+ (void)kh_showSuccess:(NSString *)success toView:(UIView *)view{
    static UIImage *successImg = nil;
    if (successImg == nil) {
        successImg = [KHTools kh_getToolsBundleImage:@"KHProgressHUD_kh_success"];
    }
    [self show:success icon:successImg view:view];
}

+ (void)kh_showFailure{
    [self kh_showFailure:@"失败" toView:nil];
}

+ (void)kh_showFailure:(NSString *)failure{
    [self kh_showFailure:failure toView:nil];
}

+ (void)kh_showFailure:(NSString *)failure toView:(UIView *)view {
    static UIImage *failureImg = nil;
    if (failureImg == nil) {
        failureImg = [KHTools kh_getToolsBundleImage:@"KHProgressHUD_kh_failure"];
    }
    [self show:failure icon:failureImg view:view];
}

+ (void)show:(NSString *)message icon:(UIImage *)icon view:(UIView *)view{
    [self show:message icon:icon view:view delay:1.4f];
}

+ (void)show:(NSString *)message icon:(UIImage *)icon view:(UIView *)view delay:(CGFloat)Delay {
    //隐藏loadView
    [self hideHUDForView:view animated:YES];
    [self hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
    
    //快速显示一个提示信息
    KHProgressHUD *hud = [KHProgressHUD showHUDAddedTo:view == nil ? [UIApplication sharedApplication].keyWindow : view animated:YES];
    
    if (view != nil && view.frame.size.height != [UIScreen mainScreen].bounds.size.height) {
        hud.yOffset = -32;
    }
    
    hud.detailsLabelText = [NSString stringWithFormat:@"%@", message];
    hud.detailsLabelFont = KHBoldFont(16.0f);
    //设置图片
    if (icon != nil){
        hud.customView = [[UIImageView alloc] initWithImage:icon];
        hud.minSize = CGSizeMake(100.f, 100.f);
    }
    //再设置模式
    hud.userInteractionEnabled = NO;
    hud.mode = KHProgressHUDModeCustomView;
    hud.margin = 10.f;
    //隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    //Delay秒之后再消失
    [hud hide:YES afterDelay:Delay];
}

#pragma mark - 显示加载状态
+ (KHProgressHUD *)kh_showLoad:(NSString *)message{
    return [self kh_showLoad:message toView:nil];
}

+ (KHProgressHUD *)kh_showLoad:(NSString *)message toView:(UIView *)view {
    return [self kh_showLoad:message toView:view delay:DEFAULT_DELAY];
}

#pragma mark -- 显示加载状态 自定义时间
+ (KHProgressHUD *)kh_showLoad:(NSString *)message toView:(UIView *)view delay:(CGFloat)delay{
    
    //快速显示一个提示信息
    KHProgressHUD *hud = [KHProgressHUD showHUDAddedTo:view == nil ? [UIApplication sharedApplication].keyWindow : view animated:YES];
    
    if (view != nil && view.frame.size.height != [UIScreen mainScreen].bounds.size.height) {
        hud.yOffset = -32;
    }
    
    hud.detailsLabelText = [NSString stringWithFormat:@"%@", message];
    hud.detailsLabelFont = KHBoldFont(16.0f);
    //隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    //YES代表需要蒙版效果
    hud.dimBackground = NO;
    
    //无论如何，菊花要消失
    [hud hide:YES afterDelay: delay > 0 ? delay : DEFAULT_DELAY];
    
    return hud;
}

+ (void)kh_hideHUDForView:(UIView *)view{
    [self hideHUDForView:view animated:YES];
}

+ (void)kh_hideHUD{
    [self hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
}

@end


