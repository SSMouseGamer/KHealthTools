//
//  CALayer+KHTsCategory.m
//  KHealthTools
//
//  Created by 李云新 on 2019/2/14.
//

#import "KHealthToolsHeader.h"
#import "CALayer+KHTsCategory.h"

#pragma mark -
@implementation CALayer (KHTsCategory)

@end

@implementation CATextLayer (KHTsCategory)

#pragma mark -
///根据Frame创建TextLayer
+ (instancetype)kh_textLayerWithFrame:(CGRect)frame {
    CATextLayer *layer = [[self alloc] initKH];
    layer.kh_frame = frame;
    return layer;
}

///根据字体创建TextLayer，初始高度为字体高度
+ (instancetype)kh_textLayerWithFont:(UIFont *)font {
    CATextLayer *layer = [[self alloc] initKH];
    [layer kh_setFont:font Auto:YES];
    return layer;
}

/**
 根据Frame和Font创建TextLayer
 @param is_auto 是否自适应高度，为YES，则初始高度为字体高度
 */
+ (instancetype)kh_textLayerWithFrame:(CGRect)frame Font:(UIFont *)font Auto:(BOOL)is_auto {
    CATextLayer *layer = [[self alloc] initKH];
    [layer kh_setFont:font Auto:is_auto];
    if (is_auto) {
        frame.size.height = layer.kh_height;
        layer.kh_frame = frame;
    } else {
        layer.kh_frame = frame;
    }
    return layer;
}

/**
 设置TextLayer字体
 @param is_auto 是否自适应高度，为YES，则初始高度为字体高度
 */
- (void)kh_setFont:(UIFont *)font Auto:(BOOL)is_auto {
    self.fontSize = font.pointSize;
    if (is_auto) {
        self.kh_height = font.lineHeight;
    }
}

///设置TextAlignment
- (void)kh_setTextAlignment:(NSTextAlignment)textAlignment {
    switch (textAlignment) {
        case NSTextAlignmentLeft:
            self.alignmentMode = kCAAlignmentLeft;
            break;
        case NSTextAlignmentCenter:
            self.alignmentMode = kCAAlignmentCenter;
            break;
        case NSTextAlignmentRight:
            self.alignmentMode = kCAAlignmentRight;
            break;
        case NSTextAlignmentJustified:
            self.alignmentMode = kCAAlignmentJustified;
            break;
        case NSTextAlignmentNatural:
            self.alignmentMode = kCAAlignmentNatural;
            break;
    }
}

#pragma mark -
- (instancetype)initKH {
    self = [super init];
    if (self) {
        self.contentsScale = [UIScreen mainScreen].scale;
        self.actions = @{@"contents":[NSNull null]};
    }
    return self;
}

@end
