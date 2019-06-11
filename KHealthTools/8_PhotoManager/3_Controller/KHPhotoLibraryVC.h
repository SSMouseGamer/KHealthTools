//
//  KHPhotoLibraryVC.h
//  KHealthModules
//
//  Created by kim on 2018/12/29.
//  Copyright © 2018年 李云新. All rights reserved.
//

#import "KHPhotoModel.h"
#import "KHViewController.h"

@class KHPhotoLibraryVC;
@protocol KHPhotoLibraryVCDelegate <NSObject>
- (void)photoLibraryVC:(KHPhotoLibraryVC *)photoLibraryVC photoArr:(NSArray <KHPhotoModel *>*)photoArr;
@end

@interface KHPhotoLibraryVC : KHViewController

+ (UINavigationController *)initWithMaxCount:(NSInteger)count delegate:(id<KHPhotoLibraryVCDelegate>)delegate;

@end
