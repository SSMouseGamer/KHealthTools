//
//  UIAlertController+KHTsCategory.m
//  KHealthMember
//
//  Created by 李云新 on 2018/12/7.
//  Copyright © 2018年 李云新. All rights reserved.
//

#import "UIAlertController+KHTsCategory.h"
#import "UIView+KHTsCategory.h"

@implementation UIAlertController (KHTsCategory)

+ (instancetype)kh_alertWithTitle:(NSString *)title Message:(NSString *)message
                         Complete:(KHAlertOption)completeOption {
    
    return [UIAlertController kh_alertWithTitle:title Message:message
                                  CompleteTitle:@"确定" Complete:completeOption];
}

+ (instancetype)kh_alertWithTitle:(NSString *)title Message:(NSString *)message
                    CompleteTitle:(NSString *)cTitle Complete:(KHAlertOption)completeOption {
    
    return [UIAlertController kh_alertWithTitle:title Message:message
                                  CompleteTitle:cTitle Complete:completeOption
                                    CanCelTitle:@"取消" CanCel:nil];
}

+ (instancetype)kh_alertWithTitle:(NSString *)title Message:(NSString *)message
                    CompleteTitle:(NSString *)cTitle Complete:(KHAlertOption)completeOption
                      CanCelTitle:(NSString *)aTitle CanCel:(KHAlertOption)canCelOption {
    
    UIAlertController *av = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:(UIAlertControllerStyleAlert)];
    [av addAction: [UIAlertAction actionWithTitle:aTitle style:(UIAlertActionStyleCancel) handler:canCelOption]];
    [av addAction: [UIAlertAction actionWithTitle:cTitle style:(UIAlertActionStyleDefault) handler:completeOption]];
    return av;
}

+ (instancetype)kh_simpleAlertWithTitle:(NSString *)title Message:(NSString *)message
                          CompleteTitle:(NSString *)cTitle Complete:(KHAlertOption)completeOption {
    UIAlertController *av = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:(UIAlertControllerStyleAlert)];
    [av addAction: [UIAlertAction actionWithTitle:cTitle style:(UIAlertActionStyleDefault) handler:completeOption]];
    return av;
}

@end

#pragma mark -
@implementation UIViewController (KHTsAVCCategory)

- (void)kh_alertWithTitle:(NSString *)title Message:(NSString *)message
                 Complete:(KHAlertOption)completeOption {
    
    UIAlertController *av = [UIAlertController kh_alertWithTitle:title Message:message Complete:completeOption];
    [self presentViewController:av animated:YES completion:nil];
}

- (void)kh_alertWithTitle:(NSString *)title Message:(NSString *)message
            CompleteTitle:(NSString *)cTitle Complete:(KHAlertOption)completeOption {
    
    UIAlertController *av = [UIAlertController kh_alertWithTitle:title Message:message
                                                   CompleteTitle:cTitle Complete:completeOption];
    [self presentViewController:av animated:YES completion:nil];
}

- (void)kh_simpleAlertWithTitle:(NSString *)title  Message:(NSString *)message
                  CompleteTitle:(NSString *)cTitle Complete:(KHAlertOption)completeOption {
    UIAlertController *av = [UIAlertController kh_simpleAlertWithTitle:title Message:message
                                                         CompleteTitle:cTitle Complete:completeOption];
    [self presentViewController:av animated:YES completion:nil];
}

@end

#pragma mark -
@implementation UIView (KHTsAViewCategory)

- (void)kh_alertWithTitle:(NSString *)title Message:(NSString *)message
                 Complete:(KHAlertOption)completeOption {
    
    UIAlertController *av = [UIAlertController kh_alertWithTitle:title Message:message Complete:completeOption];
    [[self kh_getViewController] presentViewController:av animated:YES completion:nil];
}

- (void)kh_alertWithTitle:(NSString *)title Message:(NSString *)message
            CompleteTitle:(NSString *)cTitle Complete:(KHAlertOption)completeOption {
    
    UIAlertController *av = [UIAlertController kh_alertWithTitle:title Message:message
                                                   CompleteTitle:cTitle Complete:completeOption];
    [[self kh_getViewController] presentViewController:av animated:YES completion:nil];
}

- (void)kh_simpleAlertWithTitle:(NSString *)title  Message:(NSString *)message
                  CompleteTitle:(NSString *)cTitle Complete:(KHAlertOption)completeOption {
    UIAlertController *av = [UIAlertController kh_simpleAlertWithTitle:title Message:message
                                                         CompleteTitle:cTitle Complete:completeOption];
    [[self kh_getViewController] presentViewController:av animated:YES completion:nil];
}

@end
