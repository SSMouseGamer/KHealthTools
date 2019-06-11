//
//  UIView+KHTsRectCategory.h
//  KHealthTools
//
//  Created by 李云新 on 2018/10/9.
//

#import <UIKit/UIKit.h>

@interface UIView (KHTsRectCategory)

@property (nonatomic, assign) CGFloat kh_x;
@property (nonatomic, assign) CGFloat kh_y;
@property (nonatomic, assign) CGFloat kh_width;
@property (nonatomic, assign) CGFloat kh_height;
@property (nonatomic, assign) CGPoint kh_origin;
@property (nonatomic, assign) CGSize  kh_size;
@property (nonatomic, assign) CGFloat kh_centerX;
@property (nonatomic, assign) CGFloat kh_centerY;

- (CGFloat)kh_minX;
- (CGFloat)kh_maxX;
- (CGFloat)kh_minY;
- (CGFloat)kh_maxY;

@end

@interface CALayer (KHTsRectCategory)

@property (nonatomic, assign) CGFloat kh_x;
@property (nonatomic, assign) CGFloat kh_y;
@property (nonatomic, assign) CGFloat kh_width;
@property (nonatomic, assign) CGFloat kh_height;
@property (nonatomic, assign) CGRect  kh_frame;
@property (nonatomic, assign) CGFloat kh_centerX;
@property (nonatomic, assign) CGFloat kh_centerY;

- (CGFloat)kh_minX;
- (CGFloat)kh_maxX;
- (CGFloat)kh_minY;
- (CGFloat)kh_maxY;

@end
