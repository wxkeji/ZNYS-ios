//
//  BluetoothServer.m
//  ZNYS
//
//  Created by 张恒铭 on 15/7/30.
//  Copyright © 2015年 张恒铭. All rights reserved.
//
#import "BluetoothServer.h"
#import "SensorData.h"
#import "DataParser.h"
#import "ZNYSPeripheral.h"
#import "BluetoothServer+TimeOutManager.h"

#define TARGET_TIME 0
#define RTC 1
#define BATTERY 2
#define PRESSURE 3
#define BUZZER 4
#define ONLINE_DATA 5
#define OFFLINE_DATA 6
#define VERSION 7
#define SMILE_LIGHT 8

#define BRUSHING_TIME_INTERVAL_THERESHOLD 6000000//单位ms

#define ON 0x01
#define OFF 0x00


long lastTimeStamp = 0;

//Class extration of NSString, adding the function to NSString so that it can be converted to bytes(NSData)


@interface NSString (NSStringHexToBytes)
-(NSData*) hexToBytes ;
@end



@implementation NSString (NSStringHexToBytes)
-(NSData*) hexToBytes
{
    NSMutableData* data = [NSMutableData data];
    int idx;
    for (idx = 0; idx+2 <= self.length; idx+=2) {
        NSRange range = NSMakeRange(idx, 2);
        NSString* hexStr = [self substringWithRange:range];
        NSScanner* scanner = [NSScanner scannerWithString:hexStr];
        unsigned int intValue;
        [scanner scanHexInt:&intValue];
        [data appendBytes:&intValue length:1];
    }
    return data;
}

-(NSString*)binaryString:(NSString*)str
{
    NSMutableString *binStr = [[NSMutableString alloc] init];
    for(NSUInteger i=0; i<[str length]; i++)
    {
        [binStr appendString:[self hexToBinary:[str characterAtIndex:i]]];
    }
    return binStr;
}
- (NSString *) hexToBinary:(unichar)myChar
{
    switch(myChar)
    {
        case '0': return @"0000";
        case '1': return @"0001";
        case '2': return @"0010";
        case '3': return @"0011";
        case '4': return @"0100";
        case '5': return @"0101";
        case '6': return @"0110";
        case '7': return @"0111";
        case '8': return @"1000";
        case '9': return @"1001";
        case 'a':
        case 'A': return @"1010";
        case 'b':
        case 'B': return @"1011";
        case 'c':
        case 'C': return @"1100";
        case 'd':
        case 'D': return @"1101";
        case 'e':
        case 'E': return @"1110";
        case 'f':
        case 'F': return @"1111";
    }
    return @""; //means something went wrong, shouldn't reach here!
}
@end

@interface BluetoothServer(){
    NSUInteger numberOfQuaternionReceived;
    NSUInteger numberOfAcceeleraionReceived;
    NSUInteger heartbeat;
    BOOL shouldCreateTimer;
}

@property(nonatomic,strong) CBCentralManager*  centralManager;//central
@property(nonatomic,strong) CBPeripheral*      peripheral;//peripheral
@property(nonatomic,strong) NSArray*           characteristicArray;//An array storing characteristics( the 9 characteristics in ZNYS particularlly)
@property(nonatomic,strong) NSString*          data;//To retrive data from sensor
@property(nonatomic,strong) NSDictionary*      dictionary;//存放特征值和对应UUID的字典
@property(nonatomic,strong) NSData*            brushUUID;
@property(nonatomic,strong) SensorDataHandler* currentHandler;

@property(nonatomic,strong) NSTimer*          timerForScanning;
@property(nonatomic,strong) NSTimer*          timerForEnding;

@property (nonatomic, strong)NSMutableArray<ZNYSPeripheral*> *periphearlsArray;
@property (nonatomic, copy)ScanCompletionBlock scanCompletionBlock;
@property (nonatomic, copy)ConnectCompletionBlock connectCompletionBlock;

-(instancetype)initPrivate;
-(void)disconnect;
-(void)notify:(CBCharacteristic*)characteristic;
-(BOOL)writeValue:(NSString*)value into:(CBCharacteristic*)characteristic;
-(BOOL)readValueFrom:(CBCharacteristic*)characteristic;
-(BOOL)readNotifyValues:(CBCharacteristic*)characteristic;






@end


