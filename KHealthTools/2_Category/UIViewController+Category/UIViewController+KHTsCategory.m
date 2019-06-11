//
//  UIViewController+KHTsCategory.m
//  AFNetworking
//
//  Created by 李云新 on 2018/12/8.
//

#import "KHealthToolsHeader.h"
#import "UIViewController+KHTsCategory.h"

@implementation UIViewController (KHTsCategory)

///添加键盘的监听
- (void)kh_addKeyBoardNoti {
    //1、显示键盘的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //2、隐藏键盘的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark 显示一个新的键盘就会调用
- (void)keyboardWillShow:(NSNotification *)note{
    
    UIView *responderField = [self findTextView];
    CGRect  fieldRect = [responderField convertRect:responderField.frame toView:self.view];
    CGFloat fieldMaxY = CGRectGetMaxY(fieldRect) + KH_Navi_Height + KH15Margin;
    
    CGFloat keyboardY = [[note.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
    
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    if (duration <= 0.0) {
        duration = 0.25;
    }
    
    [UIView animateWithDuration:duration animations:^{
        if (fieldMaxY > keyboardY) {
            // 键盘挡住了文本框
            self.view.transform = CGAffineTransformMakeTranslation(0, keyboardY - fieldMaxY);
            
        } else {
            // 没有挡住文本框
            self.view.transform = CGAffineTransformIdentity;
            
        }
    }];
}

#pragma mark 找到获取焦点的View
- (UIView *)findTextView{
    UIView *textView = nil;
    NSArray *viewArray = self.view.subviews;
    
    for (UIWindow *window in viewArray){
        
        textView = [self findTextViewInView:window];
        if (textView){
            return textView;
        }
    }
    return nil;
}

#pragma mark 找到获取焦点的View2.0
- (UIView *)findTextViewInView:(UIView *)view{
    
    for (UIView *subView in view.subviews){
        if (subView.isFirstResponder){
            return subView;
            
        }else{
            UIView *tempView = [self findTextViewInView:subView];
            if (tempView){
                return tempView;
            }
        }
    }
    return nil;
}

#pragma mark 隐藏键盘就会调用
- (void)keyboardWillHide:(NSNotification *)note{
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        self.view.transform = CGAffineTransformIdentity;
    }];
}

#pragma mark - 设置导航栏风格
/**
 设置导航栏风格
 
 @param style 0:黑字，黑状态栏；1:白字，白状态栏；2:白字，黑状态栏；3:透明字，白状态栏
 */
- (void)kh_setNaviStyle:(KHNAV_STYLE)style {
    switch (style) {
        case KHNAV_STYLE_B_B:
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
            [self setNaviBarWithTintColor:[KHTools kh_getNaviTitleColor]];
            break;
        case KHNAV_STYLE_W_W:
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
            [self setNaviBarWithTintColor:[UIColor whiteColor]];
            break;
        case KHNAV_STYLE_W_B:
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
            [self setNaviBarWithTintColor:[UIColor whiteColor]];
            break;
        case KHNAV_STYLE_W_C:
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
            [self setNaviBarWithTintColor:[UIColor clearColor]];
    }
}

- (void)setNaviBarWithTintColor:(UIColor *)tintColor {
    //1.tintColor
    self.navigationController.navigationBar.tintColor = tintColor;
    
    //2.导航栏title
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:tintColor, NSFontAttributeName:[KHTools kh_getNaviTitleFont]};
    
    //3.设置导航栏背景
    static UIImage *clearBgImage = nil;
    if (clearBgImage == nil) {
        clearBgImage = [[UIColor clearColor] kh_getImageWithSize:CGSizeMake(KHScreenWidth, KH_Navi_Height)];
    }
    [self.navigationController.navigationBar setBackgroundImage:clearBgImage forBarMetrics:UIBarMetricsDefault];
    
    //4.导航栏底部那条线
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    //5.返回按钮图标
    self.navigationController.navigationBar.backIndicatorImage = [KHTools kh_getImage_naviBack];
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage = [KHTools kh_getImage_naviBack];
}

@end
