//
//  KHCalendarModel.m
//  KHealthDoctor
//
//  Created by 李云新 on 2018/8/21.
//  Copyright © 2018年 lambert. All rights reserved.
//

#import "KHCalendarModel.h"

@implementation KHCalendarModel

///空数据
+ (instancetype)modelWithNone {
    return [[self alloc] initWithWeek:0 Year:0 Month:0 Day:0];
}

+ (instancetype)modelWithWeek:(NSInteger)week Year:(NSInteger)year Month:(NSInteger)month Day:(NSInteger)day {
    return [[self alloc] initWithWeek:week Year:year Month:month Day:day];
}

- (instancetype)initWithWeek:(NSInteger)week Year:(NSInteger)year Month:(NSInteger)month Day:(NSInteger)day {
    self = [super init];
    if (self) {
        self.week  = week;
        self.year  = year;
        self.month = month;
        self.day   = day;
        self.d_dateStr = [NSString stringWithFormat:@"%ld-%02ld-%02ld", (long)self.year, (long)self.month, (long)self.day];
    }
    return self;
}

- (void)setMonth:(NSInteger)month {
    _month = month;
    switch (month) {
        case  1: self.d_monthStr = @"一"; break;
        case  2: self.d_monthStr = @"二"; break;
        case  3: self.d_monthStr = @"三"; break;
        case  4: self.d_monthStr = @"四"; break;
        case  5: self.d_monthStr = @"五"; break;
        case  6: self.d_monthStr = @"六"; break;
        case  7: self.d_monthStr = @"七"; break;
        case  8: self.d_monthStr = @"八"; break;
        case  9: self.d_monthStr = @"九"; break;
        case 10: self.d_monthStr = @"十"; break;
        case 11: self.d_monthStr = @"十一"; break;
        case 12: self.d_monthStr = @"十二"; break;
        default: self.d_monthStr = @"一"; break;
    }
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%ld-%ld-%ld, 周%ld", (long)self.year, (long)self.month, (long)self.day, (long)self.week];
}

@end
