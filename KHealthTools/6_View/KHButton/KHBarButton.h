//
//  KHBarButton.h
//  KHealthDoctor
//
//  Created by 李云新 on 2018/8/23.
//  Copyright © 2018年 lambert. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KHBarButton : UIButton

+ (instancetype)leftBtnWithTitle:(NSString *)title
                           Color:(UIColor *)color
                     ClickOption:(void (^)(void))option;

+ (instancetype)rightBtnWithTitle:(NSString *)title
                            Color:(UIColor *)color
                      ClickOption:(void (^)(void))option;

+ (instancetype)btnWithImage:(NSString *)imageStr
                      Conten:(NSInteger)conten
                 ClickOption:(void (^)(void))option;

- (UIBarButtonItem *)getBarItem;

@end


