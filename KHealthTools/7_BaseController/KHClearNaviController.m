//
//  KHClearNaviController.m
//  KHealthModules
//
//  Created by 李云新 on 2018/10/12.
//

#import "KHealthToolsHeader.h"
#import "KHClearNaviController.h"

@interface KHClearNaviController ()

@end

@implementation KHClearNaviController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self kh_setNaviStyle:1];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self kh_setNaviStyle:1];
}

@end
