//
//  KHCalendarManager.h
//  KHealthDoctor
//
//  Created by 李云新 on 2018/8/21.
//  Copyright © 2018年 lambert. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KHCalendarModel.h"

@interface KHCalendarManager : NSObject

///数据模型单例
+ (instancetype)share;

///获取当前时间后30天的日历数据，如：当前是2018年11月23日，返回的是：[11/23 - 11/30]，[12/01 - 12/22]
- (NSArray<NSArray<KHCalendarModel *> *> *)getCalendarDataWithDay30;

///获取指定时间对应月份的日历数据，如：获取2018年9月9日的日历数据，返回的是：09/09 - 09/30的日历数据
- (NSArray<KHCalendarModel *> *)getCalendarDataWithYear:(NSInteger)year
                                                  Month:(NSInteger)month
                                                    Day:(NSInteger)day;

@end
