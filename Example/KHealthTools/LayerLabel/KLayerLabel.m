//
//  KLayerLabel.m
//  KHealthTools
//
//  Created by kim on 2019/3/9.
//  Copyright © 2019年 lambert. All rights reserved.
//

#import "KLayerLabel.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreText/CoreText.h>
#import <KHealthTools/KHealthTools.h>

@implementation KLayerLabel

+ (Class)layerClass {
    return [CATextLayer class];
}

- (CATextLayer *)textLayer {
    return (CATextLayer *)self.layer;
}

- (void)setUp {
    [self textLayer].string = self.text;
    [self textLayer].contentsScale = [UIScreen mainScreen].scale;
    [self textLayer].wrapped = YES;
    [self.layer display];
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

- (void)awakeFromNib {
    [self setUp];
    [super awakeFromNib];
}

- (void)setText:(NSString *)text {
    [self textLayer].string = text;
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    [self textLayer].string = attributedText;
}

- (void)setTextColor:(UIColor *)textColor {
    [self textLayer].foregroundColor = textColor.CGColor;
}

- (void)setFont:(UIFont *)font {
    
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    [self textLayer].font = fontRef;
    [self textLayer].fontSize = font.pointSize;
    CGFontRelease(fontRef);
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    KHLog(@"2333");
}

@end
