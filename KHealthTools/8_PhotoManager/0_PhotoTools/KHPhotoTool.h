//
//  KHPhotoTool.h
//  KHealthModules
//
//  Created by kim on 2019/3/18.
//  Copyright © 2019年 李云新. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KHSelPhotoView.h"

#define KHPhotoToolInstance [KHPhotoTool shareInstance]

@interface KHPhotoTool : NSObject

+ (instancetype)shareInstance;

+ (KHSelPhotoView *)initPhotoViewWithFrame:(CGRect)frame style:(KHSelPhotoViewStyle)style maxCount:(NSInteger)maxCount imageArr:(NSArray *)imageArray updateUIBlock:(void(^)(void))updateUIBlock;

- (void)initPhotoAssetData;

@property (nonatomic, strong) NSArray *nameArr;

@property (nonatomic, strong) NSArray *assetArr;

@end
