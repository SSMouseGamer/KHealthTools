//
//  NSString+KHTsCategory.m
//  KHealthTools
//
//  Created by 李云新 on 2018/10/9.
//

#import "NSString+KHTsCategory.h"

@implementation NSString (KHTsCategory)

///一定要显示字符串
+ (NSString *)kh_str:(NSString *)str {
    return [NSString kh_str:str Normal:@"暂无"];
}

///一定要显示字符串
+ (NSString *)kh_str:(NSString *)str Normal:(NSString *)nStr {
    if ([str isKindOfClass:[NSNull class]]) {
        return nStr;
    }
    if (str == nil) {
        return nStr;
    }
    if (![str isKindOfClass:[NSString class]]) {
        return [NSString stringWithFormat:@"%@",str];
    }
    if ([str isEqualToString:@""]) {
        return nStr;
    } else {
        return str;
    }
}

/**
 计算文字尺寸
 
 @param text 需要计算尺寸的文字
 @param font 文字的字体
 @param maxSize 文字的最大尺寸
 @return 计算得到的size
 */
+ (CGSize)kh_sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize{
    NSDictionary *attrs = @{NSFontAttributeName:font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

+ (CGSize)kh_sizeWithText:(NSString *)text font:(UIFont *)font maxWidth:(CGFloat)maxWidth {
    return [NSString kh_sizeWithText:text font:font maxSize:CGSizeMake(maxWidth, MAXFLOAT)];
}

+ (CGSize)kh_sizeWithText:(NSString *)text font:(UIFont *)font{
    return [NSString kh_sizeWithText:text font:font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
}

///获取拼音
- (NSString *)kh_getPinyin{
    //将NSString装换成NSMutableString
    NSMutableString *pinyin = [self mutableCopy];
    //将汉字转换为拼音
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    //返回最近结果
    return [pinyin stringByReplacingOccurrencesOfString:@" " withString:@""];
}

///base64转image
- (UIImage *)kh_base64StrTransformToImage {
    if (!self || [self isKindOfClass:[NSNull class]]) {
        return nil;
    }
    NSData *decodeData = [[NSData alloc] initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [UIImage imageWithData:decodeData];
}

///0男，1女
+ (NSString *)kh_getSexWithIndex:(NSInteger)index {
    return index == 0 ? @"男" : @"女";
}

///0男，1女
- (NSInteger)kh_getSexIndex {
    return [self isEqualToString:@"男"] ? 0 : 1;
}

///M男，F女
+ (NSString *)kh_getSexWithCode:(NSString *)code {
    return [code isEqualToString:@"M"] ? @"男" : @"女";
}

///M男，F女
- (NSString *)kh_getSexCode {
    return [self isEqualToString:@"男"] ? @"M" : @"F";
}

@end
