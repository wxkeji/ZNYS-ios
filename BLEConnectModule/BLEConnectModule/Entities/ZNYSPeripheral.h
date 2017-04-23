//
//  ZNYSPeripheral.h
//  BLEConnectModule
//
//  Created by 张恒铭 on 4/22/17.
//  Copyright © 2017 张恒铭. All rights reserved.
//

#import <Foundation/Foundation.h>
#import<CoreBluetooth/CoreBluetooth.h>

@interface ZNYSPeripheral : NSObject
@property (nonatomic, strong) CBPeripheral *peripheral;
@property (nonatomic, strong) NSDictionary *advertisementData;
@property (nonatomic, assign) NSInteger     RSSI;

@end
