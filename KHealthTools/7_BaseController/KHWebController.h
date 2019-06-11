//
//  KHWebController.h
//  KHealthDoctor
//
//  Created by 李云新 on 2018/8/16.
//  Copyright © 2018年 lambert. All rights reserved.
//

#import "KHViewController.h"
#import <WebKit/WebKit.h>

@interface KHWebController : KHViewController

@property (nonatomic, strong) WKWebView *webView;

- (instancetype)initWithUrl:(NSString *)urlStr;

@end
