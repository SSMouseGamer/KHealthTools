//
//  KHViewController.m
//  KHealthModules
//
//  Created by 李云新 on 2018/10/12.
//

#import "KHealthToolsHeader.h"
#import "KHViewController.h"

@interface KHViewController ()

@end

@implementation KHViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self kh_setNaviStyle:0];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self kh_setNaviStyle:0];
}

@end
