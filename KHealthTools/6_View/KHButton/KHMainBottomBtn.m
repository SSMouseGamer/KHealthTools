//
//  KHMainBottomBtn.m
//  KHealthDoctor
//
//  Created by 李云新 on 2018/8/14.
//  Copyright © 2018年 lambert. All rights reserved.
//

#import "KHealthToolsHeader.h"
#import "KHMainBottomBtn.h"

@interface KHMainBottomBtn()

@property (nonatomic, copy) void (^goBtnClickOption)(void);

@end

@implementation KHMainBottomBtn

- (instancetype)initWithY:(CGFloat)y Title:(NSString *)title GoOption:(void (^)(void))option {
    self = [super init];
    if (self) {
        [self setupSubViewWithY:y Title:title IsBottom:NO];
        self.goBtnClickOption = option;
    }
    return self;
}

- (instancetype)initWithBottomY:(CGFloat)bY Title:(NSString *)title GoOption:(void (^)(void))option {
    self = [super init];
    if (self) {
        [self setupSubViewWithY:bY Title:title IsBottom:YES];
        self.goBtnClickOption = option;
    }
    return self;
}

- (void)setBtnEnabled:(BOOL)b {
    if (self.btn.isEnabled == b) {
        return;
    }
    
    [self.btn setEnabled:b];
    
    if (self.btn.isEnabled) {
        
    } else {
        
    }
}

- (void)setupSubViewWithY:(CGFloat)y Title:(NSString *)title IsBottom:(BOOL)is_bottom {
    CGFloat viewW = KHScreenWidth;
    CGFloat viewH = 65 * KHScale;
    self.frame = CGRectMake(0, is_bottom ? y - viewH : y, viewW, viewH);
    
    CGFloat bX = 31 * KHScale;
    CGFloat bW = viewW - 2 * bX;
    CGFloat bH = 45 * KHScale;
    CGFloat bY = (viewH - bH) * 0.5;
    self.btn = [[UIButton alloc] initWithFrame:CGRectMake(bX, bY, bW, bH)];
    self.btn.titleLabel.font = KHFont16;
    [self.btn setTitle:title forState:(UIControlStateNormal)];
    [self.btn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [self.btn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.btn kh_setBgImgWithNormal:KHColorTheme Highlighted:KHColorTheme2];
    self.btn.layer.cornerRadius  = bH * 0.5;
    self.btn.layer.masksToBounds = YES;
    
    [self setBtnEnabled:NO];
    [self addSubview:self.btn];
}

- (void)btnClick:(UIButton *)btn {
    if (self.goBtnClickOption) {
        self.goBtnClickOption();
    }
}

@end
