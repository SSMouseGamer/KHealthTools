//
//  KHToolsBaseFont.m
//  KHealthTools
//
//  Created by 李云新 on 2019/3/8.
//

#import "KHToolsBaseFont.h"

#define KH_FONT_SCALE_KEY @"KH_FONT_SCALE_KEY"

@implementation KHToolsBaseFont

+ (instancetype)share {
    static dispatch_once_t onceToken;
    static id instance;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        CGFloat fontScale = [userDefault floatForKey:KH_FONT_SCALE_KEY];
        if (fontScale < 1 ) {
            fontScale = 1.0;
        }
        self.fontScale = fontScale;
        _font11 = [UIFont systemFontOfSize:11.0];
        _font12 = [UIFont systemFontOfSize:12.0];
        _font13 = [UIFont systemFontOfSize:13.0];
        _font14 = [UIFont systemFontOfSize:14.0];
        _font15 = [UIFont systemFontOfSize:15.0];
        _font16 = [UIFont systemFontOfSize:16.0];
        _font18 = [UIFont systemFontOfSize:18.0];
        
    }
    return self;
}

- (void)setFontScale:(CGFloat)fontScale {
    _fontScale = fontScale;
    _autoFont11 = [UIFont systemFontOfSize:_fontScale * 11.0];
    _autoFont12 = [UIFont systemFontOfSize:_fontScale * 12.0];
    _autoFont13 = [UIFont systemFontOfSize:_fontScale * 13.0];
    _autoFont14 = [UIFont systemFontOfSize:_fontScale * 14.0];
    _autoFont15 = [UIFont systemFontOfSize:_fontScale * 15.0];
    _autoFont16 = [UIFont systemFontOfSize:_fontScale * 16.0];
    _autoFont18 = [UIFont systemFontOfSize:_fontScale * 18.0];
}

- (void)saveFontScale:(CGFloat)fontScale {
    self.fontScale = fontScale;
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setFloat:fontScale forKey:KH_FONT_SCALE_KEY];
    [userDefault synchronize];

}

@end

