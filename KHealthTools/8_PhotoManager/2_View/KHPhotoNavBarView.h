//
//  KHPhotoNavBarView.h
//  KHealthModules
//
//  Created by kim on 2018/12/29.
//  Copyright © 2018年 李云新. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KHPhotoNavBarView : UIView

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UIButton *backBtn;

@property (nonatomic, strong) UIButton *selBtn;

@property (nonatomic,   copy) void(^backClick)(void);

@property (nonatomic,   copy) void (^selClick)(BOOL is_sel);

@end
