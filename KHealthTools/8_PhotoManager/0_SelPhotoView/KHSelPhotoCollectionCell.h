//
//  KHSelPhotoCollectionCell.h
//  KHealthModules
//
//  Created by kim on 2019/1/4.
//  Copyright © 2019年 李云新. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KHPhotoModel.h"

@interface KHSelPhotoCollectionCell : UICollectionViewCell

@property (nonatomic, strong) KHPhotoModel *model;

@property (nonatomic, strong) UIImageView *imageView;

@end
