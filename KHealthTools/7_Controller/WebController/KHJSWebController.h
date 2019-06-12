//
//  KHJSWebController.h
//  KHealthModules
//
//  Created by kim on 2019/5/20.
//  Copyright © 2019年 李云新. All rights reserved.
//

#import "KHViewController.h"
#import <WebKit/WebKit.h>

@interface KHJSWebController : KHViewController

@property (nonatomic, copy) NSString *i_urlStr;

- (void)setupSubView;

///注册监听的js方法
- (void)kh_registerFunc:(NSArray <NSString *>*)funcNameArray;

/**
 运行js方法

 @param funcName js方法名 例如：test 不准带括号
 @param param 方法参数
 */
- (void)kh_runJSCriptWithFunc:(NSString *)funcName Param:(NSDictionary *)param;

///相应js方法唤起原生方法
- (void)kh_actionWithFunc:(NSString *)funcName;

///加载完成后调用
- (void)kh_webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation;

@end
