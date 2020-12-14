//
//  KHServicesResolve.h
//  KHealthDoctor
//
//  Created by 李云新 on 2018/10/22.
//  Copyright © 2018年 lambert. All rights reserved.
//
//  解析网络访问的数据用的

#import <Foundation/Foundation.h>
#import "KHServicesMacro.h"
#import "KHServicesTask.h"

@interface KHServicesResolve : NSObject


/**
 对网络回参进行解析

 @param dataType 期望返回的Content类型
 @param data 数据
 @param error 错误
 @param cBlock 回参解析完成后的回调
 */
+ (void)resolveWithDataType:(Class)dataType Task:(KHServicesTask *)task Data:(NSData *)data Error:(NSError *)error CompleteBlock:(KHServicesAnyOption)cBlock;

@end