@implementation BluetoothServer
#pragma mark - Initialization method
+(BluetoothServer*) defaultServer
{
    static BluetoothServer* _defaultServer;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(!_defaultServer)
        {
            _defaultServer = [[BluetoothServer alloc] initPrivate];
        }
    });
    return _defaultServer;
    
}
-(instancetype)initPrivate
{
    self = [super init];
    if(self)
    {
        self.timerForScanning = [NSTimer timerWithTimeInterval:5.5 target:self selector:@selector(connectDevice) userInfo:nil repeats:3];
        
        self.centralManager = [[CBCentralManager alloc]initWithDelegate:self queue:nil options:nil];
        self.centralManager.delegate = self;
        //    connectedFlag = false;
        self.peripheral = nil;
        self.sensorDataHandlersArray = [[NSMutableArray alloc] init];
        self.currentHandler = [[SensorDataHandler alloc] init];
        [self.sensorDataHandlersArray addObject:_currentHandler];
        self.connected = NO;
        _dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"characteristic1",
                       [CBUUID UUIDWithString:@"6E400201-B5A3-F393-E0A9-E50E24DCCA9E"].data,
                       @"characteristic2",
                       [CBUUID UUIDWithString:@"6E400202-B5A3-F393-E0A9-E50E24DCCA9E"].data,
                       @"characteristic3",
                       [CBUUID UUIDWithString:@"6E400203-B5A3-F393-E0A9-E50E24DCCA9E"].data,
                       @"characteristic4",
                       [CBUUID UUIDWithString:@"6E400204-B5A3-F393-E0A9-E50E24DCCA9E"].data,
                       @"characteristic5",
                       [CBUUID UUIDWithString:@"6E400205-B5A3-F393-E0A9-E50E24DCCA9E"].data,
                       @"characteristic6",
                       [CBUUID UUIDWithString:@"6E400206-B5A3-F393-E0A9-E50E24DCCA9E"].data,
                       @"characteristic7",
                       [CBUUID UUIDWithString:@"6E400207-B5A3-F393-E0A9-E50E24DCCA9E"].data,
                       @"characteristic8",
                       [CBUUID UUIDWithString:@"6E400208-B5A3-F393-E0A9-E50E24DCCA9E"].data,
                       @"characteristic9",
                       [CBUUID UUIDWithString:@"6E400209-B5A3-F393-E0A9-E50E24DCCA9E"].data, nil];
    }
    
    _timerForEnding = [NSTimer timerWithTimeInterval:3 target:self selector:@selector(checkDataTransferFinished) userInfo:nil repeats:YES];
    shouldCreateTimer = YES;
    numberOfQuaternionReceived = 0;
    numberOfAcceeleraionReceived = 0;
    
    self.periphearlsArray = [NSMutableArray array];
    
    return self;
}
-(instancetype)init
{
    @throw [NSException exceptionWithName:@"Singleton"
                                   reason:@"Use [BluetoothServer defaultServer]" userInfo:nil];
    return nil;
}
#pragma mark - APIs

-(void)scan
{
    [self.centralManager scanForPeripheralsWithServices:nil options:nil];
}

- (void)scanWithCompletionBlock:(ScanCompletionBlock)completion {
    [self.periphearlsArray removeAllObjects];
    self.scanCompletionBlock = completion;
    [self startTimer];
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self scan];
    });
}

-(void)connectDevice//WithCompletionBlock:(void(^)(void))completion failedBlock:(void(^)(void))fail
{
    if (self.connected)
    {
        [self.timerForScanning invalidate];
        self.timerForScanning = nil;
        //  completion();
    }
    else
    {
        //  fail();
        //  [self scan];
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [[NSRunLoop currentRunLoop] addTimer:self.timerForScanning forMode:NSRunLoopCommonModes];
            [self.timerForScanning fire];
        });
    }
}

-(void)connectDeviceWithFinishBlock:(void(^)(BOOL isConnected))completion
{
    [self scan];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.connected)
        {
            completion(YES);
        }
        else
        {
            completion(NO);
        }
    });
}
-(void)stopScan
{
    [self.centralManager stopScan];
}
-(BOOL)connect:(CBPeripheral*)peripheral
{
    if (!peripheral)  {
        return NO;
    }
    
    [self.centralManager connectPeripheral:peripheral options:nil];
    return YES;
}
-(void)disconnect
{
    [self.centralManager cancelPeripheralConnection:self.peripheral];
}
-(void)notify:(CBCharacteristic*)characteristic;
{
    [self.peripheral setNotifyValue:YES forCharacteristic:characteristic];
}
-(BOOL)writeValue:(NSString*)value into:(CBCharacteristic*)characteristic
{
    //注意对应的Characteristic中的内容是多少位，写入的NSString中要对应这么多位
    //Place holder. Implement convert NSString into byte and write that into characteristic
    //attention:Before writting, check whether characteristic is null
    if(!self.peripheral )
    {
        @throw [NSException exceptionWithName:@"Peripheral is not connected yet" reason:@"self.Peripheral is nil" userInfo:nil];
        return false;
    }
    NSData *bytes = [value hexToBytes];
    NSLog(@"%@",bytes);
    
    [self.peripheral writeValue:bytes forCharacteristic:characteristic type:CBCharacteristicWriteWithResponse];
    return true;
}
-(BOOL)readValueFrom:(CBCharacteristic*)characteristic
{
    //Place holder. Implement the function that reads value from characteristic
    //attention:Check whether characteristic is null first
    if(!characteristic)
    {
        NSLog(@"Character do not exist, it should be initilizaed first");
        return false;
    }
    [self.peripheral readValueForCharacteristic:characteristic];
    return true;
}


