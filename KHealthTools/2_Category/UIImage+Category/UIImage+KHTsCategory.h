//
//  UIImage+KHTsCategory.h
//  KHealthTools
//
//  Created by 李云新 on 2018/10/9.
//

#import <UIKit/UIKit.h>

@interface UIImage (KHTsCategory)

+ (UIImage *)kh_getImage:(UIImage *)image size:(CGSize)size;

///压缩图片
- (UIImage *)kh_zipImage;
///压缩图片
- (NSData *)kh_zipImageToByte:(NSInteger)maxLength;

@end
