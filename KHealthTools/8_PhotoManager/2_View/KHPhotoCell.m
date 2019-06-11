//
//  KHPhotoCell.m
//  KHealthModules
//
//  Created by kim on 2018/12/29.
//  Copyright © 2018年 李云新. All rights reserved.
//

#import "KHealthToolsHeader.h"
#import "KHServicesHeader.h"

#import "KHPhotoCell.h"
#import "KHPhotoModel+AssetDataCategory.h"

@interface KHPhotoCell()

@property (nonatomic, strong) UIButton *selBtn;

@end

@implementation KHPhotoCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.clipsToBounds = YES;
        self.contentView.layer.contentsGravity = kCAGravityResizeAspectFill;
        CGFloat selW = 21 * KHScale;
        self.selBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - selW - 1, 1, selW, selW)];
        [self.selBtn setImage:[KHTools kh_getToolsBundleImage:@"kht_photo_noSel"] forState:UIControlStateNormal];
        [self.selBtn setImage:[KHTools kh_getToolsBundleImage:@"kht_photo_Sel"] forState:UIControlStateSelected];
        self.selBtn.userInteractionEnabled = NO;
        [self.contentView addSubview:self.selBtn];
    }
    return self;
}

- (void)setModel:(KHPhotoModel *)model {
    _model = model;
    self.selBtn.selected = model.is_sel;
    KHWeakObj(self);
    if (model.thumialImage) {
        self.contentView.layer.contents = (id)model.thumialImage.CGImage;
        return;
    }
    [KHPhotoModel getThumialImageWithAsset:model.asset Complete:^(UIImage *image, NSDictionary *info) {
        weakSelf.model.thumialImage = image;
        weakSelf.contentView.layer.contents = (id)image.CGImage;
    }];
}

@end
