//
//  KHBaseUserDefault.h
//  KHealthDoctor
//
//  Created by 李云新 on 2018/8/15.
//  Copyright © 2018年 lambert. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KHBaseUserDefault : NSObject

+ (void)kh_saveBooleanValue:(BOOL)value key:(NSString *)key;
+ (BOOL)kh_booleanValueForKey:(NSString *)key;

+ (void)kh_saveIntegerValue:(NSInteger)value key:(NSString *)key;
+ (NSInteger)kh_integerValueForKey:(NSString *)key;

+ (void)kh_saveStringValue:(NSString *)value key:(NSString *)key;
+ (NSString *)kh_stringForKey:(NSString *)key;

+ (void)kh_saveDictionary:(NSDictionary *)dictionary key:(NSString *)key;
+ (NSDictionary *)kh_dictionaryForKey:(NSString *)key;

+ (void)kh_saveArray:(NSArray *)array key:(NSString *)key;
+ (NSArray *)kh_arrayForKey:(NSString *)key;

@end
