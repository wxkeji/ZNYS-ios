//
//  DataParser.h
//  bluetoothUnitTest
//
//  Created by 张恒铭 on 15/7/31.
//  Copyright © 2015年 张恒铭. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccelerationPackage.h"
#import "QuaternionPackage.h"
@interface DataParser : NSObject
+(NSString*)parseRTC:(NSData*)data is32Bit:(BOOL)is32Bit;
+(int) parseBattery:(NSData*)data;
+(AccelerationPackage*) parseAcceleration:(NSData*)data;
+(QuaternionPackage*) parseQuaternion:(NSData*)data;
+(int)parseDataType:(NSData*)data;
@end
