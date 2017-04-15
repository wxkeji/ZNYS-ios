//
//  BluetoothServer.h
//  ZNYS
//
//  Created by 张恒铭 on 15/7/30.
//  Copyright © 2015年 张恒铭. All rights reserved.
//
//
//
//This class is singleton class, aims to encapsulate bluetooth operation and provide essential interface.



#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "DataParser.h"
@import CoreBluetooth;
@import QuartzCore;
@interface BluetoothServer : NSObject<CBCentralManagerDelegate,CBPeripheralDelegate>

typedef void (^ScanCompletionBlock)(BOOL isConnected);


#pragma mark - property
@property(nonatomic) BOOL connected;//A flag that indicates whether the peripheral is connected.YES means connected, No means disconnected

@property(nonatomic, assign) CBManagerState bluetoothState;

#pragma mark - Initialization method
+ (BluetoothServer*) defaultServer;
#pragma mark - APIs
- (void)scan;//开启蓝牙的状态下，扫描并自动连接到硬件（一般用时不超过五秒），连接后self.connected将变成YES
- (void)connectWithCompletionBlock:(ScanCompletionBlock)completionBlock;
- (void)stopScan;

#pragma mark - Encapsulated APIs
-(NSData*)getBrushUUID;
-(void)setTargetTime:(NSString*)time;//设置刷牙目标时间
-(void)light;//亮灯
-(void)turnOffLight;//关闭LED灯
-(void)buzzer;//蜂鸣
-(void)shutDown;//停止蜂鸣
-(void)readRTC;//读取RTC（读取/写入值的回调方法为 .m里的 -(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error，下同
-(void)correctRTC:(NSString*)string;//写入校准的RTC
-(void)readBattery;//读取电量值
-(void)readPressure;//读取压力值
-(void)setBrushingAndAlarmBarrier:(NSString*)barrier;//设置检测刷牙的压力门槛
-(void)turnOnOnlineDataNotify;//接收硬件的实时数据，以下同理
-(void)TurnOffOnlineDataNotify;
-(void)turnOnOfflineDataNotify;
-(void)turnOffOfflineDataNotify;
-(void)readHardwareVersion;//读取硬件版本号
@end
