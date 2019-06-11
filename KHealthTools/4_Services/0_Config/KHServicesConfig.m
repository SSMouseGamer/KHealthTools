//
//  KHServicesConfig.m
//  KHealthTools
//
//  Created by 李云新 on 2018/11/13.
//

#import "KHServicesConfig.h"
#import "KHTools.h"
#import "KHBaseUserDefault.h"

@implementation KHServicesConfig

///根据key获取相应的配置
+ (NSDictionary *)getConfigDict {
    static NSDictionary *serviceDomainDict;
    
    if (serviceDomainDict == nil) {
        NSString *originPath = [[NSBundle mainBundle] pathForResource:@"kh_services_domain_config"
                                                               ofType:@"plist"];
        NSArray *serviceDomainArray = [[NSArray alloc] initWithContentsOfFile:originPath];
        NSAssert(serviceDomainArray.count != 0, @"\n\n\nkh_services_domain_config 配置出错\n\n\n");
        
        NSInteger selKey = [KHBaseUserDefault kh_integerValueForKey:@"KHTools_ServicesConfig_SelKey"];
        if (selKey < 0 || selKey >= serviceDomainArray.count) {
            selKey = 0;
        }
        if (![KHTools isDEBUG]) {
            selKey = 0;
        }
        serviceDomainDict = serviceDomainArray[selKey];
    }
    
    return serviceDomainDict;
}

///获取域名
+ (NSString *)doMain {
    return [[KHServicesConfig getConfigDict] objectForKey:@"domain"];
}

///获取拼接H5的域名
+ (NSString *)H5DoMain {
    return [[KHServicesConfig getConfigDict] objectForKey:@"h5domain"];
}

///获取IMSDK的AppID
+ (NSString *)IMSDKAppID {
    return [[KHServicesConfig getConfigDict] objectForKey:@"imsdkappid"];
}

///获取IMSDK的推送ID
+ (NSString *)IMSDKBusiID {
    return [[KHServicesConfig getConfigDict] objectForKey:@"imbusiid"];
}

///获取IMSDK的开发模式推送ID
+ (NSString *)IMSDKBusiID_DEBUG {
    return [[KHServicesConfig getConfigDict] objectForKey:@"imbusiiddebug"];
}

@end
