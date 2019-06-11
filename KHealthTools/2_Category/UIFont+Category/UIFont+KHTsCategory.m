//
//  UIFont+KHTsCategory.m
//  KHealthTools
//
//  Created by 李云新 on 2019/3/12.
//

#import "KHealthToolsHeader.h"
#import "UIFont+KHTsCategory.h"

@implementation UIFont (KHTsCategory)

+ (UIFont *)kh_autoFontOfSize:(CGFloat)fontSize {
    return [self systemFontOfSize:[KHTools share].fontScale * fontSize];
}

+ (UIFont *)kh_boldAutoFontOfSize:(CGFloat)fontSize {
    return [self boldSystemFontOfSize:[KHTools share].fontScale * fontSize];
}

+ (UIFont *)kh_autoFontWithName:(NSString *)fontName size:(CGFloat)fontSize {
    return [self fontWithName:fontName size:[KHTools share].fontScale * fontSize];
}

@end
