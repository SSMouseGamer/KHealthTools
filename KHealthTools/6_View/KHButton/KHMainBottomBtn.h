//
//  KHMainBottomBtn.h
//  KHealthDoctor
//
//  Created by 李云新 on 2018/8/14.
//  Copyright © 2018年 lambert. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KHMainBottomBtn : UIView

@property (nonatomic, strong) UIButton *btn;

- (instancetype)initWithY:(CGFloat)y Title:(NSString *)title GoOption:(void (^)(void))option;
- (instancetype)initWithBottomY:(CGFloat)bY Title:(NSString *)title GoOption:(void (^)(void))option;

- (void)setBtnEnabled:(BOOL)b;

@end
