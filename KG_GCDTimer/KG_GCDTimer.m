//
//  KG_GCDTimer.m
//
//
//  Created by KunkkaQi on 2017/4/29.
//  Copyright © 2017年 KG. All rights reserved.
//

#import "KG_GCDTimer.h"

@interface KG_GCDTimer ()

@property (nonatomic, strong) NSMutableDictionary *timerContainer;
@property (nonatomic, strong) NSMutableDictionary *actionBlockCache;

@end

@implementation KG_GCDTimer

- (NSMutableDictionary *)timerContainer
{
    if (!_timerContainer) {
        _timerContainer = [[NSMutableDictionary alloc] init];
    }
    return _timerContainer;
}

- (NSMutableDictionary *)actionBlockCache
{
    if (!_actionBlockCache) {
        _actionBlockCache = [[NSMutableDictionary alloc] init];
    }
    return _actionBlockCache;
}

+ (KG_GCDTimer *)sharedInstance
{
    static KG_GCDTimer *_gcdTimer = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        _gcdTimer = [KG_GCDTimer new];
    });
    
    return _gcdTimer;
}

- (void)scheduledDispatchTimerWithName:(NSString *)timerName
                          timeInterval:(double)interval
                                 queue:(dispatch_queue_t)queue
                               repeats:(BOOL)repeats
                          actionOption:(KG_ActionOption)option
                                action:(dispatch_block_t)action
{
    if (nil == timerName)
        return;
    
    if (nil == queue)
        queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t timer = [self.timerContainer objectForKey:timerName];
    if (!timer) {
        timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        dispatch_resume(timer);
        [self.timerContainer setObject:timer forKey:timerName];
    }
    
    // timer accuracy 0.1s
    dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, interval * NSEC_PER_SEC), interval * NSEC_PER_SEC, 0.1 * NSEC_PER_SEC);
    
    __weak typeof(self) weakSelf = self;

    switch (option) {
        case KG_AbandonPreviousAction:
        {
            // Abolish the previous action
            [weakSelf removeActionCacheForTimer:timerName];
            
            dispatch_source_set_event_handler(timer, ^{
                action();
                if (!repeats) {
                    [weakSelf cancelTimerWithName:timerName];
                }
            });
        }
            break;
        case KG_MergePreviousAction:
        {
            // cache action
            [self cacheAction:action forTimer:timerName];
            
            dispatch_source_set_event_handler(timer, ^{
                NSMutableArray *actionArray = [self.actionBlockCache objectForKey:timerName];
                [actionArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    dispatch_block_t actionBlock = obj;
                    actionBlock();
                }];
                [weakSelf removeActionCacheForTimer:timerName];
                
                if (!repeats) {
                    [weakSelf cancelTimerWithName:timerName];
                }
            });
        }
            break;
            
        default:
            break;
    }
}

- (void)cancelTimerWithName:(NSString *)timerName
{
    dispatch_source_t timer = [self.timerContainer objectForKey:timerName];
    
    if (!timer) {
        return;
    }
    
    [self.timerContainer removeObjectForKey:timerName];
    dispatch_source_cancel(timer);
    
    [self.actionBlockCache removeObjectForKey:timerName];
}

- (void)cancelAllTimer
{
    [self.timerContainer enumerateKeysAndObjectsUsingBlock:^(NSString *timerName, dispatch_source_t timer, BOOL *stop) {
        [self.timerContainer removeObjectForKey:timerName];
        dispatch_source_cancel(timer);
    }];
        
    [self.actionBlockCache removeAllObjects];
}
    
- (BOOL)existTimer:(NSString *)timerName
{
    if ([self.timerContainer objectForKey:timerName]) {
        return YES;
    }
    return NO;
}

#pragma mark - Action Cache
- (void)cacheAction:(dispatch_block_t)action forTimer:(NSString *)timerName
{
    id actionArray = [self.actionBlockCache objectForKey:timerName];
    
    if (actionArray && [actionArray isKindOfClass:[NSMutableArray class]]) {
        [(NSMutableArray *)actionArray addObject:action];
    }else {
        NSMutableArray *array = [NSMutableArray arrayWithObject:action];
        [self.actionBlockCache setObject:array forKey:timerName];
    }
}

- (void)removeActionCacheForTimer:(NSString *)timerName
{
    if (![self.actionBlockCache objectForKey:timerName])
        return;
    
    [self.actionBlockCache removeObjectForKey:timerName];
}

@end