-(BOOL)readNotifyValues:(CBCharacteristic*)characteristic;
{
    [self.peripheral setNotifyValue:YES forCharacteristic:characteristic];
    return true;
}

#pragma mark - private methods
- (void)checkDataTransferFinished
{
    //按照一秒8个数据包来算的话，三秒检查一次，这三秒理论上会传24个加速度的包
    heartbeat -= 24;
    
    if(heartbeat <= 0)
    {
        [_timerForEnding invalidate];
        _timerForEnding = nil;
    }
}

#pragma mark - Encapsulated APIs
-(NSData*)getBrushUUID;
{ 
    return self.brushUUID;
}
-(void)setTargetTime:(NSString *)time
{
    [self writeValue:time  into:_characteristicArray[TARGET_TIME]];
}
-(void)light
{
    [self writeValue:@"01" into:_characteristicArray[SMILE_LIGHT]];
}
-(void)turnOffLight
{
    [self writeValue:@"00" into:_characteristicArray[SMILE_LIGHT]];
}
-(void)buzzer
{
    [self writeValue:@"01" into:_characteristicArray[BUZZER]];
}
-(void)shutDown
{
    [self writeValue:@"00" into:_characteristicArray[BUZZER]];
}
-(void)readRTC
{
    [self readValueFrom:_characteristicArray[RTC]];
}
-(void)correctRTC:(NSString*)string
{
    [self writeValue:string into:_characteristicArray[RTC]];
}
-(void)readBattery
{
    if(!_characteristicArray)
    {
        NSLog(@"Initialize the characteristic array first");
        return ;
    }
    
    [self readValueFrom:_characteristicArray[BATTERY]];
}
-(void)setBrushingAndAlarmBarrier:(NSString*)barrier
{
    if(!_characteristicArray)
    {
        NSLog(@"Initialize the characteristic array first");
        return ;
    }
    
    [self writeValue:barrier into:_characteristicArray[PRESSURE]];
}
-(void)readPressure
{
    if(!_characteristicArray)
    {
        NSLog(@"Initialize the characteristic array first");
        return ;
    }
    [self readValueFrom:_characteristicArray[PRESSURE]];
}
-(void)turnOnOnlineDataNotify
{
    if(!_characteristicArray)
    {
        NSLog(@"Initialize the characteristic array first");
        return ;
    }
    [self.peripheral setNotifyValue:YES forCharacteristic:_characteristicArray[ONLINE_DATA]];
    NSLog(@"Class BluetoothServer:Online Data Notify is On");
}
-(void)TurnOffOnlineDataNotify
{
    if(!_characteristicArray)
    {
        NSLog(@"Initialize the characteristic array first");
        return ;
    }
    [self.peripheral setNotifyValue:NO forCharacteristic:_characteristicArray[ONLINE_DATA]];
}
-(void)turnOnOfflineDataNotify
{
    if(!_characteristicArray)
    {
        NSLog(@"Initialize the characteristic array first");
        return ;
    }
    [self readNotifyValues:_characteristicArray[OFFLINE_DATA]];
}
-(void)turnOffOfflineDataNotify
{
    if(!_characteristicArray)
    {
        NSLog(@"Initialize the characteristic array first");
        return ;
    }
    [self.peripheral setNotifyValue:NO forCharacteristic:_characteristicArray[OFFLINE_DATA]];
}
-(void)readHardwareVersion
{
    if(!_characteristicArray)
    {
        NSLog(@"Please Initialize the characteristic array first");
        return ;
    }
    [self readValueFrom:_characteristicArray[VERSION]];
}

#pragma  mark - scan related
- (void)timesUp {
    if (self.scanCompletionBlock) {
        dispatch_async(dispatch_get_main_queue(), ^{
           self.scanCompletionBlock(self.periphearlsArray);
        });
    }
}

