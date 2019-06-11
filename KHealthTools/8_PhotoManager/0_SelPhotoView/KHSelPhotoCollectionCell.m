//
//  KHSelPhotoCollectionCell.m
//  KHealthModules
//
//  Created by kim on 2019/1/4.
//  Copyright © 2019年 李云新. All rights reserved.
//

#import "KHServicesHeader.h"
#import "KHealthToolsHeader.h"

#import "KHSelPhotoCollectionCell.h"
#import "KHPhotoModel+AssetDataCategory.h"

@implementation KHSelPhotoCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView.layer.masksToBounds = YES;
        [self.contentView addSubview:self.imageView];
    }
    return self;
}
 
- (void)setModel:(KHPhotoModel *)model {
    KHWeakObj(self);
    _model = model;
    if (model.imageUrlStr) {
        [self.imageView kh_setImageWithURLStr:model.imageUrlStr placeholderImage:[KHTools kh_getImage_normal_placeholder] completed:nil];
        return;
    }
    if (model.cacheImage) {
        self.imageView.image = model.cacheImage;
        return;
    }
    if (model.thumialImage) {
        self.imageView.image = model.thumialImage;
        return;
    }
    [KHPhotoModel getThumialImageWithAsset:model.asset Complete:^(UIImage *image, NSDictionary *info) {
        weakSelf.imageView.image = image;
        weakSelf.model.thumialImage = image;
    }];
}

@end
