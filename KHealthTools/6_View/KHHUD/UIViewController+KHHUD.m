//
//  UIViewController+KHHUD.m
//
//  Created by Lambert on 16/7/13.
//  Copyright © 2016年 Lambert. All rights reserved.
//

#import "UIViewController+KHHUD.h"
#import "KHHUD.h"

@implementation UIViewController (KHHUD)

- (void)kh_showSuccess{
    [KHHUD kh_showSuccess:@"成功" toView:self.view];
}

- (void)kh_showSuccess:(NSString *)success{
    [KHHUD kh_showSuccess:success toView:self.view];
}

- (void)kh_showFailure{
    [KHHUD kh_showFailure:@"失败" toView:self.view];
}

- (void)kh_showFailure:(NSString *)failure{
    [KHHUD kh_showFailure:failure toView:self.view];
}

- (void)kh_showMessage:(NSString *)message{
    [KHHUD kh_showMessage:message toView:self.view];
}

- (void)kh_showMessage:(NSString *)message delay:(CGFloat)delay{
    [KHHUD kh_showMessage:message toView:self.view delay:delay];
}

- (void)kh_showLoad{
    [KHHUD kh_showLoadToView:self.view];
}

- (void)kh_showLoad:(NSString *)message{
    [KHHUD kh_showLoad:message toView:self.view];
}

- (void)kh_showLoad:(NSString *)message delay:(CGFloat)delay{
    [KHHUD kh_showLoad:message toView:self.view delay:delay];
}

- (void)kh_hideHUD{
    [KHHUD kh_hideHUDForView:self.view];
}
@end
