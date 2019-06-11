//
//  UIColor+KHTsCategory.m
//  KHealthTools
//
//  Created by 李云新 on 2018/10/9.
//

#import "UIColor+KHTsCategory.h"
#import "UIView+KHTsCategory.h"

@implementation UIColor (KHTsCategory)

- (UIImage *)kh_getImage {
    return [self kh_getImageWithSize:CGSizeMake(1, 1)];
}

- (UIImage *)kh_getImageWithSize:(CGSize)size{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [self CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

- (UIImage *)kh_getImageWithSize:(CGSize)size Radius:(CGFloat)radius {
    UIView *iV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    iV.backgroundColor = self;
    iV.layer.cornerRadius = radius;
    return [iV kh_getViewImage];
}

@end
