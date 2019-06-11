//
//  UIAlertController+KHTsCategory.h
//  KHealthMember
//
//  Created by 李云新 on 2018/12/7.
//  Copyright © 2018年 李云新. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ __nullable KHAlertOption)(UIAlertAction *action);

@interface UIAlertController (KHTsCategory)

+ (instancetype)kh_alertWithTitle:(NSString *)title Message:(NSString *)message
                         Complete:(KHAlertOption)completeOption;

+ (instancetype)kh_alertWithTitle:(NSString *)title Message:(NSString *)message
                    CompleteTitle:(NSString *)cTitle Complete:(KHAlertOption)completeOption;

+ (instancetype)kh_alertWithTitle:(NSString *)title Message:(NSString *)message
                    CompleteTitle:(NSString *)cTitle Complete:(KHAlertOption)completeOption
                      CanCelTitle:(NSString *)aTitle CanCel:(KHAlertOption)canCelOption;
///只展示单个按钮的提示
+ (instancetype)kh_simpleAlertWithTitle:(NSString *)title Message:(NSString *)message
                          CompleteTitle:(NSString *)cTitle Complete:(KHAlertOption)completeOption;

@end

#pragma mark -
@interface UIViewController (KHTsAVCCategory)

- (void)kh_alertWithTitle:(NSString *)title Message:(NSString *)message
                 Complete:(KHAlertOption)completeOption;

- (void)kh_alertWithTitle:(NSString *)title Message:(NSString *)message
            CompleteTitle:(NSString *)cTitle Complete:(KHAlertOption)completeOption;
///只展示单个按钮的提示
- (void)kh_simpleAlertWithTitle:(NSString *)title  Message:(NSString *)message
                  CompleteTitle:(NSString *)cTitle Complete:(KHAlertOption)completeOption;

@end

#pragma mark -
@interface UIView (KHTsAViewCategory)

- (void)kh_alertWithTitle:(NSString *)title Message:(NSString *)message
                 Complete:(KHAlertOption)completeOption;

- (void)kh_alertWithTitle:(NSString *)title Message:(NSString *)message
            CompleteTitle:(NSString *)cTitle Complete:(KHAlertOption)completeOption;

///只展示单个按钮的提示
- (void)kh_simpleAlertWithTitle:(NSString *)title  Message:(NSString *)message
                  CompleteTitle:(NSString *)cTitle Complete:(KHAlertOption)completeOption;

@end
