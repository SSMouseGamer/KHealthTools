//
//  KHShowPhotoVC.h
//  KHealthModules
//
//  Created by kim on 2018/12/29.
//  Copyright © 2018年 李云新. All rights reserved.
//

#import "KHPhotoModel.h"
#import "KHClearNaviController.h"

@class KHShowPhotoVC;
@protocol KHShowPhotoVCDelegate<NSObject>
///修改后回调刷新,只有更改后确定的时候才会触发
- (void)showPhotoVC:(KHShowPhotoVC *)showPhotoVC refreshPhotoArr:(NSArray <KHPhotoModel *>*)photoArr;
@optional
- (void)showPhotoVC:(KHShowPhotoVC *)showPhotoVC backClick:(NSString *)backStr;
@end

@interface KHShowPhotoVC : KHClearNaviController

/**
 选择图片情景的初始化

 @param dataArr 初始化数据
 @param selIndex 选中的下标
 @return KHShowPhotoVC
 */
- (instancetype)initWithDataArr:(NSArray <KHPhotoModel *>*)dataArr selIndex:(NSInteger)selIndex;
///显示方式
@property (nonatomic, assign) KHSelPhotoViewStyle showType;
///代理
@property (nonatomic,   weak) id<KHShowPhotoVCDelegate> delegate;

@end
