//
//  LayerLabel.h
//  KHealthTools
//
//  Created by kim on 2019/3/7.
//  Copyright © 2019年 lambert. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface LayerLabel : CATextLayer

@property (nonatomic,   copy) NSString *customStr;

@property (nonatomic,   copy) NSMutableAttributedString *customAttributeStr;

@property (nonatomic, assign) CGFloat customLineSpace;

@property (nonatomic, assign) NSTextAlignment customAlignment;

@end
