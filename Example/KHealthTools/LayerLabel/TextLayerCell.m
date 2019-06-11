//
//  TextLayerCell.m
//  KHealthTools
//
//  Created by kim on 2019/3/8.
//  Copyright © 2019年 lambert. All rights reserved.
//

#import "TextLayerCell.h"
#import "KHealthTools/KHealthTools.h"

@implementation TextLayerCell

+ (instancetype)aaaCellWithTable:(UITableView *)tableView {
    TextLayerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"2333"];
    if (!cell) {
        cell = [[TextLayerCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"2333"];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubview];
    }
    return self;
}

- (void)setupSubview {
    self.frame = CGRectMake(0, 0, KHScreenWidth, 60.0);
    self.contentView.frame = self.frame;
    self.textL = [[LabelView alloc] initWithFrame:self.frame];//[LayerLabel kh_textLayerWithFrame:self.contentView.frame Font:KHFontOfSize(30.0) Auto:NO];
    self.textL.font = KHFont13;
//    self.textL.customLineSpace = 10.0;
//    self.textL.customAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.textL];
    
    [self.contentView.layer kh_addLineBottomWithX:0];
//    [self.textL testFunc];
    KHLog(@"self调用");
    self.tag = 1111;
}

- (void)testFunc {
    _textL.tag = 2333;
    KHLog(@"非self调用");
}


@end
