//
//  KHFuncModel.h
//  KHealthDoctor
//
//  Created by 李云新 on 2018/8/13.
//  Copyright © 2018年 lambert. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KHFuncModel : NSObject

///图标
@property (nonatomic,   copy) NSString *icon;

@property (nonatomic,   copy) NSString *title;
@property (nonatomic,   copy) NSString *text;
@property (nonatomic,   copy) NSString *desc;
@property (nonatomic, strong) UIColor  *descColor;

///点void击的block
@property (nonatomic, copy) void (^clickOption)(void);

///cellHeight - 用于界面适配：我的资料界面
@property (nonatomic, assign) CGFloat cellHeight;

- (instancetype)initWithTitle:(NSString *)title Text:(NSString *)text Desc:(NSString *)desc;

- (instancetype)initWithIcon:(NSString *)icon
                       Title:(NSString *)title
                        Text:(NSString *)text
                        Desc:(NSString *)desc
                 ClickOption:(void (^)(void))option;

@end