#pragma mark - CBCentralManager delegate
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    NSLog(@"Did discover peripheral  %@",peripheral.name);
    NSLog(@"The averstisement data is %@",advertisementData);
    //此处要根据广播包数据来判断，根据periphral.name获取到的极有可能不准确
    
    ZNYSPeripheral *temp = [[ZNYSPeripheral alloc] initWithPeripheral:peripheral advertisementData:advertisementData RSSI:RSSI];
    [self.periphearlsArray addObject:temp];
//    if([[advertisementData objectForKey:@"kCBAdvDataLocalName"] isEqual:@"Mita Brush"])
//    {
//        self.peripheral = peripheral;
//        self.brushUUID = [CBUUID UUIDWithNSUUID:peripheral.identifier].data;
//        [self.centralManager connectPeripheral:peripheral options:nil];
//        if (self.delegate && [self.delegate respondsToSelector:@selector(findNewToothBrushDevice:advertisementdata:RSSI:)] ) {
//            [self.delegate findNewToothBrushDevice:peripheral advertisementdata:advertisementData RSSI:RSSI
//             ];
//        }
//    }
    
}
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    NSLog(@"Did connect peripheral %@",peripheral.name);
    [peripheral discoverServices:nil];
    peripheral.delegate = self;
    self.connected = YES;
    if (self.delegate && [self.delegate respondsToSelector:@selector(didConnectToothBrush:)]) {
        [self.delegate didConnectToothBrush:peripheral];
    }
    [self stopScan];
}
-(void)centralManager:( CBCentralManager *)central didFailedToConnectPeripheral:( CBPeripheral *)peripheral
{
    NSLog(@"Fail to connect peripheral %@",peripheral.name);
    self.connected = NO;
}
- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    
    if ([central state] == CBManagerStatePoweredOff) {
        NSLog(@"CoreBluetooth BLE hardware is powered off");
    }
    else if ([central state] ==  CBManagerStatePoweredOn) {
        NSLog(@"CoreBluetooth BLE hardware is powered on and ready");
    }
    else if ([central state] == CBManagerStateUnauthorized) {
        NSLog(@"CoreBluetooth BLE state is unauthorized");
    }
    else if ([central state] ==  CBManagerStateUnknown) {
        NSLog(@"CoreBluetooth BLE state is unknown");
    }
    else if ([central state] ==  CBManagerStateUnsupported) {
        NSLog(@"CoreBluetooth BLE hardware is unsupported on this platform");
    }
    [self.delegate connectedResult:self.connected];
}


