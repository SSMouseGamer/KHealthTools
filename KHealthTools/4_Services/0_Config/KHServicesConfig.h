//
//  KHServicesConfig.h
//  KHealthTools
//
//  Created by 李云新 on 2018/11/13.
//
//  需要配置kh_services_domain_config.plist
//  @{@"domain"           :@"主域名",
//    @"h5domain"         :@"H5拼接的域名",
//    @"imsdkappid"       :@"IM的AppID",
//    @"imbusiid"         :@"IM的推送ID",
//    @"imbusiiddebug"    :@"IM的开发模式推送ID"}

#import <Foundation/Foundation.h>

@interface KHServicesConfig : NSObject

///获取配置字典
+ (NSDictionary *)getConfigDict;

///获取到网络访问的域名
+ (NSString *)doMain;
///获取拼接H5的域名
+ (NSString *)H5DoMain;

///获取IMSDK的AppID
+ (NSString *)IMSDKAppID;
///获取IMSDK的推送ID
+ (NSString *)IMSDKBusiID;
///获取IMSDK的开发模式推送ID
+ (NSString *)IMSDKBusiID_DEBUG;

@end
