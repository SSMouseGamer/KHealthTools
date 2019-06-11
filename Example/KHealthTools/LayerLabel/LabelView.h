//
//  LabelView.h
//  KHealthTools
//
//  Created by kim on 2019/3/11.
//  Copyright © 2019年 lambert. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LabelView : UIView

@property (nonatomic, strong) NSString *text;

@property (nonatomic, strong) UIFont *font;

@property (nonatomic, assign) CGFloat lineHeight;

- (void)testFunc;

@end
