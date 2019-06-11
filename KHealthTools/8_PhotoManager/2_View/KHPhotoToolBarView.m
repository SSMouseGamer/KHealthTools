//
//  KHPhotoToolBarView.m
//  KHealthModules
//
//  Created by kim on 2018/12/29.
//  Copyright © 2018年 李云新. All rights reserved.
//

#import "KHealthToolsHeader.h"
#import "KHPhotoToolBarView.h"

#define ToolBarHeight 50.0

@implementation KHPhotoToolBarView

+ (instancetype)initWithBottomY:(CGFloat)y {
    CGFloat bottomY = y > ToolBarHeight ? y - ToolBarHeight : y;
    return [[KHPhotoToolBarView alloc] initWithFrame:CGRectMake(0, bottomY, KHScreenWidth, ToolBarHeight)];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubView];
    }
    return self;
}

- (void)setupSubView {
    self.backgroundColor = [UIColor whiteColor];
    CGFloat pW = (KHScreenWidth - 2 * KHMargin) * 0.5;
    CGFloat pH = 30.0;
    CGFloat pY = 10.0;
    self.preViewBtn = [[UIButton alloc] initWithFrame:CGRectMake(KHMargin * 2, pY, pW, pH)];
    [self.preViewBtn setTitle:@"预览" forState:UIControlStateNormal];
    [self.preViewBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.preViewBtn setTitleColor:KHColorCDCDCD forState:UIControlStateDisabled];
    self.preViewBtn.enabled = NO;
    [self.preViewBtn.titleLabel setFont:KHFont13];
    self.preViewBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.preViewBtn addTarget:self action:@selector(preViewBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.preViewBtn];
    
    CGFloat sW = 70;
    CGFloat sX = KHScreenWidth - sW - KHMargin;
    self.sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(sX, pY, sW, pH)];
    [self.sureBtn setTitle:@"确定 0/0" forState:UIControlStateNormal];
    [self.sureBtn.titleLabel setFont:KHFont13];
    [self.sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.sureBtn setBackgroundImage:[KHColorF5F5F5 kh_getImageWithSize:self.sureBtn.kh_size Radius:2.0] forState:(UIControlStateDisabled)];
    [self.sureBtn setBackgroundImage:[KH_RGBA( 38, 183, 188, 1) kh_getImageWithSize:self.sureBtn.kh_size Radius:2.0] forState:(UIControlStateNormal)];
    self.sureBtn.enabled = NO;
    [self.sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.sureBtn];
}

#pragma mark - action
- (void)preViewBtnClick {
    if (self.preViewClick) {
        self.preViewClick();
    }
}

- (void)sureBtnClick {
    if (self.sureClick) {
        self.sureClick();
    }
}

@end
