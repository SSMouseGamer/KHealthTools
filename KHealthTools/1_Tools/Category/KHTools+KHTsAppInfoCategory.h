//
//  KHTools+KHTsAppInfoCategory.h
//  KHealthTools
//
//  Created by 李云新 on 2018/10/10.
//

#import "KHTools.h"

@interface KHTools (KHTsAppInfoCategory)

///跳转到AppID对应的App Store界面
+ (NSString *)kh_appStoreURLWithID:(NSString *)appid;
///下载AppID对应的App信息
+ (NSString *)kh_appStoreLookupURLWithID:(NSString *)appid;

///当前版本号
+ (NSString *)kh_appCurrentVersion;
///当前Bundle Version
+ (int)kh_CurrentBundle;

///AppName
+ (NSString *)kh_appBundleName;
///BundleID
+ (NSString *)kh_appBundleID;
///App Logo
+ (NSString *)kh_appLogoStr;

@end
