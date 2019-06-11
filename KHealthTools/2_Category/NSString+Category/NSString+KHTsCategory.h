//
//  NSString+KHTsCategory.h
//  KHealthTools
//
//  Created by 李云新 on 2018/10/9.
//

#import <Foundation/Foundation.h>

@interface NSString (KHTsCategory)

///一定要显示字符串
+ (NSString *)kh_str:(NSString *)str;
///一定要显示字符串
+ (NSString *)kh_str:(NSString *)str Normal:(NSString *)nStr;

/**
 计算文字尺寸
 
 @param text 需要计算尺寸的文字
 @param font 文字的字体
 @param maxSize 文字的最大尺寸
 @return 计算得到的size
 */
+ (CGSize)kh_sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize;
+ (CGSize)kh_sizeWithText:(NSString *)text font:(UIFont *)font maxWidth:(CGFloat)maxWidth;
+ (CGSize)kh_sizeWithText:(NSString *)text font:(UIFont *)font;

///获取拼音
- (NSString *)kh_getPinyin;
///base64转image
- (UIImage *)kh_base64StrTransformToImage;

///0男，1女
+ (NSString *)kh_getSexWithIndex:(NSInteger)index;
///0男，1女
- (NSInteger)kh_getSexIndex;
///M男，F女
+ (NSString *)kh_getSexWithCode:(NSString *)code;
///M男，F女
- (NSString *)kh_getSexCode;

@end
