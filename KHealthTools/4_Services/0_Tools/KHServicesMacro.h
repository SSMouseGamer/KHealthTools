//
//  KHServicesMacro.h
//  Pods
//
//  Created by 李云新 on 2018/10/23.
//

#ifndef KHServicesMacro_h
#define KHServicesMacro_h

typedef NS_ENUM(NSInteger, KHServiceContentType) {
    KHServiceContentTypeJson = 0,
    KHServiceContentTypeFormData = 1
};

///字典模式 - 数据回调
typedef void (^KHServicesDictOption)(NSDictionary *jDict, BOOL success, NSInteger code, NSString *msg);
///数组模式 - 数据回调
typedef void (^KHServicesArrayOption)(NSArray *jArray, BOOL success, NSInteger code, NSString *msg);
///任意模式 - 数据回调
typedef void (^KHServicesAnyOption)(id anyData, BOOL success, NSInteger code, NSString *msg);
///分页模式 - 数据回调
typedef void (^KHServicePageOption)(NSArray *jArray, BOOL isMore, BOOL success, NSInteger code, NSString *msg);

///网络访问的全局处理
@protocol KHServicesPublicActionDelegate<NSObject>
///公共处理
- (void)kh_ServicesPublicActionWithCode:(NSInteger)code Message:(NSString *)message;
@optional
///自定义回参解析 - 如果实现了该代理，KHServicesResolve将失效
- (void)kh_ServicesCustomResolveWithDataType:(Class)dataType Task:(NSObject *)task Data:(NSData *)data Error:(NSError *)error CompleteBlock:(KHServicesAnyOption)cBlock;
@end

#endif /* KHServicesMacro_h */
