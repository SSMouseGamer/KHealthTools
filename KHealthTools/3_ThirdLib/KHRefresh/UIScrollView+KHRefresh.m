//
//  UIScrollView+KHRefresh.m
//  KHealthDoctor
//
//  Created by 李云新 on 2018/9/4.
//  Copyright © 2018年 lambert. All rights reserved.
//

#import "UIScrollView+KHRefresh.h"
#import "MJRefresh.h"

@implementation UIScrollView (KHRefresh)

- (BOOL)kh_isHeaderRefreshing {
    return self.mj_header.refreshing;
}

- (BOOL)kh_isFooterRefreshing {
    return self.mj_footer.refreshing;
}

- (void)kh_endRefreshing {
    [self.mj_header endRefreshing];
    [self.mj_footer endRefreshing];
}

- (void)kh_addHeaderRefresh:(void (^)(void))option {
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:option];
}

- (void)kh_addHeaderRefreshTarget:(id)target Action:(SEL)action {
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:action];
}

- (void)kh_removeAllRefresh {
    [self.mj_header endRefreshing];
    [self.mj_footer endRefreshing];
    [self.mj_header removeFromSuperview];
    [self.mj_footer removeFromSuperview];
    self.mj_header = nil;
    self.mj_footer = nil;
}

- (void)kh_noMoreData:(BOOL)isNoMore {
    if (isNoMore) {
        [self.mj_footer endRefreshingWithNoMoreData];
    } else {
        [self.mj_footer endRefreshing];
    }
    
}

@end


#pragma mark - -------------------------- UITableView (KHRefresh) --------------------------
@implementation UITableView (KHRefresh)

- (void)kh_addFooterRefresh:(void (^)(void))option {
    self.estimatedRowHeight = 0;
    self.estimatedSectionHeaderHeight = 0;
    self.estimatedSectionFooterHeight = 0;
    self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:option];
}

- (void)kh_addFooterRefreshTarget:(id)target Action:(SEL)action {
    self.estimatedRowHeight = 0;
    self.estimatedSectionHeaderHeight = 0;
    self.estimatedSectionFooterHeight = 0;
    self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:target refreshingAction:action];
}

@end

#pragma mark - -------------------------- UICollectionView (KHRefresh) --------------------------
@implementation UICollectionView (KHRefresh)

- (void)kh_addFooterRefresh:(void (^)(void))option {
    self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:option];
}

- (void)kh_addFooterRefreshTarget:(id)target Action:(SEL)action {
    self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:target refreshingAction:action];
}

@end
