//
//  UIView+KHTsRectCategory.m
//  KHealthTools
//
//  Created by 李云新 on 2018/10/9.
//

#import "UIView+KHTsRectCategory.h"

@implementation UIView (KHTsRectCategory)

- (void)setKh_x:(CGFloat)kh_x {
    CGRect frame = self.frame;
    frame.origin.x = kh_x;
    self.frame = frame;
}

- (CGFloat)kh_x {
    return self.frame.origin.x;
}

- (void)setKh_y:(CGFloat)kh_y {
    CGRect frame = self.frame;
    frame.origin.y = kh_y;
    self.frame = frame;
}

- (CGFloat)kh_y {
    return self.frame.origin.y;
}

- (void)setKh_origin:(CGPoint)kh_origin {
    CGRect frame = self.frame;
    frame.origin = kh_origin;
    self.frame = frame;
}

- (CGPoint)kh_origin {
    return self.frame.origin;
}

- (void)setKh_width:(CGFloat)kh_width {
    CGRect frame = self.frame;
    frame.size.width = kh_width;
    self.frame = frame;
}

- (CGFloat)kh_width {
    return self.frame.size.width;
}

- (void)setKh_height:(CGFloat)kh_height {
    CGRect frame = self.frame;
    frame.size.height = kh_height;
    self.frame = frame;
}

- (CGFloat)kh_height {
    return self.frame.size.height;
}

- (void)setKh_size:(CGSize)kh_size {
    CGRect frame = self.frame;
    frame.size = kh_size;
    self.frame = frame;
}

- (CGSize)kh_size {
    return self.frame.size;
}

- (void)setKh_centerX:(CGFloat)kh_centerX {
    self.center = CGPointMake(kh_centerX, self.center.y);
}

- (CGFloat)kh_centerX {
    return self.center.x;
}

- (void)setKh_centerY:(CGFloat)kh_centerY {
    self.center = CGPointMake(self.center.x, kh_centerY);
}

- (CGFloat)kh_centerY {
    return self.center.y;
}

- (CGFloat)kh_minX {
    return CGRectGetMinX(self.frame);
}

- (CGFloat)kh_maxX {
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)kh_minY {
    return CGRectGetMinY(self.frame);
}

- (CGFloat)kh_maxY {
    return CGRectGetMaxY(self.frame);
}

@end

#pragma mark -
@implementation CALayer (KHTsRectCategory)

- (void)setKh_x:(CGFloat)kh_x {
    CGPoint position = self.position;
    position.x = kh_x + self.bounds.size.width * 0.5;
    self.position = position;
}

- (CGFloat)kh_x {
    return self.position.x - self.bounds.size.width * 0.5;
}

- (void)setKh_y:(CGFloat)kh_y {
    CGPoint position = self.position;
    position.y = kh_y + self.bounds.size.height * 0.5;
    self.position = position;
}

- (CGFloat)kh_y {
    return self.position.y - self.bounds.size.height * 0.5;
}

- (void)setKh_width:(CGFloat)kh_width {
    CGPoint position = self.position;
    position.x -= (self.bounds.size.width - kh_width) * 0.5;
    self.position = position;
    
    CGRect bounds = self.bounds;
    bounds.size.width = kh_width;
    self.bounds = bounds;
}

- (CGFloat)kh_width {
    return self.bounds.size.width;
}

- (void)setKh_height:(CGFloat)kh_height {
    CGPoint position = self.position;
    position.y -= (self.bounds.size.height - kh_height) * 0.5;
    self.position = position;
    
    CGRect bounds = self.bounds;
    bounds.size.height = kh_height;
    self.bounds = bounds;
}

- (CGFloat)kh_height {
    return self.bounds.size.height;
}

- (void)setKh_frame:(CGRect)kh_frame {
    CGFloat w  = kh_frame.size.width;
    CGFloat h  = kh_frame.size.height;
    CGFloat pX = kh_frame.origin.x + w * 0.5;
    CGFloat pY = kh_frame.origin.y + h * 0.5;
    self.bounds   = CGRectMake(0, 0, w, h);
    self.position = CGPointMake(pX, pY);
}

- (CGRect)kh_frame {
    CGFloat w = self.bounds.size.width;
    CGFloat h = self.bounds.size.height;
    CGFloat x = self.position.x - w * 0.5;
    CGFloat y = self.position.y - h * 0.5;
    return CGRectMake(x, y, w, h);
}

- (void)setKh_centerX:(CGFloat)kh_centerX {
    self.position = CGPointMake(kh_centerX, self.position.y);
}

- (CGFloat)kh_centerX {
    return self.position.x;
}

- (void)setKh_centerY:(CGFloat)kh_centerY {
    self.position = CGPointMake(self.position.x, kh_centerY);
}

- (CGFloat)kh_centerY {
    return self.position.y;
}

- (CGFloat)kh_minX {
    return self.position.x - self.bounds.size.width * 0.5;
}

- (CGFloat)kh_maxX {
    return self.position.x + self.bounds.size.width * 0.5;
}

- (CGFloat)kh_minY {
    return self.position.y - self.bounds.size.height * 0.5;
}

- (CGFloat)kh_maxY {
    return self.position.y + self.bounds.size.height * 0.5;
}

@end
