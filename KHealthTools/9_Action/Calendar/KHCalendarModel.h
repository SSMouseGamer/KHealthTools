//
//  KHCalendarModel.h
//  KHealthDoctor
//
//  Created by 李云新 on 2018/8/21.
//  Copyright © 2018年 lambert. All rights reserved.
//
//  日历模型

#import <Foundation/Foundation.h>

@interface KHCalendarModel : NSObject

///第几周，1:周一、2:周二 .. 7:周日
@property (nonatomic, assign) NSInteger week;

///年
@property (nonatomic, assign) NSInteger year;

///月
@property (nonatomic, assign) NSInteger month;
@property (nonatomic,   copy) NSString *d_monthStr;

///日
@property (nonatomic, assign) NSInteger day;

//20XX-XX-XX
@property (nonatomic,   copy) NSString *d_dateStr;

///初始化函数
+ (instancetype)modelWithWeek:(NSInteger)week Year:(NSInteger)year Month:(NSInteger)month Day:(NSInteger)day;
///空数据
+ (instancetype)modelWithNone;

@end
