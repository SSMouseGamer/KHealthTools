//
//  KHServicesTask.h
//  KHealthDoctor
//
//  Created by 李云新 on 2018/10/19.
//  Copyright © 2018年 lambert. All rights reserved.
//
//  网络访问的任务定义

#import <Foundation/Foundation.h>
#import "KHServicesMacro.h"

@interface KHServicesTask : NSObject

///域名 - 默认为nil。如果为nil，则在Servcices中使用默认域名
@property (nonatomic,   copy) NSString *doMain;
///地址 - 必须
@property (nonatomic,   copy) NSString *path;
///访问模式 - 必须 - GET、POST、DELETE等
@property (nonatomic,   copy) NSString *method;

///访问参数 - 默认为@{}
@property (nonatomic, strong) NSDictionary *param;
///访问等待时间，默认为5
@property (nonatomic, assign) NSInteger timeOutInterval;

///访问参数是否放在Body，默认为YES，放在Body里
@property (nonatomic, assign) BOOL is_Body_Params;

#pragma mark - 初始化
///生成请求，请设置method
+ (instancetype)path:(NSString *)path Param:(NSDictionary *)param;
///生成post请求
+ (instancetype)postPath:(NSString *)path Param:(NSDictionary *)param;
///生成get请求
+ (instancetype)getPath:(NSString *)path Param:(NSDictionary *)param;

#pragma mark - 生成访问的request
///生成访问的request
- (NSMutableURLRequest *)getReuqest;

@end
