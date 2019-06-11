//
//  KHServices.m
//  KHealthDoctor
//
//  Created by 李云新 on 2018/10/19.
//  Copyright © 2018年 lambert. All rights reserved.
//

#import "KHServices.h"
#import "KHealthToolsMacro.h"

@interface KHServices ()<NSURLSessionDelegate>

///网络访问配置
@property (nonatomic, strong) NSURLSessionConfiguration *config;
///网络访问队列
@property (nonatomic, strong) NSOperationQueue *serQueue;
///网络访问的Request字典 - 请不要修改
@property (nonatomic, strong) NSMutableDictionary *requestDicts;

@end

@implementation KHServices

///网络访问，返回数据为字典模式
- (void)requestWithTask:(KHServicesTask *)task
           DictComplete:(KHServicesDictOption)completeBlock {
    
    [self requestWithTask:task DataType:[NSDictionary class] AnyComplete:completeBlock];
}

///网络访问，返回数据为数组模式
- (void)requestWithTask:(KHServicesTask *)task
          ArrayComplete:(KHServicesArrayOption)completeBlock {
    
    [self requestWithTask:task DataType:[NSArray class] AnyComplete:completeBlock];
}

///网络访问，返回数据为指定类型模式
- (void)requestWithTask:(KHServicesTask *)task
               DataType:(Class)dataType
            AnyComplete:(KHServicesAnyOption)completeBlock {
    
    //1.做一层拦截
    if ([KHServices share].requestDicts[task.path] != nil) {
        //1.2 若该请求正在进行，则不允许重复访问
        KHLog(@"KHServices - %@ - 该请求正在进行，此次请求不予执行", task.path);
        return;
    }
    
    //2.生成request信息
    NSURLRequest *request = [task getReuqest];
    if (request == nil) {
        if (completeBlock) {
            completeBlock([[dataType alloc] init], NO, -1, @"请稍后再试.");
        }
        return;
    }
    
    //3.缓存当前的请求
    KHLog(@"KHServices - %@",request);
    [[KHServices share].requestDicts setValue:@" " forKey:task.path];
    
    //4.生成访问的Task
    NSURLSessionDataTask *sessionDataTask = [self.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //处理缓存请求
        [[KHServices share].requestDicts removeObjectForKey:task.path];
        
        //处理数据
        [KHServicesResolve resolveWithDataType:dataType
                                          Data:data
                                      Response:response
                                         Error:error
                                 CompleteBlock:completeBlock];
    }];
    
    //5.fire
    [sessionDataTask resume];
}

#pragma mark - 初始化
+ (instancetype)share {
    static dispatch_once_t onceToken;
    static id instance;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        //0.参数初始化
        _publicParam = [NSMutableDictionary dictionary];
        
        //1.设置config
        self.config = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        //2.蜂窝网络是否继续请求
        //self.config.allowsCellularAccess = NO;
        
        //3.访问队列
        self.serQueue = [[NSOperationQueue alloc] init];
        
        //4.初始化Session
        _session = [NSURLSession sessionWithConfiguration:self.config delegate:self delegateQueue:self.serQueue];
        
        //5.初始化网络访问标记字典
        self.requestDicts = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    [session finishTasksAndInvalidate];
}

///不允许外部以KVC方式修改属性
+ (BOOL)accessInstanceVariablesDirectly {
    return NO;
}

@end

#pragma mark - 设置公共参数的分类
@implementation KHServices(SetPubParamCategory)

- (void)kh_removePublicParam {
    [self.publicParam removeAllObjects];
}

- (void)kh_setPublicParamWithToken:(NSString *)token {
    [self.publicParam setValue:token forKey:@"X-Authorization"];
}

@end

