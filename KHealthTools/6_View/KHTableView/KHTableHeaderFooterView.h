//
//  KHTableHeaderFooterView.h
//  KHealthMember
//
//  Created by kim on 2018/12/11.
//  Copyright © 2018年 李云新. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KHTableHeaderFooterView : UITableViewHeaderFooterView

+ (instancetype)sectionWithTableView:(UITableView *)tableView;
///实现过并设置白色底色
- (void)setupSubView;

@end
