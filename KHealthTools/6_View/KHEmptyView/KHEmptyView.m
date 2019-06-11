//
//  KHEmptyView.m
//  KHealthDoctor
//
//  Created by 李云新 on 2018/8/22.
//  Copyright © 2018年 lambert. All rights reserved.
//

#import "KHEmptyView.h"
#import "KHealthToolsHeader.h"

@interface KHEmptyView()

@end

@implementation KHEmptyView

- (void)showInView:(UIView *)view Count:(NSInteger)count {
    if (count <= 0) {
        [self showInView:view];
    } else {
        [self hide];
    }
}

- (void)showInView:(UIView *)view {
    [view addSubview:self];
    [UIView animateWithDuration:0.28f animations:^{
        self.alpha = 1;
    }];
}

- (void)hide {
    [UIView animateWithDuration:0.28f animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)setIconY:(CGFloat)y {
    self.iconL.kh_y = y;
    self.labelL.kh_y = self.iconL.kh_maxY + 20 * KHScale;
}

+ (instancetype)empty {
    return [KHEmptyView emptyWithIcon:@"kht_empty_reserve" Title:@"当前页面空空如也"];
}

+ (instancetype)emptyWithTitle:(NSString *)title {
    return [KHEmptyView emptyWithIcon:@"kht_empty_reserve" Title:title];
}

+ (instancetype)emptyWithIcon:(NSString *)icon {
    return [KHEmptyView emptyWithIcon:icon Title:@"当前页面空空如也"];
}

+ (instancetype)emptyWithIcon:(NSString *)icon Title:(NSString *)title {
    return [[self alloc] initWithIcon:icon Title:title];
}

- (instancetype)initWithIcon:(NSString *)icon Title:(NSString *)title {
    self = [super init];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = KHColorF5F5F5;
        [self setupSubViewWithIcon:icon Title:title];
    }
    return self;
}

- (void)setupSubViewWithIcon:(NSString *)icon Title:(NSString *)title {
    self.alpha = 0;
    
    UIImage *iconImg = [KHTools kh_getToolsBundleImage:icon];
    
    CGFloat iW = iconImg.size.width;
    CGFloat iH = iconImg.size.height;
    CGFloat iX = (KHScreenWidth - iW) * 0.5;
    CGFloat iY = 93 * KHScale;
    self.iconL = [[UIImageView alloc] initWithFrame:CGRectMake(iX, iY, iW, iH)];
    self.iconL.image = iconImg;
    [self addSubview:self.iconL];
    
    self.labelL = [[UILabel alloc] initWithFrame:CGRectMake(0, self.iconL.kh_maxY + 20 * KHScale, KHScreenWidth, 14)];
    self.labelL.textAlignment = NSTextAlignmentCenter;
    self.labelL.textColor = KHColor999999;
    self.labelL.font = KHFont14;
    self.labelL.text = title;
    [self addSubview:self.labelL];
}

@end
