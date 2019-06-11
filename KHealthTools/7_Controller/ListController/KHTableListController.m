//
//  KHTableListController.m
//  KHealthDoctor
//
//  Created by 李云新 on 2018/8/20.
//  Copyright © 2018年 lambert. All rights reserved.
//

#import "KHealthToolsHeader.h"
#import "KHTableListController.h"

@interface KHTableListController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation KHTableListController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubView];
}

- (void)setupSubView {
    
    self.tlTableView = [[KHTableView alloc] initWithFrame:self.kh_Rect];
    self.tlTableView.delegate   = self;
    self.tlTableView.dataSource = self;
    self.tlTableView.backgroundColor = KHColorF5F5F5;
    self.tlTableView.rowHeight = [[KHTableListCell alloc] init].kh_height;
    [self.view addSubview:self.tlTableView];
    
    self.tlTableView.kh_emptyView = [KHEmptyView empty];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *sectionArray = self.dataArray[section];
    return sectionArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KHTableListCell *cell = [KHTableListCell cellWithTableView:tableView];
    NSArray *sectionArray = self.dataArray[indexPath.section];
    [cell setLineViewHidden:indexPath.row == sectionArray.count - 1];
    [self cell:cell Data:sectionArray[indexPath.row] IndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray *sectionArray = self.dataArray[indexPath.section];
    [self didSelectRowAtData:sectionArray[indexPath.row] IndexPath:indexPath];
}

- (void)cell:(KHTableListCell *)cell Data:(id)dataModel IndexPath:(NSIndexPath *)indexPath {
    
}

- (void)didSelectRowAtData:(id)dataModel IndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return KHMargin;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    return view;
}

@end
