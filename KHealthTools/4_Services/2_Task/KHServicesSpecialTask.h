//
//  KHServicesSpecialTask.h
//  KHealthTools
//
//  Created by 李云新 on 2019/1/17.
//

#import "KHServicesTask.h"

@interface KHServicesSpecialTask : KHServicesTask

///访问参数 - 有了它，param失效
@property (nonatomic, strong) NSData *bodyData;

@end
