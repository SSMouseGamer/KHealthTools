//
//  TextLayerCell.h
//  KHealthTools
//
//  Created by kim on 2019/3/8.
//  Copyright © 2019年 lambert. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LayerLabel.h"
#import "KLayerLabel.h"
#import "LabelView.h"

@interface TextLayerCell : UITableViewCell

+ (instancetype)aaaCellWithTable:(UITableView *)tableView;

@property (nonatomic, strong) LabelView *textL;

- (void)testFunc;

@end
