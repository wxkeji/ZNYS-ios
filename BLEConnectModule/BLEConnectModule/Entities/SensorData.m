//
//  SensorData.m
//  bluetoothUnitTest
//
//  Created by 张恒铭 on 15/8/3.
//  Copyright © 2015年 张恒铭. All rights reserved.
//
//Don't forget bounds of index while operating on array!
#import "SensorData.h"
@interface SensorData()
-(instancetype)init;
@end

@implementation NSMutableArray(Extention)
-(void)addLong:(long)longNumber
{
    [self addObject:[NSNumber numberWithLong:longNumber]];
}
-(void)addInt:(int)intNumber
{
    [self addObject:[NSNumber numberWithInteger:intNumber]];
}
@end




@implementation SensorData
#pragma initializaition methods
-(instancetype)init;
{
    self = [super init];
    _accelerationXVector = [[NSMutableArray alloc]init];
    _accelerationYVector = [[NSMutableArray alloc]init];
    _yawVector = [[NSMutableArray alloc]init];
    _rollVector = [[NSMutableArray alloc]init];
    _pitchVector = [[NSMutableArray alloc]init];
    self.startTime = 0L;
    return self;
}
//+(instancetype) DataStore
//{
//    static SensorData* defaultData;
//    if(!defaultData)
//    {
//        defaultData = [[self alloc ]initPrivate];
//    }
//    return defaultData;
//}
//-(instancetype)initPrivate;
//{
//    self = [super init];
//    _accelerationXVector = [[NSMutableArray alloc]init];
//    _accelerationYVector = [[NSMutableArray alloc]init];
//    _yawVector = [[NSMutableArray alloc]init];
//    _rollVector = [[NSMutableArray alloc]init];
//    _pitchVector = [[NSMutableArray alloc]init];
//    self.startTime = 0L;
//    return self;
//}
#pragma mark - Add Data
-(void)pushAttitudeAngle:(int)yaw pitch:(int)pitch roll:(int)roll
{
    [self.yawVector addInt:yaw];
    [self.pitchVector addInt:pitch];
    [self.rollVector addInt:roll];
}
-(void)pushAcceleration:(int)x :(int)y :(long)t
{
    [self.accelerationXVector addInt:x];
    [self.accelerationYVector addInt:y];
    if(self.startTime == 0L)
        self.startTime = t;
}
#pragma mark - retrieve data method
-(int)getData:(int)dataType index:(int)index//Be careful of out of bounds!
{
    @try {
        switch (dataType) {
            case ACCELERATION_AXIS_X:
                return [[self.accelerationXVector objectAtIndex:index] intValue];
                break;
            case ACCELERATION_AXIS_Y:
                return [[self.accelerationXVector objectAtIndex:index] intValue];
                break;
            case YAW:
                return [[self.yawVector objectAtIndex:index] intValue];
                break;
            case PITCH:
                return [[self.pitchVector objectAtIndex:index] intValue];
                break;
            case ROLL:
                return [[self.rollVector  objectAtIndex:index] intValue];
                break;
            default:
                return INVALID_NON_TIMESTAMP_VALUE;
                break;
        }
    }
    @catch (NSException* exception)
    {
        NSLog(@"Exception occured! %@",exception);
    }
}
-(int)getLastData:(int)dataType
{
    @try {
        switch (dataType) {
            case ACCELERATION_AXIS_X:
                return [[self.accelerationXVector lastObject] intValue];
                break;
            case ACCELERATION_AXIS_Y:
                return [[self.accelerationXVector lastObject] intValue];
                break;
            case YAW:
                return [[self.yawVector lastObject] intValue];
                break;
            case PITCH:
                return [[self.pitchVector lastObject] intValue];
                break;
            case ROLL:
                return [[self.rollVector  lastObject] intValue];
                break;
            default:
                return INVALID_NON_TIMESTAMP_VALUE;
                break;
        }
    }
    @catch (NSException* exception)
    {
        NSLog(@"Exception occured! %@",exception);
    }
    
}

-(int)getBeforeLastData:(int)dataType
{
    @try {
        switch (dataType) {
            case ACCELERATION_AXIS_X:
                return [[self.accelerationXVector objectAtIndex:([self.accelerationXVector count] -2)] intValue];
                break;
            case ACCELERATION_AXIS_Y:
                return [[self.accelerationXVector objectAtIndex:([self.accelerationYVector count] -2)] intValue];
                break;
            case YAW:
                return [[self.yawVector objectAtIndex:([self.yawVector count] -2)] intValue];
                break;
            case PITCH:
                return [[self.pitchVector objectAtIndex:([self.pitchVector count] -2)] intValue];
                break;
            case ROLL:
                return [[self.rollVector  objectAtIndex:([self.rollVector count] -2)] intValue];
                break;
            default:
                return INVALID_NON_TIMESTAMP_VALUE;
                break;
        }
    }
    @catch (NSException* exception)
    {
        NSLog(@"Exception occured! %@",exception);
    }
    
}


-(int)getDataLength:(int)dataType
{
    switch (dataType) {
        case ACCELERATION_AXIS_X:
            return (int)[self.accelerationXVector count];
            break;
        case ACCELERATION_AXIS_Y:
            return (int)[self.accelerationYVector count];
            break;
        case YAW:
            return (int)[self.yawVector count];
            break;
        case ROLL:
            return (int)[self.rollVector count];
            break;
        case PITCH:
            return (int)[self.pitchVector count];
        default:
            return INVALID_NON_TIMESTAMP_VALUE;
            break;
    }
}
-(long)getTimeStamp:(int)dataType index:(int)index
{
    switch (dataType) {
        case ACCELERATION_AXIS_X :
            return index*100L;
            break;
        case ACCELERATION_AXIS_Y:
            return index*100L;
            break;
        case PITCH:
            return index*500L;
            break;
        case ROLL:
            return index*500L;
            break;
        case YAW:
            return index*500L;
            break;
        default:
            return (long)INVALID_TIMESTAMP_VALUE;
            break;
    }
}
-(long)getBeforeLastTimeStamp:(int)dataType
{
    switch (dataType)
    {
        case ACCELERATION_AXIS_X:
            return ([self.accelerationXVector count] - 2) * 100L;
            break;
        case ACCELERATION_AXIS_Y:
            return ([self.accelerationYVector count] - 2) * 100L;
            break;
        case YAW:
            return ([self.yawVector count] - 2) * 500L;
            break;
        case ROLL:
            return ([self.rollVector count] - 2) * 500L;
            break;
        case PITCH:
            return ([self.pitchVector count] - 2) * 500L;
        default:
            return (long)INVALID_TIMESTAMP_VALUE;
            break;
    }
}

-(void)clearStatistic
{
    
    _accelerationXVector = [[NSMutableArray alloc]init];
    _accelerationYVector = [[NSMutableArray alloc]init];
    _yawVector = [[NSMutableArray alloc]init];
    _rollVector = [[NSMutableArray alloc]init];
    _pitchVector = [[NSMutableArray alloc]init];
    self.startTime = 0L;
}
@end
