//
//  KHPhotoToolBarView.h
//  KHealthModules
//
//  Created by kim on 2018/12/29.
//  Copyright © 2018年 李云新. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KHPhotoToolBarView : UIView

/**
 初始化时预览和确定按钮的点击事件默认都为不允许，需设置enable的属性

 @param y 当前容器的高度
 @return  KHPhotoToolBarView
 */
+ (instancetype)initWithBottomY:(CGFloat)y;

///预览
@property (nonatomic, strong) UIButton *preViewBtn;
///确认
@property (nonatomic, strong) UIButton *sureBtn;
///预览回调
@property (nonatomic,   copy) void (^preViewClick)(void);
///确定回调
@property (nonatomic,   copy) void (^sureClick)(void);
@end
