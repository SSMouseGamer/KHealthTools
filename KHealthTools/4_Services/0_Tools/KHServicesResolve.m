//
//  KHServicesResolve.m
//  KHealthDoctor
//
//  Created by 李云新 on 2018/10/22.
//  Copyright © 2018年 lambert. All rights reserved.
//

#import "KHServicesResolve.h"
#import "KHServices.h"

@implementation KHServicesResolve

///数据解析
+ (void)resolveWithDataType:(Class)dataType Task:(KHServicesTask *)task Data:(NSData *)data Error:(NSError *)error CompleteBlock:(KHServicesAnyOption)cBlock {
    
    if ([[KHServices share].publicActionDelegate respondsToSelector:@selector(kh_ServicesCustomResolveWithDataType:Task:Data:Error:CompleteBlock:)]) {
        [[KHServices share].publicActionDelegate kh_ServicesCustomResolveWithDataType:dataType Task:task Data:data Error:error CompleteBlock:cBlock];
        return;
    }
    
    //处理参数
    id dData;
    BOOL   success = NO;
    NSInteger code = -1;
    NSString  *msg = @"出错啦，请稍后再试～";
    
    if (data != nil) {
        NSDictionary *baseDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        
        success = [[baseDict objectForKey:task.businessSuccessKey] boolValue];
        dData   = [task.otherKey isEqualToString:@"0"] ? [baseDict objectForKey:task.businessDataKey] : baseDict;
        msg     = [baseDict objectForKey:task.msgKey];
        code    = [[baseDict objectForKey:task.codeKey] integerValue];
    } else {
        code = error == nil ? -1 : error.code;
        msg = code == -1001 ? @"网络开了小差，请稍后再试～" : error.localizedDescription;
    }
    if (![dData isKindOfClass:dataType] && ![task.otherKey isEqualToString:@"0"]) {
        dData = [[dataType alloc] init];
    }
    if (!dData || [dData isKindOfClass:[NSNull class]]) {
        dData = [[dataType alloc] init];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        //1.触发公共处理
        if ([KHServices share].publicActionCodeDict[@(code)] != nil) {
            if ([[KHServices share].publicActionDelegate respondsToSelector:@selector(kh_ServicesPublicActionWithCode:Message:)]) {
                //1.1 回调报错
                if (cBlock) {
                    cBlock(dData, NO, code, nil);
                }
                
                //1.2 公共处理
                [[KHServices share].publicActionDelegate kh_ServicesPublicActionWithCode:code Message:msg];
                return;
            }
        }
        
        //2.没有，正常返回
        if (cBlock) {
            cBlock(dData, success, code, msg);
        }
    });
}

@end

