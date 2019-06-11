//
//  KHServicesSpecialTask.m
//  KHealthTools
//
//  Created by 李云新 on 2019/1/17.
//

#import "KHServicesSpecialTask.h"

@implementation KHServicesSpecialTask

- (NSMutableURLRequest *)getReuqest {
    NSAssert(self.bodyData != nil, @"\n\n\nKHServicesSpecialTask bodyData未设置值\n\n\n");
    NSMutableURLRequest *reuqest = [super getReuqest];
    [reuqest setHTTPBody:self.bodyData];
    return reuqest;
}

@end
