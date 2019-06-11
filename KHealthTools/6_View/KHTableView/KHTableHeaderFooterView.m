//
//  KHTableHeaderFooterView.m
//  KHealthMember
//
//  Created by kim on 2018/12/11.
//  Copyright © 2018年 李云新. All rights reserved.
//

#import "KHTableHeaderFooterView.h"

@implementation KHTableHeaderFooterView

+ (instancetype)sectionWithTableView:(UITableView *)tableView{
    NSString *Id = [NSString stringWithFormat:@"%@233Id",[self class]];
    KHTableHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:Id];
    if(!header){
        header = [[self alloc] initWithReuseIdentifier:Id];
    }
    return header;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if(self){
        [self setupSubView];
    }
    return self;
}

- (void)setupSubView {
    ///设置白色底
    self.backgroundView = ({
        UIView * view = [[UIView alloc] initWithFrame:self.bounds];
        view.backgroundColor = [UIColor whiteColor];
        view;
    });
}


@end
