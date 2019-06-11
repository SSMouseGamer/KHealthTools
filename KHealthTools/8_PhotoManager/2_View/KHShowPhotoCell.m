//
//  KHShowPhotoCell.m
//  KHealthModules
//
//  Created by kim on 2018/12/29.
//  Copyright © 2018年 李云新. All rights reserved.
//

#import "KHealthToolsHeader.h"
#import "KHServicesHeader.h"

#import "KHShowPhotoCell.h"
#import "KHPhotoModel+AssetDataCategory.h"

@interface KHShowPhotoCell() <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *backView;
@property (nonatomic, strong) UIImageView  *imageView;

@end

@implementation KHShowPhotoCell

#pragma mark - setter
- (void)setModel:(KHPhotoModel *)model {
    KHWeakObj(self);
    _model = model;
    
    self.backView.zoomScale = 1.0;
    
    UIImage *cacheImage = model.cacheImage;
    if (model.imageUrlStr) {
        [self.imageView kh_setImageWithURLStr:model.imageUrlStr placeholderImage:[KHTools kh_getImage_normal_placeholder] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            [weakSelf setImageContent];
        }];
        return;
    }
    
    if (cacheImage) {
        self.imageView.image = cacheImage;
        [self setImageContent];
        return;
    }
    
    [KHPhotoModel getDataWithAsset:model.asset Complete:^(BOOL success, NSData *imageData) {
        if (success) {
            weakSelf.model.cacheImage = [UIImage imageWithData:imageData];
            weakSelf.imageView.image  = weakSelf.model.cacheImage;
            [weakSelf setImageContent];
        }
    }];
}

- (void)setImageContent {
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    //图片宽度
    CGFloat iW = self.imageView.image.size.width == 0 ? 1 : self.imageView.image.size.width;
    //图片高度
    CGFloat iH = self.imageView.image.size.height;
    
    //目标展示高度 - 且展示高度不能低于容器高度
    CGFloat viewH = self.backView.kh_width * iH / iW;
    self.imageView.kh_height = viewH;
    
    if (viewH >= self.backView.kh_height) {
        self.imageView.kh_y = 0;
    } else {
        self.imageView.kh_y = (self.backView.kh_height - self.imageView.kh_height) * 0.5;
    }
    
    self.backView.contentOffset = CGPointZero;
    self.backView.contentSize   = CGSizeMake(self.backView.kh_width, viewH);
}

#pragma mark -
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.backView.delegate = self;
        self.backView.maximumZoomScale = 3.0;
        self.backView.minimumZoomScale = 1.0;
        [self.contentView addSubview:self.backView];
        self.imageView = [[UIImageView alloc] initWithFrame:self.backView.bounds];
        self.imageView.userInteractionEnabled = YES;
        [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewClick)]];
        [self.backView addSubview:self.imageView];
    }
    return self;
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

#pragma mark - action
- (void)imageViewClick {
    if (self.clickImage) {
        self.clickImage();
    }
}

- (void)setZoomScale {
    self.backView.zoomScale = 1.0;
}

@end
