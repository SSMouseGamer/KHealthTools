//
//  UIFont+KHTsCategory.h
//  KHealthTools
//
//  Created by 李云新 on 2019/3/12.
//

#define KHFont(a)         [UIFont systemFontOfSize:a]
#define KHBoldFont(a)     [UIFont boldSystemFontOfSize:a]
#define KHAutoFont(a)     [UIFont kh_autoFontOfSize:a]
#define KHAutoBoldFont(a) [UIFont kh_boldAutoFontOfSize:a]

#define KHFontNameAndSize(a, b)     [UIFont fontWithName:a size:b]
#define KHAutoFontNameAndSize(a, b) [UIFont kh_autoFontWithName:a Size:b]

#import <UIKit/UIKit.h>

@interface UIFont (KHTsCategory)

+ (UIFont *)kh_autoFontOfSize:(CGFloat)fontSize;
+ (UIFont *)kh_boldAutoFontOfSize:(CGFloat)fontSize;
+ (UIFont *)kh_autoFontWithName:(NSString *)fontName size:(CGFloat)fontSize;

@end
