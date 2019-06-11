//
//  LabelView.m
//  KHealthTools
//
//  Created by kim on 2019/3/11.
//  Copyright © 2019年 lambert. All rights reserved.
//

#import "LabelView.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreText/CoreText.h>
#import <KHealthTools/KHealthTools.h>

@implementation LabelView

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"tag"];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addObserver:self forKeyPath:@"tag" options:(NSKeyValueObservingOptionNew) context:nil];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if (!_text) {
        return;
    }
    KHLog(@"2333");
    __weak NSString *weakStr = self.text;
    __weak UIFont *weakFont = self.font;
    NSMutableAttributedString *mstr = [self.text setAttributeWithConfig:^NSArray<KHAttributesConfig *> *{
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        paragraph.lineSpacing = 10.0;
        paragraph.lineBreakMode = NSLineBreakByWordWrapping;
        paragraph.alignment = NSTextAlignmentLeft;
        KHAttributesConfig *paragraphC = [[KHAttributesConfig alloc] init];
        paragraphC.attributes_dic(@{NSParagraphStyleAttributeName:paragraph,NSFontAttributeName:weakFont,NSForegroundColorAttributeName:[UIColor blackColor]});
        paragraphC.character_str(weakStr);
        return @[paragraphC];
    }];
    
    ///获取当前绘制的上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    ///创建一个用于绘制文本的路径区域
    CGMutablePathRef Path = CGPathCreateMutable();
    CGPathAddRect(Path, NULL, CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)));
    ///管理字体引用和文本绘制帧。
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)mstr);
    ///绘制的区域
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), Path, NULL);
    ///保存当前的上下文
    CGContextSaveGState(ctx);
    
    //x，y轴方向移动
    CGContextTranslateCTM(ctx , 0, self.bounds.size.height);
    //缩放x，y轴方向缩放，－1.0为反向1.0倍,坐标系转换,沿x轴翻转180度
    CGContextScaleCTM(ctx, 1.0 ,-1.0);
    
    ///在指定区域绘制信息
    CTFrameDraw(frame, ctx);
    
    ///释放
    CFRelease(frame);
    CGPathRelease(Path);
    CFRelease(framesetter);
}

- (void)setText:(NSString *)text {
    _text = text;
}

- (void)testFunc {
    KHLog(@"类方法");
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"tag"]) {
        KHLog(@"玩哈哈哈，我被调用了");
    }
}

@end
