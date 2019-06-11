//
//  KHPhotoCollectionVC.h
//  KHealthModules
//
//  Created by kim on 2018/12/29.
//  Copyright © 2018年 李云新. All rights reserved.
//

#import "KHPhotoModel.h"
#import "KHViewController.h"

@class KHPhotoCollectionVC;
@protocol KHPhotoCollectionVCDelegate <NSObject>
- (void)photoCollectionVC:(KHPhotoCollectionVC *)photoVC photoArr:(NSArray <KHPhotoModel*>*)photoArr;
@end

@interface KHPhotoCollectionVC : KHViewController

- (instancetype)initWithDataArray:(PHFetchResult *)dataArr maxCount:(NSInteger)maxCount;

@property (nonatomic, weak) id <KHPhotoCollectionVCDelegate> delegate;

@end
