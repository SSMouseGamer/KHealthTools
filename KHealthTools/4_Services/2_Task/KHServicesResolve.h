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

@interface KHServicesResolve : NSObject

///数据解析
+ (void)resolveWithDataType:(Class)dataType
                       Data:(NSData *)data
                   Response:(NSURLResponse *)response
                      Error:(NSError *)error
              CompleteBlock:(KHServicesAnyOption)cBlock;

@end



