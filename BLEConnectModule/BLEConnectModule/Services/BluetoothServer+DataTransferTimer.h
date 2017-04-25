//
//  BluetoothServer+DataTransferTimer.h
//  BLEConnectModule
//
//  Created by 张恒铭 on 4/23/17.
//  Copyright © 2017 张恒铭. All rights reserved.
//

#import "BluetoothServer.h"


#define DATA_TRANS_TIME_OUT 5

@interface BluetoothServer (DataTransferTimer)

@property (nonatomic, assign) NSInteger dataTrans_currentCount;
@property (nonatomic, strong) NSTimer  *dataTranferTimer;


- (void)startDataTransferTimer;
- (void)stopDataTransferTimer;
- (void)resetDataTransferTimer;

//倒计时回调结束，原有类中实现
- (void)dataTranferEnd;

@end
