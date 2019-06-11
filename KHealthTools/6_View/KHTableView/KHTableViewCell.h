//
//  KHTableViewCell.h
//  KHealthDoctor
//
//  Created by 李云新 on 2018/8/16.
//  Copyright © 2018年 lambert. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KHTableViewCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;

- (void)setupSubView;

@end
