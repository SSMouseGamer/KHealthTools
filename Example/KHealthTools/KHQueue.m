//
//  KHQueue.m
//  KHealthTools
//
//  Created by 李云新 on 2019/3/28.
//  Copyright © 2019年 lambert. All rights reserved.
//

#define QUEUE_INDEX @"queueIndex"

#import "KHQueue.h"

@implementation KHQueue

+ (void)tryCallMethodWithMethodString:(NSString *)methodStr CurrentObject:(id)obj {
    SEL sel = NSSelectorFromString(methodStr);
    IMP imp = [obj methodForSelector:sel];
    void (*func)(id,SEL) = (void *)imp;
    if ([obj respondsToSelector:sel]) {
        func(obj,sel);
    }
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self addObserver:self forKeyPath:QUEUE_INDEX options:(NSKeyValueObservingOptionNew) context:nil];
    }
    return self;
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:QUEUE_INDEX];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    NSInteger index = [change[@"new"] integerValue];
    if (index < self.queueArray.count) {
        NSLog(@"%ld",(long)index);
        [KHQueue tryCallMethodWithMethodString:self.queueArray[index][@"functionStr"] CurrentObject:self.queueArray[index][@"currentObject"]];
    }
}

@end
