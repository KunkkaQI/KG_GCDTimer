//
//  ViewController.m
//  KG_GCDTimerDemo
//
//  Created by KunkkaQi on 2017/4/29.
//  Copyright © 2017年 KG. All rights reserved.
//

#import "ViewController.h"
#import "KG_GCDTimer.h"
@interface ViewController ()

@end

static NSString *kgTimer = @"kgTimer";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[KG_GCDTimer sharedInstance] scheduledDispatchTimerWithName:kgTimer
                                                    timeInterval:3.0f
                                                           queue:nil
                                                         repeats:YES
                                                    actionOption:KG_AbandonPreviousAction /* KG_MergePreviousAction */
                                                          action:^{
                                                              
                                                              NSLog(@"333");
    
    }];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(12.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[KG_GCDTimer sharedInstance] cancelTimerWithName:kgTimer];
    });
    
}

@end
