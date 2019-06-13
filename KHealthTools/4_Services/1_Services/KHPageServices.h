//
//  KHPageServices.h
//  KHealthDoctor
//
//  Created by 李云新 on 2019/1/10.
//  Copyright © 2019年 lambert. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KHServicesTask.h"
#import "KHServicesMacro.h"

@interface KHPageServices : NSObject

///初始化
- (instancetype)initWithTask:(KHServicesTask *)task CompleBlock:(KHServicePageOption)cBlock;

///设置网络访问参数
- (void)setParam:(NSDictionary *)parma;

///单页数量
@property (nonatomic, assign) NSInteger pageSize;

///页码Key - 默认pageNo
@property (nonatomic,   copy) NSString *pageNoKey;
///单页数量Key - 默认pageSize
@property (nonatomic,   copy) NSString *pageSizeKey;
///最大页数Key - 默认count
@property (nonatomic,   copy) NSString *totalPageKey;

///获取首页数据
- (void)reloadData;
///加载更多数据
- (void)reloadMoreData;
///请求数据
- (void)reloadDataWithMore:(BOOL)is_More;

@end
