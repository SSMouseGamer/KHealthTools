//
//  AppDelegate.m
//  KHealthTools
//
//  Created by 李云新 on 2018/8/8.
//  Copyright © 2018年 lambert. All rights reserved.
//

#import "AppDelegate.h"
#import "KHStartController.h"

@interface AppDelegate ()<KHServicesPublicActionDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    self.window.rootViewController = [[KHStartController alloc] init];
    
    //网络访问公共错误处理
    [KHServices share].publicActionCodeDict = @{@(401):@"重新登录"};
    [KHServices share].publicActionDelegate = self;
    
    return YES;
}

- (void)kh_ServicesPublicActionWithCode:(NSInteger)code Message:(NSString *)message {
    KHLog(@"code %ld, message %@", (long)code, message);
}

- (void)kh_ServicesCustomResolveWithDataType:(Class)dataType Data:(NSData *)data Error:(NSError *)error CompleteBlock:(KHServicesAnyOption)cBlock {
    KHLog(@"请自己处理");
}

@end
