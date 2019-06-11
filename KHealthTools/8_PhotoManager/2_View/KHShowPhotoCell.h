//
//  KHShowPhotoCell.h
//  KHealthModules
//
//  Created by kim on 2018/12/29.
//  Copyright © 2018年 李云新. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KHPhotoModel.h"

@interface KHShowPhotoCell : UICollectionViewCell

@property (nonatomic, strong) KHPhotoModel *model;
@property (nonatomic,   copy) void (^clickImage)(void);

///设置缩放比例
- (void)setZoomScale;

@end
