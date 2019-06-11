//
//  KHCalendarManager.m
//  KHealthDoctor
//
//  Created by 李云新 on 2018/8/21.
//  Copyright © 2018年 lambert. All rights reserved.
//
//  日历数据的生成
//  参考链接：https://blog.csdn.net/xmy0010/article/details/51506946

#import "KHealthToolsHeader.h"
#import "KHCalendarManager.h"

@interface KHCalendarManager()

///遵循历法的日历对象
@property (nonatomic, strong) NSCalendar *greCalendar;
///时间点的信息，它是NSCalendarUnit枚举集
@property (nonatomic, assign) CGFloat components;

@end

@implementation KHCalendarManager

#pragma mark - 初始化
+ (instancetype)share {
    static dispatch_once_t onceToken;
    static id instance;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        //公历
        self.greCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        //时间点的信息
        self.components = (NSCalendarUnitYear        |
                           NSCalendarUnitMonth       |
                           NSCalendarUnitDay         |
                           NSCalendarUnitHour        |
                           NSCalendarUnitMinute      |
                           NSCalendarUnitSecond      |
                           NSCalendarUnitWeekday     |
                           NSCalendarUnitWeekOfMonth |
                           NSCalendarUnitWeekOfYear);
    }
    return self;
}

///获取当前时间后30天的日历数据，如：当前是2018年11月23日，返回的是：[11/23 - 11/30]，[12/01 - 12/22]
- (NSArray<NSArray<KHCalendarModel *> *> *)getCalendarDataWithDay30 {
    //该月有几天
    NSInteger dayCount = [[KHCalendarManager share] getThisDays];
    //当前时间信息
    NSDateComponents *dayComponents = [[KHCalendarManager share] getThisDate];
    //剩几天，包括今天要 +1
    NSInteger dayOverage = dayCount - dayComponents.day + 1;
    //需要补全的天数
    NSInteger dayNeedAdd = 30 - dayOverage;
    
    KHLog(@"获取日历数据-%ld月共%ld天，剩%ld天，补%ld天", (long)dayComponents.month, (long)dayCount, (long)dayOverage, (long)dayNeedAdd);
    
    //当前月的日期模型数组
    NSArray *thisMonthDayArray = [[KHCalendarManager share] getModelWithComponents:dayComponents DayCount:dayOverage];
    
    //需要补全的日期的模型数组
    NSArray *addMonthDayArray = [[KHCalendarManager share] getModelWithNextMonthComponents:dayComponents DayCount:dayNeedAdd];
    
    //有数据才添加
    if (addMonthDayArray.count > 0) {
        return @[thisMonthDayArray, addMonthDayArray];
    } else {
        return @[thisMonthDayArray];
    }
}

#pragma mark - 获取时间对应的日历模型数组
///获取指定时间对应月份的日历数据，如：获取2018年9月9日的日历数据，返回的是：09/09 - 09/30的日历数据
- (NSArray<KHCalendarModel *> *)getCalendarDataWithYear:(NSInteger)year Month:(NSInteger)month Day:(NSInteger)day {
    ///该时间对应的信息
    NSDateComponents *dayComponents = [self getDateWithYear:year Month:month Day:day];
    ///该月有几天
    NSString *dateStr = [NSString stringWithFormat:@"%ld-%02ld-%02ld", (long)year, (long)month, (long)day];
    NSDate *date = [dateStr kh_getDateYMD];
    
    NSInteger dayCount = [self.greCalendar rangeOfUnit:NSCalendarUnitDay
                                                inUnit:NSCalendarUnitMonth
                                               forDate:!date ? [NSDate date] : date].length;
    dayCount = dayCount - day + 1;
    return [self getModelWithComponents:dayComponents DayCount:dayCount];
}

/**
 获取指定时间的日历模型数组
 
 @param components 开始的时间数据
 @param dayCount   需要多少天
 @return KHCalendarModel数组
 */
- (NSArray<KHCalendarModel *> *)getModelWithComponents:(NSDateComponents *)components DayCount:(NSInteger)dayCount {
    //开始时间点是周几，因为dayComponents.weekday，周日是1，周六是7。这里做一层转变:周一是1，周日是7
    NSInteger dWeek = components.weekday - 1;
    dWeek = dWeek == 0 ? 7 : dWeek;
    //开始时间的年
    NSInteger dYear  = components.year;
    //开始时间的月
    NSInteger dMonth = components.month;
    //开始时间的天
    NSInteger dDay   = components.day;
    
    //日历模型数组
    NSMutableArray *thisMonthDayArray = [NSMutableArray array];
    
    //真正的数据
    for (int i = 0; i < dayCount; i++) {
        dWeek = dWeek > 7 ? 1 : dWeek;
        KHCalendarModel *model = [KHCalendarModel modelWithWeek:dWeek++ Year:dYear Month:dMonth Day:dDay++];
        [thisMonthDayArray addObject:model];
    }
    
    return thisMonthDayArray;
}

