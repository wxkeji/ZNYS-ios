//
//  BluetoothServer+TimeOutManager.h
//  ZNYS
//
//  Created by 张恒铭 on 4/22/17.
//  Copyright © 2017 Woodseen. All rights reserved.
//

#import "BluetoothServer.h"

#define TIME_OUT_INTERVAL 10

@interface BluetoothServer (TimeOutManager)

@property (nonatomic, assign) NSInteger currentCount;
@property (nonatomic, strong) NSTimer  *timer;


- (void)startTimer;
- (void)stopTimer;
- (void)resetTimer;
- (void)timesUp;

@end
