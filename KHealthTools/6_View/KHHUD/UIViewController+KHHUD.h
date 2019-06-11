//
//  UIViewController+KHHUD.h
//
//  Created by Lambert on 16/7/13.
//  Copyright © 2016年 Lambert. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (KHHUD)

- (void)kh_showSuccess;
- (void)kh_showSuccess:(NSString *)success;

- (void)kh_showFailure;
- (void)kh_showFailure:(NSString *)failure;

- (void)kh_showMessage:(NSString *)message;
- (void)kh_showMessage:(NSString *)message delay:(CGFloat)delay;

- (void)kh_showLoad;
- (void)kh_showLoad:(NSString *)message;
- (void)kh_showLoad:(NSString *)message delay:(CGFloat)delay;

- (void)kh_hideHUD;

@end
