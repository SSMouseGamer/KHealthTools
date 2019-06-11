//
//  KHEmptyView.h
//  KHealthDoctor
//
//  Created by 李云新 on 2018/8/22.
//  Copyright © 2018年 lambert. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KHEmptyView : UIView

@property (nonatomic, strong) UIImageView *iconL;
@property (nonatomic, strong) UILabel *labelL;

- (instancetype) init __attribute__((unavailable("请使用empty初始化")));
+ (instancetype) new __attribute__((unavailable("请使用empty初始化")));
+ (instancetype)empty;
+ (instancetype)emptyWithTitle:(NSString *)title;
+ (instancetype)emptyWithIcon:(NSString *)icon;
+ (instancetype)emptyWithIcon:(NSString *)icon Title:(NSString *)title;

- (void)showInView:(UIView *)view Count:(NSInteger)count;
- (void)showInView:(UIView *)view;
- (void)hide;

- (void)setIconY:(CGFloat)y;

@end
