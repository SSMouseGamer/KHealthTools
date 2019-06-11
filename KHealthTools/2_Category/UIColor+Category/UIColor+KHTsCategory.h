//
//  UIColor+KHTsCategory.h
//  KHealthTools
//
//  Created by 李云新 on 2018/10/9.
//

#import <UIKit/UIKit.h>

@interface UIColor (KHTsCategory)

/**返回当前颜色的图片*/
- (UIImage *)kh_getImage;
/**返回当前颜色的图片*/
- (UIImage *)kh_getImageWithSize:(CGSize)size;
/**返回当前颜色的图片*/
- (UIImage *)kh_getImageWithSize:(CGSize)size Radius:(CGFloat)radius;

@end
