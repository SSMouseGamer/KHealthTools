//
//  UIScrollView+KHRefresh.h
//  KHealthDoctor
//
//  Created by 李云新 on 2018/9/4.
//  Copyright © 2018年 lambert. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (KHRefresh)

- (void)kh_endRefreshing;
- (void)kh_addHeaderRefresh:(void (^)(void))option;
- (void)kh_addHeaderRefreshTarget:(id)target Action:(SEL)action;
- (void)kh_removeAllRefresh;
- (void)kh_noMoreData:(BOOL)isNoMore;

- (BOOL)kh_isHeaderRefreshing;
- (BOOL)kh_isFooterRefreshing;

@end

@interface UITableView (KHRefresh)

- (void)kh_addFooterRefresh:(void (^)(void))option;
- (void)kh_addFooterRefreshTarget:(id)target Action:(SEL)action;

@end

@interface UICollectionView (KHRefresh)

- (void)kh_addFooterRefresh:(void (^)(void))option;
- (void)kh_addFooterRefreshTarget:(id)target Action:(SEL)action;

@end
