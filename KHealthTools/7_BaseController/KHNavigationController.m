//
//  KHNavigationController.m
//  KHealthModules
//
//  Created by 李云新 on 2018/10/12.
//

#import "KHealthToolsHeader.h"
#import "KHNavigationController.h"

@interface KHNavigationController ()

@end

@implementation KHNavigationController

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    viewController.hidesBottomBarWhenPushed = YES;
    [super pushViewController:viewController animated:animated];
}

@end
