//
//  NSString+KHTsPredicateCategory.m
//  KHealthTools
//
//  Created by 李云新 on 2018/10/9.
//

///正则表达式
///只能输入中文
#define PredicateChinese @"^[\u4e00-\u9fa5]{0,}$"
///只能输入中文&英文
#define PredicateChineseAndEnglish @"^[A-Za-z\u4E00-\u9FA5_-]+$"
///只能输入数字
#define PredicateNumber  @"^[0-9]*$"
///不能输入特殊字符
#define PredicateNotChar  @"^[A-Za-z0-9\u4E00-\u9FA5_-]+$"
///电话号码正则表达式
#define PredicatePhoneNumber @"^((1[345789][0-9]))\\d{8}$"
///只能输入数字&英文
#define PredicateNumberAndEnglish @"^[0-9a-zA-Z]*$"
///邮箱地址正则表达式
#define PredicateEmail @"[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
///正浮点数
#define PredicateDecimal @"^\\d*+(\\.\\d*)?$"
///是否是身份证 15位或18位
#define PredicateIDCard @"^[1-9]\\d{5}(18|19|20|21|22)\\d{2}((0[1-9])|10|11|12)(0[1-9]|[12]\\d|3[01])\\d{3}([0-9]|X)$|^[1-9]\\d{5}\\d{2}((0[1-9])|10|11|12)(0[1-9]|[12]\\d|3[01])\\d{3}$"

#import "NSString+KHTsPredicateCategory.h"

@implementation NSString (KHTsPredicateCategory)

///判断字符串是邮箱地址
- (BOOL)kh_isEmail {
    if ([self isKindOfClass:[NSNull class]]) {
        return NO;
    }
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PredicateEmail];
    return [pre evaluateWithObject:self];
}

///判断字符串是否为电话号码
- (BOOL)kh_isMobile {
    if ([self isKindOfClass:[NSNull class]]) {
        return NO;
    }
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PredicatePhoneNumber];
    return [pre evaluateWithObject:self];
}

///判断字符串是否为纯数字
- (BOOL)kh_isNumber {
    if ([self isKindOfClass:[NSNull class]]) {
        return NO;
    }
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PredicateNumber];
    return [pre evaluateWithObject:self];
}

///判断字符串是否只包含数字跟英文字母
- (BOOL)kh_isNumberAndEnglish {
    if ([self isKindOfClass:[NSNull class]]) {
        return NO;
    }
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PredicateNumberAndEnglish];
    return [pre evaluateWithObject:self];
}

///判断是否正常的身份证
- (BOOL)kh_isIDCard {
    if ([self isKindOfClass:[NSNull class]]) {
        return NO;
    }
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PredicateIDCard];
    return [pre evaluateWithObject:self];
}

///正浮点数
- (BOOL)kh_isDecimal {
    if ([self isKindOfClass:[NSNull class]]) {
        return NO;
    }
    
    if ([self hasPrefix:@"."] || [self hasSuffix:@"."]) {
        return NO;
    }
    
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PredicateDecimal];
    return [pre evaluateWithObject:self];
}

///判断是否为有效数字，整数位数：intBits，小数位数：decBits
- (BOOL)kh_isIntOrDecimalWithIntegerBits:(NSInteger)intBits decimalBits:(NSInteger)decBits {
    if ([self isKindOfClass:[NSNull class]]) {
        return NO;
    }
    
    if ([self hasPrefix:@"."] || [self hasSuffix:@"."]) {
        return NO;
    }
    
    NSString *containsStr = [NSString stringWithFormat:@"^\\d{0,%ld}+(\\.\\d{0,%ld})?$",(long)intBits,(long)decBits];
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", containsStr];
    return [pre evaluateWithObject:self];
}

///判断输入的值,整数位数：intBits，小数位数：decBits
- (BOOL)kh_dealEnterTextIsDecimalOrIntegerWithIntegerBits:(NSInteger)intBits decimalBits:(NSInteger)decBits {
    if ([self isKindOfClass:[NSNull class]] || [self isEqualToString:@"."]) {
        return NO;
    }
    if (self.length <= 0) {
        return YES;
    }
    ///判断是否符合标准 这里只做参考 yes则返回true，no则需判断其他情况，比如 "11." 的情况
    BOOL isDecimal = [self kh_isIntOrDecimalWithIntegerBits:intBits decimalBits:decBits];
    ///使用.分割数字
    NSArray *rangeArr = [self componentsSeparatedByString:@"."];
    if (isDecimal) {
        return YES;
    } else if (rangeArr.count > 2) {
        return NO;
    } else if (rangeArr.count == 1) {///这里可能是1111aaa
        NSString *numberStr = rangeArr[0];
        return [numberStr kh_isIntOrDecimalWithIntegerBits:intBits decimalBits:decBits];
    } else {
        if (rangeArr.count == 2) {
            ///小数的位置
            NSString *decimalStr = rangeArr[1];
            return decimalStr.length <= decBits;
        }
        return YES;
    }
}

///输入情况 为3位整数，2位小数
- (BOOL)kh_deal_intBit3_decimalBit2 {
    return [self kh_dealEnterTextIsDecimalOrIntegerWithIntegerBits:3 decimalBits:2];
}

///输入情况 为4位整数，2位小数
- (BOOL)kh_deal_intBit4_decimalBit2 {
    return [self kh_dealEnterTextIsDecimalOrIntegerWithIntegerBits:4 decimalBits:2];
}

///输入情况 为5位整数，2位小数
- (BOOL)kh_deal_intBit5_decimalBit2 {
    return [self kh_dealEnterTextIsDecimalOrIntegerWithIntegerBits:5 decimalBits:2];
}

@end
