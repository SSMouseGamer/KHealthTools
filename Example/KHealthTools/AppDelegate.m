//
//  AppDelegate.m
//  KHealthTools
//
//  Created by 李云新 on 2018/8/8.
//  Copyright © 2018年 lambert. All rights reserved.
//

#import "AppDelegate.h"
#import "KHStartController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    self.window.rootViewController = [[KHStartController alloc] init];
    
    return YES;
}

@end
