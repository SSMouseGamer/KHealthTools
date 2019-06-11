//
//  LayerLabel.m
//  KHealthTools
//
//  Created by kim on 2019/3/7.
//  Copyright © 2019年 lambert. All rights reserved.
//

#import "LayerLabel.h"
#import <KHealthTools/KHealthTools.h>
#import <CoreText/CoreText.h>

@interface LayerLabel()

@property (nonatomic, strong) NSMutableString *attStr;

@end

@implementation LayerLabel
+ (instancetype)kh_textLayerWithFrame:(CGRect)frame Font:(UIFont *)font Auto:(BOOL)is_auto {
    LayerLabel *labL = [super kh_textLayerWithFrame:frame Font:font Auto:is_auto];
    [self setCustomConfig:labL];
    return labL;
}

+ (instancetype)kh_textLayerWithFont:(UIFont *)font {
    LayerLabel *labL = [super kh_textLayerWithFont:font];
    [self setCustomConfig:labL];
    return labL;
}

+ (instancetype)kh_textLayerWithFrame:(CGRect)frame {
    LayerLabel *labL = [super kh_textLayerWithFrame:frame];
    [self setCustomConfig:labL];
    return labL;
}

+ (void)setCustomConfig:(LayerLabel *)labL {
    labL.customAlignment = NSTextAlignmentCenter;
    labL.customLineSpace = 3.0;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [LayerLabel setCustomConfig:self];
    }
    return self;
}

- (void)setCustomStr:(NSString *)customStr {
    _customStr = customStr;
    if (customStr) {
        self.customAttributeStr = nil;
        [self setNeedsDisplay];
    }
}

- (void)setCustomAttributeStr:(NSMutableAttributedString *)customAttributeStr {
    _customAttributeStr = customAttributeStr;
    if (customAttributeStr) {
        self.customStr = nil;
        [self setNeedsDisplay];
    }
}

- (void)drawInContext:(CGContextRef)ctx {
    
    if (!self.customStr && !self.customAttributeStr) {
        [super drawInContext:ctx];
        return;
    }
   
    if (!self.wrapped) {
        [super drawInContext:ctx];
        self.string = self.customStr ?: self.customAttributeStr;
        return;
    }
    
    NSMutableAttributedString *mstr = self.customAttributeStr;
    __weak NSString *weakStr = self.customStr;
    __weak UIFont *weakFont = KHFont(self.fontSize);
    __block CGFloat linespacing = self.customLineSpace;
    __block NSTextAlignment alignment = self.customAlignment;
    if (!self.customAttributeStr) {
        mstr = [self.customStr setAttributeWithConfig:^NSArray<KHAttributesConfig *> *{
            NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
            paragraph.lineSpacing = linespacing;
            paragraph.lineBreakMode = NSLineBreakByWordWrapping;
            paragraph.alignment = alignment;
            KHAttributesConfig *paragraphC = [[KHAttributesConfig alloc] init];
            paragraphC.attributes_dic(@{NSParagraphStyleAttributeName:paragraph,NSFontAttributeName:weakFont});
            paragraphC.character_str(weakStr);
            return @[paragraphC];
        }];
    }
    CGFloat maxW = CGRectGetWidth(self.frame);
//    CGSize size = [mstr boundingRectWithSize:CGSizeMake(maxW, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) context:nil].size;
//    CGFloat mY = (CGRectGetHeight(self.frame) - size.height) * 0.5;
    
    ///创建一个用于绘制文本的路径区域
    CGMutablePathRef Path = CGPathCreateMutable();
    CGPathAddRect(Path, NULL, CGRectMake(0, 0, maxW, CGRectGetHeight(self.frame)));
    ///管理字体引用和文本绘制帧。
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)mstr);
    
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), Path, NULL);
    
    CGContextSaveGState(ctx);
    
    //x，y轴方向移动
    CGContextTranslateCTM(ctx , 0, self.bounds.size.height);
    //缩放x，y轴方向缩放，－1.0为反向1.0倍,坐标系转换,沿x轴翻转180度
    CGContextScaleCTM(ctx, 1.0 ,-1.0);
    
    
    CTFrameDraw(frame, ctx);
    
    CFRelease(frame);
    
    CGPathRelease(Path);
    
    CFRelease(framesetter);
    
}

@end
