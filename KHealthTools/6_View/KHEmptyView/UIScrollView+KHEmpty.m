//
//  UIScrollView+KHEmpty.m
//  KHealthDoctor
//
//  Created by 李云新 on 2018/8/22.
//  Copyright © 2018年 lambert. All rights reserved.
//

#import "UIScrollView+KHEmpty.h"
#import <objc/Runtime.h>

@implementation UIScrollView (KHEmpty)

- (KHEmptyView *)kh_emptyView {
    return objc_getAssociatedObject(self, @"UIScrollView+KHEmpty");
}

- (void)setKh_emptyView:(KHEmptyView *)kh_emptyView {
    objc_setAssociatedObject(self, @"UIScrollView+KHEmpty", kh_emptyView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end


@implementation UITableView (KHEmpty)

///是否显示空白页
- (void)kh_isShowEmpth {
    [self.kh_emptyView showInView:self Count:self.visibleCells.count];
}

@end
