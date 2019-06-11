//
//  KHTimerManager.m
//  KHealthDoctor
//
//  Created by 李云新 on 2018/9/18.
//  Copyright © 2018年 lambert. All rights reserved.
//

#import "KHTimerManager.h"

@interface KHTimerManager()

@property (nonatomic, strong) NSMutableDictionary *timerContainer;
@property (nonatomic, strong) NSMutableDictionary *actionBlockCache;

@end

@implementation KHTimerManager

+ (KHTimerManager *)share{
    static KHTimerManager *_gcdTimerManager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken,^{
        _gcdTimerManager = [[self alloc] init];
    });
    
    return _gcdTimerManager;
}

- (void)countDownWithName:(NSString *)timerName
                     time:(NSInteger)time
                   action:(void (^)(NSInteger))action
                endAction:(void (^)(void))endAction {
    __block NSInteger timeD = time;
    
    [self scheduledDispatchTimerWithName:timerName timeInterval:1.0 precision:0.1 queue:dispatch_get_main_queue() repeats:YES action:^{
        if (timeD <= 0) {
            if (action){
                action(0);
            }
            
            [[KHTimerManager share] cancelTimerWithName:timerName];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (endAction){
                    endAction();
                }
            });
            
        } else {
            if (action){
                action(timeD);
            }
            
            timeD -= 1;
        }
    }];
}

- (void)scheduledDispatchTimerWithName:(NSString *)timerName
                          timeInterval:(double)interval
                             precision:(double)precision
                                 queue:(dispatch_queue_t)queue
                               repeats:(BOOL)repeats
                                action:(dispatch_block_t)action
{
    if (nil == timerName)
        return;
    
    if (0 == interval){
        interval = 1.0;
    }
    
    if (0 == precision){
        precision = 0.1;
    }
    
    if (nil == queue)
        queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t timer = [self.timerContainer objectForKey:timerName];
    if (!timer) {
        timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        dispatch_resume(timer);
        [self.timerContainer setObject:timer forKey:timerName];
    }
    
    /* timer精度为0.1秒 */
    dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, interval * NSEC_PER_SEC), interval * NSEC_PER_SEC, precision * NSEC_PER_SEC);
    
    __weak typeof(self) weakSelf = self;
    
    [weakSelf removeActionCacheForTimer:timerName];
    
    dispatch_source_set_event_handler(timer, ^{
        action();
        if (!repeats) {
            [weakSelf cancelTimerWithName:timerName];
        }
    });
}

- (void)cancelTimerWithName:(NSString *)timerName{
    dispatch_source_t timer = [self.timerContainer objectForKey:timerName];
    
    if (!timer) {
        return;
    }
    
    [self.timerContainer removeObjectForKey:timerName];
    dispatch_source_cancel(timer);
    
    [self.actionBlockCache removeObjectForKey:timerName];
}

- (void)cancelAllTimer{
    // Fast Enumeration
    [self.timerContainer enumerateKeysAndObjectsUsingBlock:^(NSString *timerName, dispatch_source_t timer, BOOL *stop) {
        [self.timerContainer removeObjectForKey:timerName];
        dispatch_source_cancel(timer);
    }];
}

#pragma mark - 删除倒计时
- (void)removeActionCacheForTimer:(NSString *)timerName{
    if (![self.actionBlockCache objectForKey:timerName])
        return;
    
    [self.actionBlockCache removeObjectForKey:timerName];
}

#pragma mark - 缓存倒计时
- (void)cacheAction:(dispatch_block_t)action forTimer:(NSString *)timerName{
    id actionArray = [self.actionBlockCache objectForKey:timerName];
    
    if (actionArray && [actionArray isKindOfClass:[NSMutableArray class]]) {
        [(NSMutableArray *)actionArray addObject:action];
    }else {
        NSMutableArray *array = [NSMutableArray arrayWithObject:action];
        [self.actionBlockCache setObject:array forKey:timerName];
    }
}

#pragma mark - lazy
- (NSMutableDictionary *)timerContainer{
    if (!_timerContainer) {
        _timerContainer = [[NSMutableDictionary alloc] init];
    }
    return _timerContainer;
}

- (NSMutableDictionary *)actionBlockCache{
    if (!_actionBlockCache) {
        _actionBlockCache = [[NSMutableDictionary alloc] init];
    }
    return _actionBlockCache;
}

@end
