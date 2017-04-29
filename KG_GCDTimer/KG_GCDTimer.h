//
//  KG_GCDTimer.h
//  V0.0.1
//
//  Created by KunkkaQi on 2017/4/29.
//  Copyright © 2017年 KG. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    KG_UnknownAction,
    KG_AbandonPreviousAction, // Abolish the previous task of the same timer
    KG_MergePreviousAction    // Merge the previous tasks of the same timer to the new task
} KG_ActionOption;

@interface KG_GCDTimer : NSObject

+ (KG_GCDTimer *)sharedInstance;

/**
 * start one timer，default accuracy 0.1s。
 *
 * @param timerName       name of timer，as unique identifier.
 * @param interval        Interval of execution
 * @param queue           the queue of timer, default or nil is "dispatch_get_global_queue".
 * @param repeats         repeat YES or NO, must set value
 * @param option          many schedule in the same timer optioner action, (now support merge previous action opertioner).
 * @param action          Interval of execution action call back block。
 */
- (void)scheduledDispatchTimerWithName:(NSString *)timerName
                          timeInterval:(double)interval
                                 queue:(dispatch_queue_t)queue
                               repeats:(BOOL)repeats
                          actionOption:(KG_ActionOption)option
                                action:(dispatch_block_t)action;

/**
 * cancel any timer。
 *
 * @param timerName       name of timer，as unique identifier.
 */
- (void)cancelTimerWithName:(NSString *)timerName;

/**
 * cancel all timer
 */
- (void)cancelAllTimer;
    
/**
 *  is exist timer,  as unique identifie by neme
 *
 *  @param timerName     name of timer，as unique identifier.
 *
 *  @return YES mean exist，or not。
 */
- (BOOL)existTimer:(NSString *)timerName;

@end
