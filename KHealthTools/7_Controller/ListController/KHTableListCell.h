//
//  KHTableListCell.h
//  KHealthDoctor
//
//  Created by 李云新 on 2018/8/18.
//  Copyright © 2018年 lambert. All rights reserved.
//

#import "KHTableViewCell.h"

@interface KHTableListCell : KHTableViewCell

@property (nonatomic, strong) UIImageView *iconV;
@property (nonatomic, strong) UILabel *titleL;
@property (nonatomic, strong) UILabel *textL;
@property (nonatomic, strong) UILabel *descL;
@property (nonatomic, strong) CALayer *lineView;
@property (nonatomic, strong) UIImageView *arrowView;

///设置图标
- (void)setIcon:(NSString *)icon;
- (void)setIcon:(NSString *)icon PlaceholderImage:(UIImage *)placeholderImage;

- (void)setIconWidth:(CGFloat)w Height:(CGFloat)h;
- (void)setIconHidden:(BOOL)b;
- (void)setTextHidden:(BOOL)b;

///设置Cell的高度
- (void)setCellHeight:(CGFloat)h;

- (void)setLineViewHidden:(BOOL)b;
- (void)setArrowViewHidden:(BOOL)b;

@end
