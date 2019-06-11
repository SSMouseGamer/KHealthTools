//
//  KHTableView.m
//  KHealthDoctor
//
//  Created by 李云新 on 2018/8/16.
//  Copyright © 2018年 lambert. All rights reserved.
//

#import "KHealthToolsHeader.h"
#import "UIScrollView+KHRefresh.h"
#import "KHTableView.h"

@interface KHTableView()

@end


@implementation KHTableView

- (void)reloadData {
    [self kh_endRefreshing];
    [super reloadData];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self setupSubView];
    }
    return self;
}

- (void)setupSubView {
    
}

@end
