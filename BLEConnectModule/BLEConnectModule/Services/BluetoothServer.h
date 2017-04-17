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
#import "SensorDataHandler.h"
#import "AnalysisResultSet.h"
@import CoreBluetooth;
@import QuartzCore;


typedef NS_ENUM(NSUInteger,BLSDataType)
{
    BLS_ONLINE_DATA,
    BLS_OFFLINE_DATA
};

typedef NS_ENUM(NSUInteger,DataType) {
    DATA_TYPE_ACCELERATION,//加速度
    DATA_TYPE_QUATARNION//四元数
};

@protocol BluetoothServerProtocol <NSObject>

-(void)findNewToothBrushDevice:(CBPeripheral*)peripheral advertisementdata:(NSDictionary*)data RSSI:(NSNumber*)rssi;

- (void)didConnectToothBrush:(CBPeripheral*)toothBrush;

- (void)dataTransferFinished;

- (void)connectedResult:(BOOL) isConnected;

- (void)dataTransferStatusUpdated:(BLSDataType)dataType packageReceived:(NSUInteger)num;

@end






@interface BluetoothServer : NSObject<CBCentralManagerDelegate,CBPeripheralDelegate>

#pragma mark - property

@property(nonatomic) BOOL connected;//A flag that indicates whether the peripheral is connected.YES means connected, No means disconnected
@property(nonatomic,strong) NSMutableArray* sensorDataHandlersArray;
@property(nonatomic,weak) id<BluetoothServerProtocol> delegate;
//@property(nonatomic,copy) AnalysisResultSet*(^dataTransferFinishBlock)();//数据传输完成时会调用该block

#pragma mark - Initialization method
+(BluetoothServer*) defaultServer;


#pragma mark - APIs
-(void)scan;//开启蓝牙的状态下，扫描并自动连接到硬件（一般用时不超过五秒），连接后self.connected将变成YES
-(void)connectDeviceWithFinishBlock:(void(^)(BOOL isConnected))completion;/*WithCompletionBlock:(void(^)(void))completion failedBlock:(void(^)(void))fail*/;
-(void)stopScan;
- (void)startReceiveDataWithType:(NSUInteger)dataType;
-(BOOL)allDataIsReceived;
#pragma mark - Encapsulated APIs,通过这些API可以控制牙刷


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