#pragma mark - CBPeriphral delegate
- (void)peripheral:(CBPeripheral *)peripheral
didDiscoverServices:(NSError *)error
{
    for (CBService* service in peripheral.services)
    {
        NSLog(@"Did discover service,name %@",service.UUID);
        if([service.UUID isEqual:[CBUUID UUIDWithString:@"6E400200-B5A3-F393-E0A9-E50E24DCCA9E"]])
            [peripheral discoverCharacteristics:nil forService:service];
    }
}
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    for(CBCharacteristic* characteristic in service.characteristics)
    {
        NSLog(@"Did discover characteristics %@",characteristic);
    }
    self.characteristicArray = service.characteristics;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didFullyConnectToothBrush" object:nil];
}
-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    if (shouldCreateTimer) {
        [[NSRunLoop currentRunLoop] addTimer:_timerForEnding forMode:NSRunLoopCommonModes];
        [_timerForEnding fire];
    }
    heartbeat ++;
    NSString *temp = characteristic.value.description;
    NSLog(@"The value of temp is %@",temp);
    if ([[self.dictionary objectForKey:characteristic.UUID.data] isEqualToString:@"characteristic2"])
    {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"updateRTC" object:[DataParser parseRTC:characteristic.value is32Bit:YES]];
    }
    else if([[self.dictionary objectForKey:characteristic.UUID.data] isEqualToString:@"characteristic3"])
    {
        NSString* stringToDisplay = [NSString stringWithFormat:@"%d%@",[DataParser parseBattery:characteristic.value],@"%"];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"updateBattery" object:stringToDisplay];
    }
    
    
    
    //更新了实时数据
    else if([[self.dictionary objectForKey:characteristic.UUID.data] isEqualToString:@"characteristic6"])
    {
        NSLog(@"实时数据");
        //
        long currentTimeStamp = [[DataParser parseRTC:characteristic.value is32Bit:NO] longLongValue];
        if ((currentTimeStamp - lastTimeStamp > 60000) && lastTimeStamp!=0)//间隔大于十分钟
        {
            _currentHandler = [[SensorDataHandler alloc] init];
            [_sensorDataHandlersArray addObject:_currentHandler];
        }
        //判断数据，调用sensorDataHandler进行处理
        if([DataParser parseDataType:characteristic.value])//四元数
        {
            numberOfQuaternionReceived++;
            NSString* string=[NSString stringWithFormat:@"%@%d%@",
                              @"Receieved ",numberOfQuaternionReceived,@" quaternions" ];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"updateQuaternion" object:string];
            NSArray*  attitudeAngle = [_currentHandler pushQuaternion:[DataParser parseQuaternion:characteristic.value]];
            NSString* quaternionDetails = [NSString stringWithFormat:@"yaw:%@\r\npitch:%@\r\nroll:%@\r\n",attitudeAngle[0],attitudeAngle[1],attitudeAngle[2]];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"updateOnlineQuaternion" object:quaternionDetails];
        }
        else//加速度
        {
            numberOfAcceeleraionReceived++;
            NSString* string = [NSString stringWithFormat:@"%@%@%@",
                                @"Receieved ",[NSString stringWithFormat:@"%d",numberOfAcceeleraionReceived],@" Acceleration"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"updateAcceleration" object:string];
            NSMutableString* accelerationDetails = [[NSMutableString alloc] init];
            AccelerationPackage* acceleration = [DataParser parseAcceleration:characteristic.value];
            for (int i = 0; i < 3; i++)
            {
                [accelerationDetails appendString:[NSString stringWithFormat:@"X%i:%@  Y%i:%@  Z%i:%@ \r\n",i,acceleration.data[i][0],i,acceleration.data[i][1],i,acceleration.data[i][2]]];
            }
            [accelerationDetails appendString:[NSString stringWithFormat:@"Pressure:%f",acceleration.pressure]];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"updateOnlineAcceleration" object:accelerationDetails];
        }
        
        lastTimeStamp = currentTimeStamp;
    }
    
    
    
    //更新了离线数据
    else if([[self.dictionary objectForKey:characteristic.UUID.data] isEqualToString:@"characteristic7"])
    {
        NSLog(@"离线数据");
        long currentTimeStamp = [[DataParser parseRTC:characteristic.value is32Bit:NO] longLongValue];
        if ((currentTimeStamp - lastTimeStamp > 60000) && lastTimeStamp!=0)//间隔大于十分钟
            [self.delegate dataTransferStatusUpdated:BLS_OFFLINE_DATA packageReceived:(NSUInteger)(numberOfQuaternionReceived+numberOfAcceeleraionReceived)];
        {
            _currentHandler = [[SensorDataHandler alloc] init];
            [_sensorDataHandlersArray addObject:_currentHandler];
        }
        if([DataParser parseDataType:characteristic.value])//四元数
        {
            numberOfQuaternionReceived++;
            NSString* string=[NSString stringWithFormat:@"%@%d%@",
                              @"Receieved ",numberOfQuaternionReceived,@" quaternions" ];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"updateQuaternion" object:string];
            //            [[NSNotificationCenter defaultCenter]postNotificationName:@"updateQuaternion" object:string];
            //            [[SensorDataHandler sharedInstance] pushQuaternion:[DataParser parseQuaternion:characteristic.value]];
            
            NSArray*  attitudeAngle = [_currentHandler pushQuaternion:[DataParser parseQuaternion:characteristic.value]];
            NSString* quaternionDetails = [NSString stringWithFormat:@"yaw:%@\r\npitch:%@\r\nroll:%@\r\n",attitudeAngle[0],attitudeAngle[1],attitudeAngle[2]];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"updateOnlineQuaternion" object:quaternionDetails];
            
        }
        else//加速度
        {
            numberOfAcceeleraionReceived++;
            NSString* string = [NSString stringWithFormat:@"%@%@%@",
                                @"Receieved ",[NSString stringWithFormat:@"%d",numberOfAcceeleraionReceived],@" Acceleration"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"updateAcceleration" object:string];
            [_currentHandler pushAcceleration:[DataParser parseAcceleration:characteristic.value]];
            
            
            NSMutableString* accelerationDetails = [[NSMutableString alloc] init];
            AccelerationPackage* acceleration = [DataParser parseAcceleration:characteristic.value];
            for (int i = 0; i < 3; i++)
            {
                [accelerationDetails appendString:[NSString stringWithFormat:@"X%i:%@  Y%i:%@  Z%i:%@ \r\n",i,acceleration.data[i][0],i,acceleration.data[i][1],i,acceleration.data[i][2]]];
            }
            [accelerationDetails appendString:[NSString stringWithFormat:@"Pressure:%f",acceleration.pressure]];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"updateOnlineAcceleration" object:accelerationDetails];
        }
        lastTimeStamp = currentTimeStamp;
    }
}
@end
