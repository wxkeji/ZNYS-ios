//
//  BluetoothServer+TimeOutManager.m
//  ZNYS
//
//  Created by 张恒铭 on 4/22/17.
//  Copyright © 2017 Woodseen. All rights reserved.
//

#import "BluetoothServer+TimeOutManager.h"
#import <objc/runtime.h>
@implementation BluetoothServer (TimeOutManager)



- (void)startTimer {
    [self stopTimer];
    self.timer = [NSTimer timerWithTimeInterval:1.0f target:self selector:@selector(count) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)stopTimer {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    self.currentCount = 0;
}

- (void)resetTimer {
    self.currentCount = 0;
}

- (void)count {
    self.currentCount ++;
    NSLog(@"scaning....Current count is %i",self.currentCount);
    if (self.currentCount > TIME_OUT_INTERVAL) {
        if ([self respondsToSelector:@selector(timesUp)]) {
            [self timesUp];
            [self stopTimer];
        }
    }
}


#pragma mark - getter and setter
- (void)setCurrentCount:(NSInteger)currentCount {
    objc_setAssociatedObject(self, @selector(setCurrentCount:), @(currentCount), OBJC_ASSOCIATION_ASSIGN);
}

- (NSInteger)currentCount {
    return [objc_getAssociatedObject(self, @selector(setCurrentCount:)) integerValue];
}

- (NSTimer *)timer {
    return objc_getAssociatedObject(self, @selector(timer));
    
}

- (void)setTimer:(NSTimer *)timer {
    objc_setAssociatedObject(self, @selector(timer), timer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}




@end
