//
//  UIScrollView+KHEmpty.h
//  KHealthDoctor
//
//  Created by 李云新 on 2018/8/22.
//  Copyright © 2018年 lambert. All rights reserved.
//

#import "KHEmptyView.h"

@interface UIScrollView (KHEmpty)

///空白页
@property (nonatomic, strong) KHEmptyView *kh_emptyView;

@end

@interface UITableView (KHEmpty)

///是否显示空白页
- (void)kh_isShowEmpth;

@end
