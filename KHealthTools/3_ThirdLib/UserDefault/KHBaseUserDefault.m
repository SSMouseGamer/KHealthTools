//
//  KHBaseUserDefault.m
//  KHealthDoctor
//
//  Created by 李云新 on 2018/8/15.
//  Copyright © 2018年 lambert. All rights reserved.
//

#import "KHBaseUserDefault.h"

@implementation KHBaseUserDefault

+ (void)kh_saveDictionary:(NSDictionary *)dictionary key:(NSString *)key{
    [self saveInUserDefault:dictionary key:key];
}

+ (NSDictionary *)kh_dictionaryForKey:(NSString *)key{
    
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
    if ([[dict class] isSubclassOfClass:[NSDictionary class]]){
        return dict;
    } else {
        return @{};
    }
}

+ (void)kh_saveArray:(NSArray *)array key:(NSString *)key{
    [self saveInUserDefault:@{@"d":array} key:key];
}

+ (NSArray *)kh_arrayForKey:(NSString *)key{
    
    NSArray *array = [[[NSUserDefaults standardUserDefaults] objectForKey:key] objectForKey:@"d"];
    
    if ([[array class] isSubclassOfClass:[NSArray class]]){
        return array;
    } else {
        return @[];
    }
}

+ (void)kh_saveBooleanValue:(BOOL)value key:(NSString *)key{
    [self saveInUserDefault:@(value) key:key];
}

+ (BOOL)kh_booleanValueForKey:(NSString *)key{
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    return [userdefault boolForKey:key];
}

+ (void)kh_saveIntegerValue:(NSInteger)value key:(NSString *)key{
    [self saveInUserDefault:@(value) key:key];
}

+ (NSInteger)kh_integerValueForKey:(NSString *)key{
    id index = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
    if (index == nil || [index isKindOfClass:[NSNull class]]){
        return 0;
    }
    return [index integerValue];
}

+ (void)kh_saveStringValue:(NSString *)value key:(NSString *)key{
    [self saveInUserDefault:value key:key];
}

+ (NSString *)kh_stringForKey:(NSString *)key{
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    return [userdefault valueForKey:key];
}

+ (void)saveInUserDefault:(id)object key:(NSString *)key{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:object forKey:key];
    [userDefault synchronize];
}

@end
