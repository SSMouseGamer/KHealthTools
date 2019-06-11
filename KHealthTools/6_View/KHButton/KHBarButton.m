//
//  KHBarButton.m
//  KHealthDoctor
//
//  Created by 李云新 on 2018/8/23.
//  Copyright © 2018年 lambert. All rights reserved.
//

#import "KHealthToolsHeader.h"
#import "KHBarButton.h"

#define DefaultMargin 5

@interface KHBarButton()

@property (nonatomic, copy) void (^clickOption)(void);

@end

@implementation KHBarButton

- (UIBarButtonItem *)getBarItem {
    return [[UIBarButtonItem alloc] initWithCustomView:self];
}

+ (instancetype)leftBtnWithTitle:(NSString *)title Color:(UIColor *)color ClickOption:(void (^)(void))option {
    
    return [[self alloc] initWithTitle:title
                                 Image:nil
                                 Color:color
                                Conten:0
                                Margin:DefaultMargin
                           ClickOption:option];
}

+ (instancetype)rightBtnWithTitle:(NSString *)title Color:(UIColor *)color ClickOption:(void (^)(void))option {
    
    return [[self alloc] initWithTitle:title
                                 Image:nil
                                 Color:color
                                Conten:1
                                Margin:DefaultMargin
                           ClickOption:option];
}

+ (instancetype)btnWithImage:(NSString *)imageStr
                      Conten:(NSInteger)conten
                 ClickOption:(void (^)(void))option {
    
    return [[self alloc] initWithTitle:@""
                                 Image:imageStr
                                 Color:[UIColor clearColor]
                                Conten:conten
                                Margin:DefaultMargin
                           ClickOption:option];
}

- (instancetype)initWithTitle:(NSString *)title Image:(NSString *)imageStr Color:(UIColor *)color Conten:(NSInteger)conten Margin:(CGFloat)margin ClickOption:(void (^)(void))option {
    
    self = [super initWithFrame:CGRectMake(0, 0, 44, 44)];
    
    if (self) {
        self.clickOption = option;
        
        [self kh_setTitleColor:color];
        self.titleLabel.font = KHFont15;
        
        [self addTarget:self action:@selector(backClick:) forControlEvents:(UIControlEventTouchUpInside)];
        
        if (imageStr == nil) {
            [self setTitle:title forState:(UIControlStateNormal)];
        } else {
            [self setImage:[UIImage imageNamed:imageStr] forState:(UIControlStateNormal)];
        }
        
        if (conten == 0) {
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -margin, 0, 0);
            self.imageEdgeInsets = UIEdgeInsetsMake(0, -margin, 0, 0);
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        } else {
            self.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -margin);
            self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -margin);
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        }
    }
    return self;
}

- (void)backClick:(UIButton *)btn {
    if (self.clickOption) {
        self.clickOption();
    }
}

- (void)dealloc{
    KHLog(@"dealloc - %@", [self class]);
}

@end

