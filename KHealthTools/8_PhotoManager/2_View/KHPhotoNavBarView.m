//
//  KHPhotoNavBarView.m
//  KHealthModules
//
//  Created by kim on 2018/12/29.
//  Copyright © 2018年 李云新. All rights reserved.
//

#import "KHealthToolsHeader.h"
#import "KHServicesHeader.h"
#import "KHPhotoNavBarView.h"

@implementation KHPhotoNavBarView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupSubView];
    }
    return self;
}

- (void)setupSubView {
    self.backgroundColor = [UIColor clearColor];
    CGFloat vH = KH_Navi_Height;
    self.frame = CGRectMake(0, 0, KHScreenWidth, vH);
    CGFloat tY = KH_StatusBar_Height;
    CGFloat tW = KHScreenWidth * 0.5;
    CGFloat tH = KH_Navi_Title_Height;
    self.titleL = [[UILabel alloc] initWithFrame:CGRectMake(0, tY, tW, tH)];
    self.titleL.textColor = [UIColor whiteColor];
    self.titleL.textAlignment = NSTextAlignmentCenter;
    self.titleL.font = KHFont16;
    self.titleL.text = @"";
    [self addSubview:self.titleL];
    self.titleL.kh_centerX = self.kh_centerX;
    
    CGRect bR = CGRectMake(0, 0, KH_Navi_Title_Height, KH_Navi_Title_Height);
    self.backBtn = [[UIButton alloc] initWithFrame:bR];
    [self.backBtn setImage:KHTools.naviBackImg_White
                  forState:(UIControlStateNormal)];
    [self.backBtn addTarget:self action:@selector(backBtnClick)
           forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:self.backBtn];
    self.backBtn.kh_centerY = self.titleL.kh_centerY;
    
    CGFloat sW = 22.0;
    CGFloat sX = KHScreenWidth - KHMargin - sW;
    self.selBtn = [[UIButton alloc] initWithFrame:CGRectMake(sX, 0, sW, sW)];
    [self.selBtn setBackgroundImage:KHTools.chooseImg_Sel_White
                               forState:(UIControlStateNormal)];
    [self.selBtn setBackgroundImage:KHTools.chooseImg_Sel
                               forState:(UIControlStateSelected)];
    [self.selBtn addTarget:self action:@selector(selBtnClicked:)
          forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.selBtn];
    
    self.selBtn.kh_centerY = self.titleL.kh_centerY;
}
#pragma mark - action
- (void)backBtnClick {
    if (self.backClick) {
        self.backClick();
    }
}

- (void)selBtnClicked:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (self.selClick) {
        self.selClick(sender.selected);
    }
}
@end
