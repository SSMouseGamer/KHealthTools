//
//  KHFuncModel.m
//  KHealthDoctor
//
//  Created by 李云新 on 2018/8/13.
//  Copyright © 2018年 lambert. All rights reserved.
//

#import "KHealthToolsHeader.h"
#import "KHFuncModel.h"

@implementation KHFuncModel

- (instancetype)initWithIcon:(NSString *)icon
                       Title:(NSString *)title
                        Text:(NSString *)text
                        Desc:(NSString *)desc
                 ClickOption:(void (^)(void))option {
    self = [super init];
    if (self) {
        self.icon  = icon;
        self.title = title;
        self.text  = text;
        self.desc  = desc;
        self.clickOption = option;
        self.descColor = KHColor333333;
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title Text:(NSString *)text Desc:(NSString *)desc {
    return [self initWithIcon:@"" Title:title Text:text Desc:desc ClickOption:nil];
}

@end
