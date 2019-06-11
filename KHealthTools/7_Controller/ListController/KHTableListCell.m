//  KHTableListCell.m
//  KHealthDoctor
//
//  Created by 李云新 on 2018/8/18.
//  Copyright © 2018年 lambert. All rights reserved.
//

#import "KHealthToolsHeader.h"
#import "KHServicesHeader.h"

#import "KHTableListCell.h"

@interface KHTableListCell()

@end

@implementation KHTableListCell

#pragma mark - 设置高度
- (void)setCellHeight:(CGFloat)h {
    if (self.kh_height == h) {
        return;
    }
    
    //高度
    self.kh_height = h;
    self.contentView.kh_height = self.kh_height;
    
    //刷新UI
    [self reloadView];
}

- (void)reloadView {
    //右边描述 + 箭头
    self.descL.kh_height = self.kh_height;
    self.arrowView.kh_centerY = self.kh_height * 0.5;
    
    //底部分割线
    self.lineView.kh_y = self.kh_height - self.lineView.kh_height;
    
    //title 和 text
    if (self.textL.hidden == YES) {
        self.titleL.kh_centerY = self.kh_height * 0.5;
        
    } else {
        CGFloat margin = 6;
        CGFloat y = 0.5 * (self.kh_height - self.titleL.kh_height - margin - self.textL.kh_height);
        
        self.titleL.kh_y = y;
        self.textL.kh_y = self.titleL.kh_maxY + margin;
    }
}

#pragma mark - 设置子控件UI
///设置图标
- (void)setIcon:(NSString *)icon {
    [self setIcon:icon PlaceholderImage:nil];
}

- (void)setIcon:(NSString *)icon PlaceholderImage:(UIImage *)placeholderImage {
    [self.contentView addSubview:self.iconV];
    
    //设置位置
    [self setIconHidden:NO];
    
    //设置图片
    if ([icon hasPrefix:@"http"] || icon.length == 0) {
        if (placeholderImage == nil) {
            [self.iconV kh_setImageWithURLStr:icon];
        } else {
            [self.iconV kh_setImageWithURLStr:icon placeholderImage:placeholderImage completed:nil];
        }
    } else {
        self.iconV.image = [UIImage imageNamed:icon];
        self.iconV.contentMode = UIViewContentModeScaleAspectFit;
    }
}

- (void)setIconWidth:(CGFloat)w Height:(CGFloat)h {
    if (self.iconV.tag != w * h) {
        self.iconV.frame = CGRectMake(KH15Margin, (self.kh_height - h) * 0.5, w, h);
        self.iconV.tag = w * h;
        
        CGFloat x = KH15Margin + self.iconV.bounds.size.width + 8;
        CGFloat w = self.arrowView.kh_x - x;
        
        self.titleL.kh_x = x;
        self.titleL.kh_width = w;
        
        self.textL.kh_x  = x;
        self.textL.kh_width  = w;
    }
}

- (void)setIconHidden:(BOOL)b {
    if (self.iconV.hidden == b) {
        return;
    }
    
    self.iconV.hidden = b;
    if (b) {
        CGFloat x = KH15Margin;
        self.titleL.kh_x = x;
        self.titleL.kh_width = self.arrowView.kh_x - x;
        
        self.textL.kh_x  = x;
        self.textL.kh_width  = self.arrowView.kh_x - x;
        
    } else {
        CGFloat x = KH15Margin + self.iconV.bounds.size.width + 8;
        CGFloat w = self.arrowView.kh_x - x;
        
        self.titleL.kh_x = x;
        self.titleL.kh_width = w;
        
        self.textL.kh_x  = x;
        self.textL.kh_width  = w;
    }
}


- (void)setTextHidden:(BOOL)b {
    if (self.textL.hidden == b) {
        return;
    }
    
    self.textL.hidden = b;
    [self reloadView];
}

-(void)setLineViewHidden:(BOOL)b {
    self.lineView.hidden = b;
}

- (void)setArrowViewHidden:(BOOL)b {
    self.arrowView.hidden = b;
}

#pragma mark - 初始化
- (void)setupSubView {
    [super setupSubView];
    self.selectionStyle = UITableViewCellSelectionStyleGray;
    
    self.frame = CGRectMake(0, 0, KHScreenWidth, 75 * KHScale);
    self.contentView.frame = self.bounds;
    
    CGFloat aW = 12;
    CGFloat aX = self.kh_width - aW - KH15Margin;
    CGFloat aY = (self.kh_height - aW) * 0.5;
    self.arrowView = [[UIImageView alloc] initWithFrame:CGRectMake(aX, aY, aW, aW)];
    self.arrowView.image = [KHTools kh_getImage_Aarrow_Right];
    [self.contentView addSubview:self.arrowView];
    
    UIFont *tF    = KHFont15;
    UIFont *textF = KHFont12;
    CGFloat tM = 6;
    CGFloat tX = KH15Margin;
    CGFloat tW = self.arrowView.kh_x - tX;
    CGFloat tY = (self.kh_height - tF.lineHeight - tM - textF.lineHeight) * 0.5;
    
    self.titleL = [[UILabel alloc] initWithFrame:CGRectMake(tX, tY, tW, tF.lineHeight)];
    self.titleL.textColor = KHColor333333;
    self.titleL.font = tF;
    [self.contentView addSubview:self.titleL];
    
    self.textL = [[UILabel alloc] initWithFrame:CGRectMake(tX, self.titleL.kh_maxY + tM, tW, textF.lineHeight)];
    self.textL.textColor = KHColor999999;
    self.textL.font = textF;
    [self.contentView addSubview:self.textL];
    
    CGFloat dW = KHScreenWidth * 0.4;
    CGFloat dX = self.arrowView.kh_x - dW - 4;
    self.descL = [[UILabel alloc] initWithFrame:CGRectMake(dX, 0, dW, self.kh_height)];
    self.descL.textColor = KHColor999999;
    self.descL.font = KHFont12;
    self.descL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.descL];
    
    self.lineView = [self.contentView.layer kh_addLineBottomWithX:tX];
}

- (UIImageView *)iconV {
    if (!_iconV) {
        CGFloat iH = self.kh_height * 0.7;
        CGFloat iW = iH * 75 / 56;
        CGFloat iY = (self.kh_height - iH) * 0.5;
        _iconV = [[UIImageView alloc] initWithFrame:CGRectMake(KH15Margin, iY, iW, iH)];
        _iconV.tag = 0;
        _iconV.hidden = YES;
    }
    return _iconV;
}

@end
