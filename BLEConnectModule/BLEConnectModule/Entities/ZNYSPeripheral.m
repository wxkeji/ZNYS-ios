//
//  ZNYSPeripheral.m
//  BLEConnectModule
//
//  Created by 张恒铭 on 4/22/17.
//  Copyright © 2017 张恒铭. All rights reserved.
//

#import "ZNYSPeripheral.h"

@implementation ZNYSPeripheral

- (instancetype)initWithPeripheral:(CBPeripheral *)peripheral
                 advertisementData:(NSDictionary *)advertisementData
                              RSSI:(NSNumber *)RSSI {
    self = [super init];
    self.peripheral = peripheral;
    if ([advertisementData objectForKey:@"kCBAdvDataLocalName"]) {
        self.advertiseName = [advertisementData objectForKey:@"kCBAdvDataLocalName"];
    }
    self.advertisementData = advertisementData;
    self.RSSI = [RSSI integerValue];
    return self;
}

@end