/**
 获取下一个月的日历数组。如：components是2018年9月，dayCount为10天。则返回2018年10月前10天的日历数据
 
 @param components 开始的时间数据
 @param dayCount   需要多少天
 @return KHCalendarModel数组
 */
- (NSArray<KHCalendarModel *> *)getModelWithNextMonthComponents:(NSDateComponents *)components DayCount:(NSInteger)dayCount {
    
    NSInteger addMonth = components.month + 1;
    NSInteger addYear  = components.year;
    NSInteger addDay   = 1;
    if (addMonth > 12) {
        addMonth = 1;
        addYear += 1;
    }
    
    //该月的最大天数
    NSInteger maxAddDay = [self getDaysWithYear:addYear Month:addMonth];
    
    //需要补全的月份的首日的信息
    NSDateComponents *addComponents = [self getDateWithYear:addYear Month:addMonth Day:addDay];
    return [self getModelWithComponents:addComponents DayCount:MIN(maxAddDay, dayCount)];
}

#pragma mark - 获取月份天数
///获取当前月的天数，如：今天是2018年10月，则获取该月的天数
- (NSInteger)getThisDays{
    return [self.greCalendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[NSDate date]].length;
}

///获取指定年月份的天数，如：获取2018年9月改月份有多少天
- (NSInteger)getDaysWithYear:(NSInteger)year Month:(NSInteger)month {
    //定义一个NSDateComponents对象，设置一个时间点
    NSDateComponents *dateComponentsForDate = [[NSDateComponents alloc] init];
    [dateComponentsForDate setYear:year];
    [dateComponentsForDate setMonth:month];
    [dateComponentsForDate setDay:1];
    
    //根据设置的dateComponentsForDate获取历法中与之对应的时间点
    //这里的时分秒会使用NSDateComponents中规定的默认数值，一般为0或1。
    NSDate *dateFromDateComponentsForDate = [self.greCalendar dateFromComponents:dateComponentsForDate];
    
    return [self.greCalendar rangeOfUnit:NSCalendarUnitDay
                                  inUnit:NSCalendarUnitMonth
                                 forDate:dateFromDateComponentsForDate].length;
}

#pragma mark - 获取NSDateComponents
///获取当前时间的NSDateComponents
- (NSDateComponents *)getThisDate {
    return [self.greCalendar components:self.components fromDate:[NSDate date]];
}

///获取指定年月日的时间的NSDateComponents
- (NSDateComponents *)getDateWithYear:(NSInteger)year Month:(NSInteger)month Day:(NSInteger)day {
    //定义一个NSDateComponents对象，设置一个时间点
    NSDateComponents *dateComponentsForDate = [[NSDateComponents alloc] init];
    [dateComponentsForDate setYear:year];
    [dateComponentsForDate setMonth:month];
    [dateComponentsForDate setDay:day];
    
    //根据设置的dateComponentsForDate获取历法中与之对应的时间点
    //这里的时分秒会使用NSDateComponents中规定的默认数值，一般为0或1。
    NSDate *dateFromDateComponentsForDate = [self.greCalendar dateFromComponents:dateComponentsForDate];
    
    return [self.greCalendar components:self.components fromDate:dateFromDateComponentsForDate];
}

#pragma mark - 打印NSDateComponents
///打印指定的NSDateComponents
- (void)logDateComponents:(NSDateComponents *)dateComponents {
    //Sunday:1, Monday:2, Tuesday:3, Wednesday:4, Thursday:5, Friday:6, Saturday:7,
    NSString *weekDayStr = @"";
    switch (dateComponents.weekday) {
        case 1 : weekDayStr = @"天"; break;
        case 2 : weekDayStr = @"一"; break;
        case 3 : weekDayStr = @"二"; break;
        case 4 : weekDayStr = @"三"; break;
        case 5 : weekDayStr = @"四"; break;
        case 6 : weekDayStr = @"五"; break;
        case 7 : weekDayStr = @"六"; break;
        default: weekDayStr = @"无"; break;
    }
    
    NSLog(@"%li-%li-%li %02li:%02li:%02li，星期%@-%li，第%li周，今年第%li周",
          (long)dateComponents.year,
          (long)dateComponents.month,
          (long)dateComponents.day,
          (long)dateComponents.hour,
          (long)dateComponents.minute,
          (long)dateComponents.second,
          weekDayStr,
          (long)dateComponents.weekday,
          (long)dateComponents.weekOfMonth,
          (long)dateComponents.weekOfYear);
}

@end
