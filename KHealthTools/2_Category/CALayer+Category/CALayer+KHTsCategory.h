//
//  CALayer+KHTsCategory.h
//  KHealthTools
//
//  Created by 李云新 on 2019/2/14.
//

#import <UIKit/UIKit.h>

#pragma mark -
@interface CALayer (KHTsCategory)

@end

#pragma mark -
@interface CATextLayer (KHTsCategory)

///根据Frame创建TextLayer
+ (instancetype)kh_textLayerWithFrame:(CGRect)frame;

///根据字体创建TextLayer，初始高度为字体高度
+ (instancetype)kh_textLayerWithFont:(UIFont *)font;

/**
 根据Frame和Font创建TextLayer
 @param is_auto 是否自适应高度，为YES，则初始高度为字体高度
 */
+ (instancetype)kh_textLayerWithFrame:(CGRect)frame Font:(UIFont *)font Auto:(BOOL)is_auto;

/**
 设置TextLayer字体
 @param is_auto 是否自适应高度，为YES，则初始高度为字体高度
 */
- (void)kh_setFont:(UIFont *)font Auto:(BOOL)is_auto;

///设置TextAlignment
- (void)kh_setTextAlignment:(NSTextAlignment)textAlignment;

@end
