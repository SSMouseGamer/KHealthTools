//
//  KHServicesMacro.h
//  Pods
//
//  Created by 李云新 on 2018/10/23.
//

#ifndef KHServicesMacro_h
#define KHServicesMacro_h

///字典模式 - 数据回调
typedef void (^KHServicesDictOption)(NSDictionary *jDict, BOOL success, NSInteger code, NSString *msg);
///数组模式 - 数据回调
typedef void (^KHServicesArrayOption)(NSArray *jArray, BOOL success, NSInteger code, NSString *msg);
///任意模式 - 数据回调
typedef void (^KHServicesAnyOption)(id anyData, BOOL success, NSInteger code, NSString *msg);

///网络访问的全局处理
@protocol KHServicesPublicActionDelegate<NSObject>
- (void)kh_ServicesPublicActionWithCode:(NSInteger)code Message:(NSString *)message;
@end

#endif /* KHServicesMacro_h */
