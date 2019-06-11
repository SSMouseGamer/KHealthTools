//
//  KHServicesTask.m
//  KHealthDoctor
//
//  Created by 李云新 on 2018/10/19.
//  Copyright © 2018年 lambert. All rights reserved.
//

#import "KHServicesTask.h"
#import "KHealthToolsMacro.h"
#import "KHServicesConfig.h"
#import "KHServices.h"

@implementation KHServicesTask

#pragma mark - 初始化
///生成请求，请设置method
+ (instancetype)path:(NSString *)path Param:(NSDictionary *)param {
    KHServicesTask *task = [[self alloc] init];
    task.path  = path;
    task.param = param;
    return task;
}

///生成post请求
+ (instancetype)postPath:(NSString *)path Param:(NSDictionary *)param {
    KHServicesTask *task = [self path:path Param:param];
    task.method = @"POST";
    return task;
}

///生成get请求
+ (instancetype)getPath:(NSString *)path Param:(NSDictionary *)param {
    KHServicesTask *task = [self path:path Param:param];
    task.method = @"GET";
    return task;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.doMain = nil;
        self.path   = @"";
        self.method = nil;
        self.param  = @{};
        self.is_Body_Params  = YES;
        self.timeOutInterval = 5;
    }
    return self;
}

- (void)dealloc {
    KHLog(@"网络访问Task - 释放 - %@", self.path);
}

#pragma mark - 获取访问参数
///生成访问的request
- (NSMutableURLRequest *)getReuqest {
    //1.拿到域名
    NSString *doMain = [self getDoMain];
    if (doMain == nil) {
        return nil;
    }
    
    //2.生成request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    request.timeoutInterval = MAX(5, self.timeOutInterval);
 
    //3.确定接口地址
    NSString *urlStr = [doMain stringByAppendingString:self.path];
    
    //4.设置method
    [request setHTTPMethod:self.method];
    
    //5.设置公共参数
    [request setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    for (NSString *key in [KHServices share].publicParam.allKeys) {
        [request setValue:[KHServices share].publicParam[key] forHTTPHeaderField:key];
    }
    
    //6.设置参数
    if (self.is_Body_Params && ![self.method isEqualToString:@"GET"]) {
        //放在body里面
        if (self.param.allKeys.count > 0) {
            [request setHTTPBody:[NSJSONSerialization dataWithJSONObject:self.param     options:NSJSONWritingPrettyPrinted error:nil]];
        }
    } else {
        //放在域名后面
        NSString *paramStr = [self getParamsStrWithParams:self.param];
        if (paramStr.length != 0) {
            paramStr = [NSString stringWithFormat:@"?%@",paramStr];
        }
        urlStr = [NSString stringWithFormat:@"%@%@", urlStr, paramStr];
    }
    
    //7.设置定URL
    NSString *encodingUrl = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [request setURL:[NSURL URLWithString:encodingUrl]];
    
    return request;
}


#pragma mark -
///确认Mask是否可用
- (NSString *)getDoMain {
    ///拼接好网络访问的Url
    NSString *doMain = self.doMain;
    if (doMain == nil) {
        doMain = [KHServicesConfig doMain];
    }
    
    ///确认method
    if (self.method == nil) {
        KHLog(@"网络访问Task - 你没有指定method");
        return nil;
    }
    
    return doMain;
}

///GET请求参数格式化字符串
- (NSString *)getParamsStrWithParams:(NSDictionary *)param {
    if (param == nil) {
        return @"";
    }
    
    NSArray *allKey = param.allKeys;
    if (allKey.count == 0) {
        return @"";
    }
    
    NSString *pStr = @"";
    for (int i = 0; i < allKey.count; i++) {
        NSString *key = allKey[i];
        if (i < allKey.count - 1) {
            pStr = [pStr stringByAppendingFormat:@"%@=%@&",key,param[key]];
        } else {
            pStr = [pStr stringByAppendingFormat:@"%@=%@",key,param[key]];
        }
    }
    return pStr;
}

@end
