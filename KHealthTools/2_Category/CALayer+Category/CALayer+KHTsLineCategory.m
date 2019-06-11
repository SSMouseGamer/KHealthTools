//
//  CALayer+KHTsLineCategory.m
//  KHealthTools
//
//  Created by 李云新 on 2019/3/12.
//

#import "KHealthToolsHeader.h"
#import "CALayer+KHTsLineCategory.h"

@implementation CALayer (KHTsLineCategory)

+ (CGFloat)kh_lineH {
    static CGFloat lineH = -1;
    if (lineH == -1) {
        //lineH = 1 / [UIScreen mainScreen].scale;
        lineH = 0.8;
    }
    return lineH;
}

+ (UIColor *)kh_lineColor {
    return KHColorEAEAEA;
}

+ (UIColor *)kh_bigLineColor {
    return KHColorF5F5F5;
}

- (CALayer *)kh_addLineTopWithX:(CGFloat)x {
    return [self kh_addLineWithX:x Y:0];
}

- (CALayer *)kh_addLineBottomWithX:(CGFloat)x {
    CGFloat y = self.bounds.size.height - [CALayer kh_lineH];
    return [self kh_addLineWithX:x Y:y];
}

- (CALayer *)kh_addLineWithX:(CGFloat)x Y:(CGFloat)y {
    CGFloat w  = self.frame.size.width - 2 * x;
    CGFloat h  = [CALayer kh_lineH];
    CGFloat pY = y + h * 0.5;
    CGFloat pX = x + w * 0.5;
    return [self kh_addLineWithPosition:CGPointMake(pX, pY) Size:CGSizeMake(w, h)];
}

- (CALayer *)kh_addLineVerticalWithX:(CGFloat)x Height:(CGFloat)height {
    CGFloat w  = [CALayer kh_lineH];
    CGFloat h  = height;
    CGFloat pY = self.frame.size.height * 0.5;
    CGFloat pX = x + 2 * 0.5;
    return [self kh_addLineWithPosition:CGPointMake(pX, pY) Size:CGSizeMake(w, h)];
}

- (CALayer *)kh_addBigLineWithY:(CGFloat)y {
    CGFloat w  = self.frame.size.width;
    CGFloat h  = KHMargin;
    CGFloat pY = y + h * 0.5;
    CGFloat pX = w * 0.5;
    return [self kh_addLineWithPosition:CGPointMake(pX, pY) Size:CGSizeMake(w, h)];
}

- (CALayer *)kh_addLineWithPosition:(CGPoint)position Size:(CGSize)size{
    CALayer *lineLayer = [[CALayer alloc] init];
    lineLayer.bounds = CGRectMake(0, 0, size.width, size.height);
    lineLayer.position = position;
    
    if (size.width >= self.frame.size.width && size.height > [CALayer kh_lineH]){
        lineLayer.backgroundColor = [CALayer kh_bigLineColor].CGColor;
    } else {
        lineLayer.backgroundColor = [CALayer kh_lineColor].CGColor;
    }
    
    [self addSublayer:lineLayer];
    
    return lineLayer;
}

@end

#pragma mark -
@implementation UIView (KHTsLineCategory)

- (CALayer *)kh_addLineTopWithX:(CGFloat)x {
    return [self.layer kh_addLineTopWithX:x];
}

- (CALayer *)kh_addLineBottomWithX:(CGFloat)x {
    return [self.layer kh_addLineBottomWithX:x];
}

- (CALayer *)kh_addLineWithX:(CGFloat)x Y:(CGFloat)y {
    return [self.layer kh_addLineWithX:x Y:y];
}

- (CALayer *)kh_addLineVerticalWithX:(CGFloat)x Height:(CGFloat)height {
    return [self.layer kh_addLineVerticalWithX:x Height:height];
}

- (CALayer *)kh_addBigLineWithY:(CGFloat)y {
    return [self.layer kh_addBigLineWithY:y];
}

@end
