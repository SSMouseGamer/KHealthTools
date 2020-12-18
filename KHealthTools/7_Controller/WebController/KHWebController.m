//
//  KHWebController.m
//  KHealthDoctor
//
//  Created by 李云新 on 2018/8/16.
//  Copyright © 2018年 lambert. All rights reserved.
//

#import "KHealthToolsHeader.h"
#import "KHWebController.h"

@interface KHWebController () <WKNavigationDelegate>

@property (nonatomic,   copy) NSString *urlStr;

@end

@implementation KHWebController

- (instancetype)initWithUrl:(NSString *)urlStr {
    self = [super init];
    if (self){
        self.urlStr = urlStr;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView = [[WKWebView alloc] initWithFrame:self.kh_Rect];
    self.webView.navigationDelegate = self;
    [self.view addSubview:self.webView];
    
    NSString *encodingUrl = [[NSString kh_str:self.urlStr Normal:@""] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [[NSURL alloc] initWithString:encodingUrl];
    if (url) {
        [self kh_showLoad];
        [self.webView loadRequest:[[NSURLRequest alloc] initWithURL:url]];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)backBtnClick:(UIButton *)btn {
    if (self.webView.canGoBack) {
        [self.webView goBack];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [self kh_hideHUD];
}

-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [self kh_hideHUD];
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [self kh_hideHUD];
}

@end


