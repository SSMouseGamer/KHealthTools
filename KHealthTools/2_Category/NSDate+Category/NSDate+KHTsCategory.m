//
//  NSDate+KHTsCategory.m
//  KHealthTools
//
//  Created by 李云新 on 2018/10/9.
//

#import "NSDate+KHTsCategory.h"

static NSDateFormatter const *cformatter;

@implementation NSDate (KHTsCategory)

- (NSString *)kh_getTimeStrYMDHMS {
    return [self kh_getTimeStrWithFormat:@"yyyy-MM-dd hh:mm:ss"];
}

- (NSString *)kh_getTimeStrYMD {
    return [self kh_getTimeStrWithFormat:@"yyyy年MM月dd日"];
}

- (NSString *)kh_getTimeStrYYYYMMDD {
    return [self kh_getTimeStrWithFormat:@"yyyy-MM-dd"];
}

- (NSString *)kh_getTimeStrWithFormat:(NSString *)format {
    if (cformatter == nil) {
        cformatter = [[NSDateFormatter alloc] init];
    }
    [cformatter setDateFormat:format];
    return [cformatter stringFromDate:self];
}

///获取到年龄
- (NSInteger)kh_getAge {
    //获得当前系统时间与出生日期之间的时间间隔
    NSTimeInterval time = [[NSDate date] timeIntervalSinceDate:self];
    //时间间隔以秒作为单位,求年的话除以60*60*24*365
    return time / (60 * 60 * 24 * 365);
}

@end

@implementation NSString (KHDateStringCategory)

- (NSDate *)kh_getDateYMD {
    return [self kh_getDateWithFormat:@"yyyy-MM-dd"];
}

- (NSDate *)kh_getDateYMDHmS {
    return [self kh_getDateWithFormat:@"yyyy-MM-dd HH:mm:ss"];
}

- (NSDate *)kh_getDateWithFormat:(NSString *)format {
    if (cformatter == nil) {
        cformatter = [[NSDateFormatter alloc] init];
    }
    [cformatter setDateFormat:format];
    return [cformatter dateFromString:self];
}

- (NSDate *)kh_getAgeDate {
    NSMutableArray *characters = [NSMutableArray array];
    NSMutableString *mutStr = [NSMutableString string];
    //分离出字符串中的所有字符，并存储到数组characters中
    for (int i = 0; i < self.length; i ++) {
        NSString *subString = [self substringToIndex:i + 1];
        subString = [subString substringFromIndex:i];
        [characters addObject:subString];
    }
    //利用正则表达式，匹配数组中的每个元素，判断是否是数字，将数字拼接在可变字符串mutStr中
    for (NSString *b in characters) {
        NSString *regex = @"^[0-9]*$";
        NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];//谓词
        BOOL isShu = [pre evaluateWithObject:b];// 对b进行谓词运算
        if (isShu) {
            [mutStr appendString:b];
        }
    }
    
    //拿到年龄
    NSInteger age = [mutStr integerValue];
    //当前时间
    NSArray *timeArray = [[[NSDate date] kh_getTimeStrYYYYMMDD] componentsSeparatedByString:@"-"];
    if (timeArray.count < 3) {
        return [NSDate date];
    }
    
    //出生年份
    NSInteger birthYear = [timeArray[0] integerValue] - age;
    
    //出生时间
    NSString *birthTime = [NSString stringWithFormat:@"%ld-%@-%@ 00:00:00",(long)birthYear,timeArray[1],timeArray[2]];
    
    return [birthTime kh_getDateYMDHmS];
}

- (NSInteger)kh_timeSpFormatter:(NSString *)formatter {
    if (cformatter == nil) {
        cformatter = [[NSDateFormatter alloc] init];
    }
    [cformatter setDateFormat:formatter];
    
    NSDate *date = [cformatter dateFromString:self];
    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
    return timeSp;
}

///获取未来两个月的时间段，@{@"startTime":@"20XX-XX-XX", @"endTime":@"20XX-XX-XX"}
+ (NSDictionary *)kh_getTowMonthDate {
    NSArray *thisTimeArray = [[[NSDate date] kh_getTimeStrYYYYMMDD] componentsSeparatedByString:@"-"];
    if (thisTimeArray.count < 3) {
        return @{@"starTime":@"", @"endTime":@""};
    }
    NSInteger oneY = [thisTimeArray[0] integerValue];
    NSInteger oneM = [thisTimeArray[1] integerValue];
    NSInteger twoY = oneY;
    NSInteger twoM = oneM + 1;
    if (oneM == 12) {
        twoY = oneY + 1;
        twoM = 1;
    }
    
    NSInteger threeY = twoY;
    NSInteger threeM = twoM + 1;
    if (twoM == 12) {
        threeY = twoY + 1;
        threeM = 1;
    }
    
    NSString *starTime = [NSString stringWithFormat:@"%ld-%02ld-01",(long)oneY,(long)oneM];
    NSString *endTime  = [NSString stringWithFormat:@"%ld-%02ld-01",(long)threeY,(long)threeM];
    
    return @{@"starTime":starTime, @"endTime":endTime};
}

@end
