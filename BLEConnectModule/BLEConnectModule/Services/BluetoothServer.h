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
#import "ZNYSPeripheral.h"
@import CoreBluetooth;
@import QuartzCore;


#define SAVE_DATA_TO_DATABASE 1

typedef void (^ScanCompletionBlock)(NSArray<CBPeripheral*> *peripherals);
typedef void (^ConnectCompletionBlock)(BOOL result, NSString *infomation);

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
@optional
-(void)findNewToothBrushDevice:(CBPeripheral*)peripheral advertisementdata:(NSDictionary*)data RSSI:(NSNumber*)rssi;

- (void)didConnectToothBrush:(CBPeripheral*)toothBrush;

- (void)dataTransferFinished;

- (void)connectedResult:(BOOL) isConnected;

- (void)dataTransferStatusUpdated:(BLSDataType)dataType packageReceived:(NSUInteger)num;
- (void)onAccelerationUpdated:(AccelerationPackage *)acceleration;

- (void)onQuatarnionUpdated:(QuaternionPackage *)quatarnion;

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



/**
 直接扫描附近蓝牙硬件名字为Mita Brush的并连接
 */
-(void)scan;

/**
 扫描附近的蓝牙硬件，并在回调block中获取结果
 
 @param completion 回调Block
 */
- (void)scanWithCompletionBlock:(ScanCompletionBlock)completion;



/**
 直接连接相应的Peripheral

 @param peripheral periphearl
 */
-(BOOL)connect:(CBPeripheral*)peripheral;

/**
 连接相应的Peripheral，并且在回调Block中传入连接结果

 @param completion block
 */
-(void)connectDeviceWithFinishBlock:(ConnectCompletionBlock)completion;/*WithCompletionBlock:(void(^)(void))completion failedBlock:(void(^)(void))fail*/;


/**
 停止搜索周围的硬件
 */
-(void)stopScan;


- (void)startReceiveDataWithType:(NSUInteger)dataType;
- (BOOL)allDataIsReceived;
#pragma mark - Encapsulated APIs,通过这些API可以控制牙刷


- (NSData*)getBrushUUID;
- (void)setTargetTime:(NSString*)time;//设置刷牙目标时间
- (void)light;//亮灯
- (void)turnOffLight;//关闭LED灯
- (void)buzzer;//蜂鸣
- (void)shutDown;//停止蜂鸣
- (void)readRTC;//读取RTC（读取/写入值的回调方法为 .m里的 -(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error，下同
- (void)correctRTC:(NSString*)string;//写入校准的RTC
- (void)readBattery;//读取电量值
- (void)readPressure;//读取压力值
- (void)setBrushingAndAlarmBarrier:(NSString*)barrier;//设置检测刷牙的压力门槛
- (void)turnOnOnlineDataNotify;//接收硬件的实时数据，以下同理
- (void)TurnOffOnlineDataNotify;
- (void)turnOnOfflineDataNotify;
- (void)turnOffOfflineDataNotify;
- (void)readHardwareVersion;//读取硬件版本号
@end
