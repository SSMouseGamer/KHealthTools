//
//  KHTools+KHTsAppInfoCategory.m
//  KHealthTools
//
//  Created by 李云新 on 2018/10/10.
//

#import "KHTools+KHTsAppInfoCategory.h"

@implementation KHTools (KHTsAppInfoCategory)

///跳转到AppID对应的App Store界面
+ (NSString *)kh_appStoreURLWithID:(NSString *)appid {
    return [NSString stringWithFormat:@"http://itunes.apple.com/app/id%@",appid];
}
///下载AppID对应的App信息
+ (NSString *)kh_appStoreLookupURLWithID:(NSString *)appid {
    return [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@",appid];
}

///当前版本号
+ (NSString *)kh_appCurrentVersion {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}
///当前BundleVersion
+ (int)kh_CurrentBundle {
    return [[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] intValue];
}

///AppName
+ (NSString *)kh_appBundleName {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
}
///BundleID
+ (NSString *)kh_appBundleID {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
}
///logo
+ (NSString *)kh_appLogoStr {
    return [[[[NSBundle mainBundle] infoDictionary] valueForKeyPath:@"CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles"] lastObject];
}

@end
