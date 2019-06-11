//
//  KHQueue.h
//  KHealthTools
//
//  Created by 李云新 on 2019/3/28.
//  Copyright © 2019年 lambert. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KHQueue : NSObject
///执行的顺序下标
@property (nonatomic, assign) NSInteger queueIndex;
///执行的方法对象列表
@property (nonatomic, strong) NSArray<NSDictionary *> *queueArray;

/**
 尝试唤起方法 并实现

 @param methodStr 方法字符串
 @param obj 持有方法的对象，对象必须是存在的
 */
+ (void)tryCallMethodWithMethodString:(NSString *)methodStr CurrentObject:(id)obj;

@end
