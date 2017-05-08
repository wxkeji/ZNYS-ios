//
//  BluetoothServer+DataTransferTimer.m
//  BLEConnectModule
//
//  Created by 张恒铭 on 4/23/17.
//  Copyright © 2017 张恒铭. All rights reserved.
//

#import "BluetoothServer+DataTransferTimer.h"
#import <objc/runtime.h>
@implementation BluetoothServer (DataTransferTimer)

- (void)startDataTransferTimer {
    [self stopDataTransferTimer];
    self.dataTranferTimer = [NSTimer timerWithTimeInterval:1.0f target:self selector:@selector(dataTransCount) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.dataTranferTimer forMode:NSRunLoopCommonModes];
}

- (void)stopDataTransferTimer {
    if (self.dataTranferTimer) {
        [self.dataTranferTimer invalidate];
        self.dataTranferTimer = nil;
    }
    self.dataTrans_currentCount = 0;
}

- (void)resetTimer {
    self.dataTrans_currentCount = 0;
}

- (void)dataTransCount {
    self.dataTrans_currentCount ++;
    if (self.dataTrans_currentCount > DATA_TRANS_TIME_OUT) {
        if ([self respondsToSelector:@selector(dataTransEnd)]) {
            [self dataTranferEnd];
            [self stopDataTransferTimer];
        }
    }
}


#pragma mark - getter and setter
- (void)setDataTrans_currentCount:(NSInteger)dataTrans_currentCount {
    objc_setAssociatedObject(self, @selector(setDataTrans_currentCount:), @(dataTrans_currentCount), OBJC_ASSOCIATION_ASSIGN);
}

- (NSInteger)dataTrans_currentCount {
    return [objc_getAssociatedObject(self, @selector(setDataTrans_currentCount:)) integerValue];
}

- (NSTimer *)dataTranferTimer {
    return objc_getAssociatedObject(self, @selector(dataTranferTimer));
    
}

- (void)setDataTranferTimer:(NSTimer *)dataTranferTimer {
    objc_setAssociatedObject(self, @selector(dataTranferTimer), dataTranferTimer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end
