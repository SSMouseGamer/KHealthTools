//
//  KHJSWebController.m
//  KHealthModules
//
//  Created by kim on 2019/5/20.
//  Copyright © 2019年 李云新. All rights reserved.
//

#import "KHJSWebController.h"
#import "KHealthToolsHeader.h"

@interface KHJSWebController ()<WKScriptMessageHandler,WKNavigationDelegate,WKUIDelegate>

@property(nonatomic,strong) WKWebView *webView;

@property (nonatomic, strong) UIProgressView *progressView;

@end

@implementation KHJSWebController

- (void)kh_runJSCriptWithFunc:(NSString *)funcName Param:(NSDictionary *)param {
    if (!funcName || [funcName isKindOfClass:[NSNull class]]) {
        return;
    }
    NSString *jsStr = funcName;
    if (param && param.allValues.count > 0) {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:param options:0 error:&error];
        NSString *paramJsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        jsStr = [jsStr stringByAppendingFormat:@"(%@)",paramJsonStr];
    } else {
        jsStr = [jsStr stringByAppendingString:@"()"];
    }
    [self.webView evaluateJavaScript:jsStr completionHandler:^(id _Nullable obj, NSError * _Nullable error) {
        if (error) {
            KHLog(@"%@", error.localizedDescription);
        }
    }];
}

- (void)kh_registerFunc:(NSArray<NSString *> *)funcNameArray {
    for (NSString *funcName in funcNameArray) {
        [self.webView.configuration.userContentController addScriptMessageHandler:self name:funcName];
    }
}

- (void)kh_webView:(WKWebView *)webView didFinishNavigation:(WKNavigation*)navigation{}

- (void)kh_actionWithFunc:(NSString *)funcName{}

#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    [self kh_actionWithFunc:message.name];
}

#pragma mark - UI life
- (void)dealloc {
    [self.webView.configuration.userContentController removeAllUserScripts];
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView setNavigationDelegate:nil];
    [self.webView setUIDelegate:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubView];
}

- (void)setupSubView {
    //配置信息
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc]init];
    _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, self.kh_W, self.kh_H)
                                 configuration:config];
    _webView.UIDelegate         = self;
    _webView.navigationDelegate = self;
    
    //设置UA
    NSDate *date                = [NSDate date];
    NSTimeInterval interval     = date.timeIntervalSince1970;
    unsigned long long ti       = interval * 1000;
    NSNumber *timeInterval      = [NSNumber numberWithUnsignedLongLong:ti];
    NSString *userAgent         = [NSString stringWithFormat:@"KHealth_iOS_Safari_WKWebKit_%@", timeInterval];
    _webView.customUserAgent    = userAgent;
    
    [self.view addSubview:_webView];
    NSString *urlStr = self.i_urlStr ?: @"";
    NSURL *url = [NSURL URLWithString:urlStr];
    [_webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
    
    self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, KHScreenWidth, KHMargin)];
    self.progressView.progressTintColor = KHColorTheme;
    self.progressView.trackTintColor = KHColorEAEAEA;
    [self.webView addSubview:self.progressView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

#pragma mark - WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [self kh_webView:webView didFinishNavigation:navigation];
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation {
    
}
// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    
}
// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    decisionHandler(WKNavigationResponsePolicyAllow);
}
// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
//    NSString *urlStr = navigationAction.request.URL.absoluteString;
//
//    if ([webView.URL.absoluteString isEqualToString:urlStr]) {
//        decisionHandler(WKNavigationActionPolicyAllow);
//        return;
//    }
    
    decisionHandler(WKNavigationActionPolicyAllow);
}

-(void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    KHLog(@"WEB弹框信息:%@",message);
    completionHandler();
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if(navigationType==UIWebViewNavigationTypeLinkClicked){
        return NO;
    }
    return YES;
}

#pragma mark - observe
///加载进度监听
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqual:@"estimatedProgress"] && object == self.webView) {
        [self.progressView setAlpha:1.0f];
        [self.progressView setProgress:self.webView.estimatedProgress animated:YES];
        if (self.webView.estimatedProgress >= 1.0f) {
            [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.progressView setAlpha:0.0f];
            } completion:^(BOOL finished) {
                [self.progressView setProgress:0.0f animated:YES];
            }];
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
