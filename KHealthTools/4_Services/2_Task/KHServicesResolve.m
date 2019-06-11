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
+ (void)resolveWithDataType:(Class)dataType Data:(NSData *)data Response:(NSURLResponse *)response Error:(NSError *)error CompleteBlock:(KHServicesAnyOption)cBlock {
    
    //处理参数
    id dData;
    BOOL   success = NO;
    NSInteger code = -1;
    NSString  *msg = @"出错啦，请稍后再试～";
    
    if (data != nil) {
        NSDictionary *baseDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        
        success = [[baseDict objectForKey:@"success"] boolValue];
        dData   = [baseDict objectForKey:@"content"];
        msg     = [baseDict objectForKey:@"message"];
        code    = [[baseDict objectForKey:@"code"] integerValue];
    } else {
        code = error == nil ? -1 : error.code;
        msg = code == -1001 ? @"网络开了小差，请稍后再试～" : error.localizedDescription;
    }
    
    if (!dData || [dData isKindOfClass:[NSNull class]] || ![dData isKindOfClass:dataType]) {
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

///result模式解析数据
//+ (void)resolveResultWithDataType:(Class)dataType
//                             Data:(NSData *)data
//                         Response:(NSURLResponse *)response
//                            Error:(NSError *)error
//                    CompleteBlock:(KHServicesAnyOption)cBlock {
//    //处理参数
//    id dData;
//    BOOL   success = NO;
//    NSInteger code = error == nil ? -1 : error.code;
//    NSString  *msg = error == nil ? @"访问错误" : error.localizedDescription;
//
//    if (data != nil) {
//        //首先要有数据
//        NSDictionary *baseDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
//
//        id result = [baseDict objectForKey:@"result"];
//
//        if (result != nil) {
//            code    = [result integerValue];
//            success = code >= 0 ? YES : NO;
//            dData   = [baseDict objectForKey:@"resultData"];
//            msg     = [baseDict objectForKey:@"resultDesc"];
//
//        } else {
//            success = NO;
//            code    = [[baseDict objectForKey:@"status"] integerValue];
//            msg     = [NSString stringWithFormat:@"%@\n%@", [baseDict objectForKey:@"error"], [baseDict objectForKey:@"message"]];
//        }
//    }
//
//    if (!dData || [dData isEqual:[NSNull null]] || ![dData isKindOfClass:dataType]) {
//        dData = [[dataType alloc] init];
//    }
//
//    dispatch_async(dispatch_get_main_queue(), ^{
//        //1.触发公共处理
//        if ([KHServices share].publicActionCodeDict[@(code)] != nil) {
//            if ([[KHServices share].publicActionDelegate respondsToSelector:@selector(kh_SerVicesPublicActionWithCode:Message:)]) {
//                //1.1 回调报错
//                if (cBlock) {
//                    cBlock(dData, NO, code, nil);
//                }
//
//                //1.2 公共处理
//                [[KHServices share].publicActionDelegate kh_SerVicesPublicActionWithCode:code Message:msg];
//                return;
//            }
//        }
//
//        //2.没有，正常返回
//        if (cBlock) {
//            cBlock(dData, success, code, msg);
//        }
//    });
//}

@end

