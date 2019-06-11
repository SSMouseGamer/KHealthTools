//
//  KHTableViewCell.m
//  KHealthDoctor
//
//  Created by 李云新 on 2018/8/16.
//  Copyright © 2018年 lambert. All rights reserved.
//

#import "KHTableViewCell.h"

@implementation KHTableViewCell

#pragma mark 创建方法
+(instancetype)cellWithTableView:(UITableView *)tableView{
    NSString *cellIdentifier = [NSString stringWithFormat:@"%@123321",[self class]];
    KHTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil ){
        cell = [[self alloc] initWithStyle:(UITableViewCellStyleValue2) reuseIdentifier:cellIdentifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupSubView];
    }
    return self;
}

- (void)setupSubView {
    
}

@end
