//
//  KHServices.h
//  KHealthDoctor
//
//  Created by 李云新 on 2018/10/19.
//  Copyright © 2018年 lambert. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KHServicesTask.h"
#import "KHServicesMacro.h"
#import "KHServicesResolve.h"

///网络访问
@interface KHServices : NSObject

///网络访问Session - 请不要修改
@property (nonatomic, strong, readonly) NSURLSession *session;

///网络访问单例
+ (instancetype)share;

///网络访问公共参数 - 放在header
@property (nonatomic, strong, readonly) NSMutableDictionary *publicParam;
///公共处理code字典组
@property (nonatomic, strong) NSDictionary *publicActionCodeDict;
///公共处理代理
@property (nonatomic,   weak) id<KHServicesPublicActionDelegate> publicActionDelegate;

///网络访问，返回数据为字典模式
- (void)requestWithTask:(KHServicesTask *)task
           DictComplete:(KHServicesDictOption)completeBlock;

///网络访问，返回数据为数组模式
- (void)requestWithTask:(KHServicesTask *)task
          ArrayComplete:(KHServicesArrayOption)completeBlock;

///网络访问，返回数据为指定类型模式
- (void)requestWithTask:(KHServicesTask *)task
               DataType:(Class)dataType
            AnyComplete:(KHServicesAnyOption)completeBlock;

@end


#pragma mark - 设置公共参数的分类
@interface KHServices (SetPubParamCategory)

- (void)kh_removePublicParam;

- (void)kh_setPublicParamWithToken:(NSString *)token;

@end
