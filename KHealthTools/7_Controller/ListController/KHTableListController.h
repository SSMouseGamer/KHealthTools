//
//  KHTableListController.h
//  KHealthDoctor
//
//  Created by 李云新 on 2018/8/20.
//  Copyright © 2018年 lambert. All rights reserved.
//

#import "KHViewController.h"

#import "KHTableListCell.h"
#import "KHTableView.h"

@interface KHTableListController : KHViewController

@property (nonatomic, strong) KHTableView *tlTableView;
@property (nonatomic, strong) NSArray *dataArray;

- (void)cell:(KHTableListCell *)cell Data:(id)dataModel IndexPath:(NSIndexPath *)indexPath;
- (void)didSelectRowAtData:(id)dataModel IndexPath:(NSIndexPath *)indexPath;

- (void)setupSubView;

@end
