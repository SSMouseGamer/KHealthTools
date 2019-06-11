//
//  NSDate+KHTsCategory.h
//  KHealthTools
//
//  Created by 李云新 on 2018/10/9.
//

#import <Foundation/Foundation.h>

@interface NSDate (KHTsCategory)

///获取时间字符串，格式：yyyy-MM-dd hh:mm:ss
- (NSString *)kh_getTimeStrYMDHMS;
///获取时间字符串，格式：yyyy年MM月dd日
- (NSString *)kh_getTimeStrYMD;
///获取时间字符串，格式：yyyy-MM-dd
- (NSString *)kh_getTimeStrYYYYMMDD;
///获取时间字符串
- (NSString *)kh_getTimeStrWithFormat:(NSString *)format;

///获取年龄
- (NSInteger)kh_getAge;

@end

@interface NSString (KHDateStringCategory)

///获取时间字符串的Date
- (NSDate *)kh_getDateYMD;
- (NSDate *)kh_getDateYMDHmS;
- (NSDate *)kh_getDateWithFormat:(NSString *)format;

///获取年龄对应的Date
- (NSDate *)kh_getAgeDate;

///获取时间字符串对应的时间戳
- (NSInteger)kh_timeSpFormatter:(NSString *)formatter;

///获取未来两个月的时间段，@{@"startTime":@"20XX-XX-XX", @"endTime":@"20XX-XX-XX"}
+ (NSDictionary *)kh_getTowMonthDate;

@end
