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

- (instancetype)initWithPeripheral:(CBPeripheral *)peripheral
                 advertisementData:(NSDictionary *)advertisementData
                              RSSI:(NSNumber *)RSSI;

@property (nonatomic, strong) CBPeripheral *peripheral;
@property (nonatomic, strong) NSDictionary *advertisementData;
@property (nonatomic, assign) NSInteger     RSSI;

/**
 广播包中的设备名
 */
@property (nonatomic, strong) NSString     *advertiseName;

@property (nonatomic, strong) NSString     *identifier;

@end
