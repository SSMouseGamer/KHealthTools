//
//  UIApplication+KHTsCategory.m
//  KHealthTools
//
//  Created by 李云新 on 2019/4/1.
//

#import "UIApplication+KHTsCategory.h"

@implementation UIApplication (KHTsCategory)

- (void)kh_setStatusBarHidden:(BOOL)b {
    [UIView animateWithDuration:0.15f animations:^{
        ((UIView *)[[UIApplication sharedApplication] valueForKey:@"statusBar"]).alpha = b ? 0.0 : 1.0;
    }];
}

@end
