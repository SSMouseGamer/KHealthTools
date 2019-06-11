//
//  NSString+KHTsPredicateCategory.h
//  KHealthTools
//
//  Created by 李云新 on 2018/10/9.
//
//  正则判断

#import <Foundation/Foundation.h>

@interface NSString (KHTsPredicateCategory)

///判断字符串是邮箱地址
- (BOOL)kh_isEmail;

///判断字符串是否为电话号码
- (BOOL)kh_isMobile;

///判断字符串是否为纯数字
- (BOOL)kh_isNumber;

///判断字符串是否只包含数字跟英文字母
- (BOOL)kh_isNumberAndEnglish;

///判断是否正常的身份证
- (BOOL)kh_isIDCard;

///正浮点数
- (BOOL)kh_isDecimal;

///判断是否为有效数字，整数位数：intBits，小数位数：decBits
- (BOOL)kh_isIntOrDecimalWithIntegerBits:(NSInteger)intBits decimalBits:(NSInteger)decBits;

/**
 处理输入状态情况下是否为有效数字，假如: 12. 则正常返回
 
 @param intBits 整数位数
 @param decBits 小数位数
 @return return value description
 */
- (BOOL)kh_dealEnterTextIsDecimalOrIntegerWithIntegerBits:(NSInteger)intBits decimalBits:(NSInteger)decBits;

- (BOOL)kh_deal_intBit3_decimalBit2;
- (BOOL)kh_deal_intBit4_decimalBit2;
- (BOOL)kh_deal_intBit5_decimalBit2;


@end
