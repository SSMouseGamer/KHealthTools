//
//  KHFontSizeSettingController.h
//  KHealthTools
//
//  Created by kim on 2019/4/11.
//  Copyright © 2019年 lambert. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KHFontSizeSettingController : UIViewController

@end

@interface KHFontSizeSettingCell : UITableViewCell

+ (CGFloat)calculateCellHeightWithDict:(NSDictionary *)dict CurrentScale:(CGFloat)currentScale;

+ (instancetype)registerTableCellWithTableView:(UITableView *)tableView;

- (void)setTitleLabelWithDict:(NSDictionary *)dict;

@property (nonatomic, assign) CGFloat currentScale;

@end
