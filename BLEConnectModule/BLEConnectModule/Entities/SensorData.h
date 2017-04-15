//
//  SensorData.h
//  bluetoothUnitTest
//
//  Created by 张恒铭 on 15/8/3.
//  Copyright © 2015年 张恒铭. All rights reserved.
//

#define ACCELERATION_AXIS_X 0
#define ACCELERATION_AXIS_Y 1
#define YAW 2
#define PITCH 3
#define ROLL 4
#define INVALID_NON_TIMESTAMP_VALUE -9999
#define INVALID_TIMESTAMP_VALUE -1
//Marcos should not contained ';' !!
#import <Foundation/Foundation.h>
#import "SensorData.h"
@interface SensorData : NSObject






@property(nonatomic,strong) NSMutableArray* accelerationXVector;
@property(nonatomic,strong) NSMutableArray* accelerationYVector;
@property(nonatomic,strong) NSMutableArray* yawVector;
@property(nonatomic,strong) NSMutableArray* pitchVector;
@property(nonatomic,strong) NSMutableArray* rollVector;


@property long startTime;
+(instancetype) DataStore;
-(instancetype) initPrivate;


-(void)pushAcceleration:(int)x :(int)y :(long)t;
-(void)pushAttitudeAngle:(int)yaw pitch:(int)pitch roll:(int)roll;
-(int)getData:(int)dataType index:(int)index;
-(int)getLastData:(int)dataType;
-(int)getBeforeLastData:(int)dataType;
-(int)getDataLength:(int)dataType;
-(long)getTimeStamp:(int)dataType index:(int)index;
-(long)getBeforeLastTimeStamp:(int)dataType;

-(void)clearStatistic;
@end
