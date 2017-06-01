//
//  BluetoothMessageDispatcher.h
//  BLEConnectModule
//
//  Created by 张恒铭 on 5/12/17.
//  Copyright © 2017 张恒铭. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BluetoothServer.h"
#import "DataParser.h"
#import "SensorDataHandler.h"
@interface BluetoothMessageDispatcher : NSObject

- (void)dispatchMessageWithData:(NSData *)data type:(CharacteristicType)type;

@end
