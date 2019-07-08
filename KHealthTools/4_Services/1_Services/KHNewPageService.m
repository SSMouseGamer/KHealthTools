//
//  KHNewPageService.m
//  KHealthTools
//
//  Created by kim on 2019/6/17.
//  Copyright © 2019年 lambert. All rights reserved.
//

#import "KHNewPageService.h"
#import "KHealthToolsHeader.h"
#import "KHServices.h"

@interface KHNewPageService ()

///Task
@property (nonatomic, strong) KHServicesTask *task;

///回调
@property (nonatomic,   copy) KHServicePageOption cBlock;

///页码
@property (nonatomic, assign) NSInteger pageNo;
///最大页数，默认65535页
@property (nonatomic, assign) NSInteger totalPage;

///是否请求更多数据
@property (nonatomic, assign) BOOL isMore;

@end

@implementation KHNewPageService

- (instancetype)initWithTask:(KHServicesTask *)task CompleBlock:(KHServicePageOption)cBlock {
    self = [super init];
    if(self) {
        self.task   = task;
        self.cBlock = cBlock;
        
        self.pageNo    = 1;
        self.pageSize  = 20;
        self.totalPage = 65535;
        self.isMore    = NO;
        
        self.pageNoKey = @"pageNo";
        self.pageSizeKey = @"pageSize";
        self.totalPageKey = @"pages";
    }
    return self;
}

///设置网络访问参数
- (void)setParam:(NSDictionary *)parma {
    self.task.param = parma;
}

- (void)reloadData {
    [self reloadDataWithMore:NO];
}

- (void)reloadMoreData {
    [self reloadDataWithMore:YES];
}

///请求数据
- (void)reloadDataWithMore:(BOOL)is_More {
    self.isMore = is_More;
    
    //1.判断是否越界
    if (self.isMore && self.pageNo > self.totalPage) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if(self.cBlock) {
                self.cBlock(@[], self.isMore, YES, 2333, @"没有更多啦");
            }
        });
        return;
    }
    
    //2.处理入参
    if (!self.isMore) {
        self.pageNo = 1;
        self.totalPage = 65535;
    }
    ///2.1 处理不同请求方式的页数、页面size的拼接方式，根据业务去定
    if ([self.task.method isEqualToString:@"POST"]) { ///这里是因为post的分页数据，需要把页数、页面数据大小放在请求链接后面
        NSString *path = [NSString kh_str:self.task.path Normal:@"233"];
        self.task.path = [path stringByAppendingFormat:@"?%@=%ld&%@=%ld",self.pageNoKey, self.pageNo, self.pageSizeKey, self.pageSize];
    } else { ///通用的get方法
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        [param setValue:@(self.pageNo) forKey:self.pageNoKey];
        [param setValue:@(self.pageSize) forKey:self.pageSizeKey];
        [self.task setParam:param];
    }

    //3.fire
    KHWeakObj(self);
    [[KHServices share] requestWithTask:self.task DictComplete:^(NSDictionary *jDict, BOOL success, NSInteger code, NSString *msg) {
        
        id totalPage = jDict[weakSelf.totalPageKey];
        if (totalPage) {
            //正常操作
            weakSelf.totalPage = [totalPage integerValue];
        } else {
            //骚操作
            NSInteger count = [jDict[@"count"] integerValue];
            weakSelf.totalPage = count / weakSelf.pageSize + (count % weakSelf.pageSize == 0 ? 0 : 1);
        }
        
        if (success) {
            weakSelf.pageNo += 1;
        }
        
        if (weakSelf.cBlock) {
            if (weakSelf.isMore) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    weakSelf.cBlock(jDict[@"list"], weakSelf.isMore, success, code, msg);
                });
            } else {
                weakSelf.cBlock(jDict[@"list"], weakSelf.isMore, success, code, msg);
            }
        }
    }];
}

- (void)dealloc {
    KHLog(@"dealloc - %@ - %@", [self class], self.task.path);
}

@end
