//
//  CALayer+KHTsLineCategory.h
//  KHealthTools
//
//  Created by 李云新 on 2019/3/12.
//

#import <UIKit/UIKit.h>

@interface CALayer (KHTsLineCategory)

+ (CGFloat)kh_lineH;
+ (UIColor *)kh_lineColor;
+ (UIColor *)kh_bigLineColor;

- (CALayer *)kh_addLineTopWithX:(CGFloat)x;
- (CALayer *)kh_addLineBottomWithX:(CGFloat)x;
- (CALayer *)kh_addLineWithX:(CGFloat)x Y:(CGFloat)y;
- (CALayer *)kh_addLineVerticalWithX:(CGFloat)x Height:(CGFloat)height;
- (CALayer *)kh_addBigLineWithY:(CGFloat)y;

@end

#pragma mark -
@interface UIView (KHTsLineCategory)

- (CALayer *)kh_addLineTopWithX:(CGFloat)x;
- (CALayer *)kh_addLineBottomWithX:(CGFloat)x;
- (CALayer *)kh_addLineWithX:(CGFloat)x Y:(CGFloat)y;
- (CALayer *)kh_addLineVerticalWithX:(CGFloat)x Height:(CGFloat)height;
- (CALayer *)kh_addBigLineWithY:(CGFloat)y;

@end
