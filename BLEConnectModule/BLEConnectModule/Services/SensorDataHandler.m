//                            _ooOoo_
//                           o8888888o
//                           88" . "88
//                           (| -_- |)
//                            O\ = /O
//                        ____/`---'\____
//                      .   ' \\| |// `.
//                       / \\||| : |||// \
//                     / _||||| -:- |||||- \
//                       | | \\\ - /// | |
//                     | \_| ''\---/'' | |
//                      \ .-\__ `-` ___/-. /
//                   ___`. .' /--.--\ `. . __
//                ."" '< `.___\_<|>_/___.' >'"".
//               | | : `- \`.;`\ _ /`;.`/ - ` : | |
//                 \ \ `-. \_ __\ /__ _/ .-` / /
//         ======`-.____`-.___\_____/___.-`____.-'======
//                            `=---='
//
//         .............................................
//                    佛祖保佑       永无BUG
//
//  SensorDataHandler.m
//  bluetoothUnitTest
//
//  Created by 张恒铭 on 10/9/15.
//  Copyright © 2015 张恒铭. All rights reserved.
//
#define  ACCELERATION_AXIS_X 0
#define ACCELERATION_AXIS_Y 1
#define YAW 2
#define PITCH 3
#define ROLL 4
#define INVALID_NON_TIMESTAMP_VALUE -9999
#define INVALID_TIMESTAMP_VALUE -1
#define ANGLE_ERROR 15
#import "SensorDataHandler.h"
#import "Area.h"
#import "AnalysisResultItem.h"
#import "QuaternionPackage.h"
#pragma mark - private variable and methods
@interface SensorDataHandler()
@property SensorData* sensorData;
@property(nonatomic) NSMutableArray* areas;
@property NSMutableArray* lastPeakPoint;
@property NSMutableArray* tempDirection;
@property NSMutableArray* direction;
@property int left_middle_yaw, right_middle_yaw, normalized_yaw, left_middle_pitch, right_middle_pitch;
-(double)getNormalizedAngle:(double)angle;
-(void)dispatchAngleDataToArea:(int)axis;
-(void)buildCoordinate:(Area*)areaPointer;
-(void)statisticalAnalyse:(Area*) areaPointer;
-(BOOL)isInRange:(double)startAngle endAngle:(double)endAngle targetAngle:(double)targetAngle;
-(BOOL)approximatelyEqualTo:(int)angleCompared :(int)targetAngle;
-(NSArray*)quaternionToEulerAngle:(double)w x:(double)x y:(double)y z:(double)z;
@end
#pragma mark - extension to NSMuutableArray
@implementation NSMutableArray(Extention)
-(void)addLong:(long)longNumber
{
    [self addObject:[NSNumber numberWithLong:longNumber]];
}
-(void)addInt:(int)intNumber
{
    [self addObject:[NSNumber numberWithInt:intNumber]];
}
-(void)replaceInt:(int)number with:(NSUInteger)index
{
    [self replaceObjectAtIndex:index   withObject:[NSNumber numberWithInt:number]];
}
-(void)reaplaceLong:(long)number with:(NSUInteger)index
{
    [self replaceObjectAtIndex:index   withObject:[NSNumber numberWithLong:number]];
}
-(int)retrieveInt:(int)index
{
    return [[self objectAtIndex:index]intValue];
}
-(long)retrieveLong:(NSUInteger)index
{
    return [[self objectAtIndex:index]longValue];
}
-(NSMutableArray*)sortArray
{
    return [[self sortedArrayUsingComparator:^NSComparisonResult(id obj1,id obj2)
    {
        if ([obj1 intValue] > [obj2 intValue]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        else
            return (NSComparisonResult)NSOrderedDescending;
    }] mutableCopy];
}     //留意mutbaleCopy方法
        //原数组内容改变时，mutableCopy产生的对象里的内容也对应改变
@end

@implementation SensorDataHandler
#pragma mark - 预处理和常用methods
-(NSArray*)quaternionToEulerAngle:(double)w x:(double)x y:(double)y z:(double)z;
{
    double param = sqrt(w*w + y*y + x*x + z*z);
    w /= param;
    x /= param;
    y /= param;
    z /= param;
    int yaw = (int)(atan2(-2 * w * z + 2 * x * y, -2 * z * z - 2 * x * x + 1)* 57.3);
    int pitch = (int)(asin(2 * y * z + 2 * w * x) * 57.3);
    int roll = (int)(atan2(-2 * y * w + 2 * x * z, -2 * x * x - 2 * y * y + 1) * 57.3);
    if (yaw < 0.0f)
    {
        yaw += 360.0f;
    }
    NSArray* array = [[NSArray alloc]initWithObjects:[NSNumber numberWithInt:yaw],[NSNumber numberWithInt:pitch],[NSNumber numberWithInt:roll], nil];
    return array;
}

-(double)getNormalizedAngle:(double)angle
{
    if (angle < 0.0f)
        return angle + 360.0f;
    if (angle > 360.0f)
        return angle - 360.0f;
        return angle;
}

-(instancetype)init;
{
    @throw [NSException exceptionWithName:@"Wrong initialization method"
        reason:@"Singleton, use method initPrivate"
        userInfo:nil];
}
+(instancetype) sharedInstance
{
    static SensorDataHandler* instance;
    if(!instance)
    {
        instance = [[self alloc ]initPrivate];
    }
    return instance;
}
-(instancetype)initPrivate
{
    self = [super init];
    self.sensorData = [SensorData DataStore];
    self.lastPeakPoint = [[NSMutableArray alloc]init];
    self.areas = [[NSMutableArray alloc]init];
    self.left_middle_yaw = self.right_middle_yaw = self.left_middle_pitch = self.right_middle_pitch = -1;
    self.tempDirection = [[NSMutableArray alloc]init];
    self.direction = [[NSMutableArray alloc]init];
    for (int i = 0 ; i<2; i++)
    {//初始化x和Y轴的leak point , direction and temp direction
        [self.lastPeakPoint addInt:INVALID_NON_TIMESTAMP_VALUE];
        [self.direction addInt:0];//下标0 等同 ACCELERATION_AXIS_X, 1等同 ACCELERATION_AXIS_Y,下同
        [self.tempDirection addInt:1];
        [self.areas addObject:[[AreaGroup alloc] init]];
    }
    return self;
}
-(BOOL)approximatelyEqualTo:(int)angleCompared :(int)targetAngle
{
    return ( (angleCompared < targetAngle + ANGLE_ERROR) &&(angleCompared > targetAngle - ANGLE_ERROR) );
}
#pragma mark - 装入数据
-(void)pushAcceleration:(AccelerationPackage*)acceleration
{
    for (NSUInteger i = 0; i<3; i++)//3为3组加速度
    {
        //潜在风险：1.acceleration.data 对象不符合规范 2.NSArray创建后不可改导致的问题。2015.10.20 Eric Cheung
        //acceleration.data[i][0~2]
        NSArray* temp =[[NSArray alloc] initWithArray: [acceleration.data objectAtIndex:i]];
        int x = [temp[0] intValue];
        int y = [temp[1] intValue];
        int t = [temp[2] intValue];
        [self.sensorData pushAcceleration:x :y :t];
        [self accelerationPretreatment:ACCELERATION_AXIS_X];
        [self accelerationPretreatment:ACCELERATION_AXIS_Y];
    }
}
-(NSArray*)pushQuaternion:(QuaternionPackage*)quaternion
{
    NSArray* resultArray = [[NSArray alloc] init];
    resultArray = [self quaternionToEulerAngle:[quaternion.data[0] doubleValue] x:[quaternion.data[1] doubleValue] y:[quaternion.data[2] doubleValue] z:[quaternion.data[3] doubleValue]];
    [_sensorData pushAttitudeAngle:[resultArray[0] intValue] pitch:[resultArray[1] intValue] roll:[resultArray[2] intValue]];
    return resultArray;
}
#pragma mark - 预处理阶段
-(void)accelerationPretreatment:(int)axis
{
    if ([self.sensorData getDataLength:axis] < 2 )
    {
        return;
    }
    if([self.lastPeakPoint retrieveInt:axis] == INVALID_NON_TIMESTAMP_VALUE)
    {
        self.lastPeakPoint[axis] = [NSNumber numberWithInt:[_sensorData getData:axis index:0 ]];
    }
    int lastAcceleration = [_sensorData getLastData:axis];
    int beforeLastAcceleration = [_sensorData getBeforeLastData:axis];
    if (lastAcceleration > beforeLastAcceleration)
    {
        [_tempDirection replaceInt:1 with:axis];
    }//1 means postive
    else if(lastAcceleration < beforeLastAcceleration)
    {
        [_tempDirection replaceInt:-1 with:axis];
    }//-1 means negative
    if([_tempDirection retrieveInt:axis] * [_direction retrieveInt:axis] < 0)
    {
        int amplitude = abs([_lastPeakPoint retrieveInt:axis] - beforeLastAcceleration);
        [_areas[axis] add:[_sensorData getBeforeLastTimeStamp:axis]  amplitude:amplitude];
        self.lastPeakPoint[axis] = [NSNumber numberWithInt:beforeLastAcceleration];
    }
    [_direction replaceInt:[_tempDirection[axis] intValue] with:axis];
}
-(void)dispatchAngleDataToArea:(int)axis
{
    Area* areaPointer = [[self.areas objectAtIndex:axis] getArea:0];
    int i = 1;
    while ( areaPointer != nil && (i < [self.sensorData getDataLength:YAW]) ) {
        long timeStamp = [self.sensorData getTimeStamp:YAW index:i];
        if ((timeStamp >= areaPointer.startTime && timeStamp<= areaPointer.endTime)||(timeStamp + 400 >= areaPointer.startTime && timeStamp + 400 <= areaPointer.endTime))
        {
            for (int j = 0;j < 5; j++)//这个循环为什么是五次？？？
            {
                [areaPointer.yawVector addInt:[self.sensorData getData:YAW index:i]];
                [areaPointer.rollVector addInt:[self.sensorData getData:ROLL index:i]];
                [areaPointer.pitchVector addInt:[self.sensorData getData:PITCH index:i]];
            }
            i++;
        }
        else if(timeStamp > areaPointer.endTime)
        {
            areaPointer = areaPointer.next;
        }
        else
        {
            i++;
        }
    }
}
#pragma mark - 处理第一阶段
-(void)buildCoordinate:(Area*)areaPointer
{
    if ( ((areaPointer.rollMedian <= 180) && (areaPointer.rollMedian >= (180 - ANGLE_ERROR)) )
        || ( (areaPointer.rollMedian <= (-180 + ANGLE_ERROR)) && (areaPointer.rollMedian >= -180) )
        || (areaPointer.rollMedian <= ANGLE_ERROR && areaPointer.rollMedian >= -ANGLE_ERROR))
    {
        if ( (self.left_middle_yaw < 0) || (self.left_middle_yaw < areaPointer.yawMedian) )
        {
            self.left_middle_yaw = areaPointer.yawMedian;
            self.left_middle_pitch = areaPointer.pitchMedian;
        }
        else if ( (self.right_middle_yaw < 0) || (self.right_middle_yaw > areaPointer.yawMedian) )
        {
            self.right_middle_yaw = areaPointer.yawMedian;
            self.right_middle_pitch = areaPointer.pitchMedian;
        }
    }
}
-(void)statisticalAnalyse:(Area*) areaPointer
{
    if (areaPointer == nil)
        return;
    areaPointer.yawVector  = [areaPointer.yawVector sortArray];
    areaPointer.rollVector = [areaPointer.rollVector sortArray];
    areaPointer.pitchVector= [areaPointer.pitchVector sortArray];
    areaPointer.yawMedian  = [areaPointer.yawVector retrieveInt:
                             (int)([areaPointer.yawVector count]/2) ];
    areaPointer.rollMedian = [areaPointer.rollVector retrieveInt:
                              (int)([areaPointer.rollVector count]/2)];
    areaPointer.pitchMedian= [areaPointer.pitchVector retrieveInt:
                              (int)([areaPointer.pitchVector count]/2)];
    [self buildCoordinate:areaPointer];
}
-(void)statisticalAnalyseAll
{
    [[_areas objectAtIndex:ACCELERATION_AXIS_X] deleteUselessArea];
    [[_areas objectAtIndex:ACCELERATION_AXIS_Y] deleteUselessArea];
    [self dispatchAngleDataToArea:ACCELERATION_AXIS_X];
    [self dispatchAngleDataToArea:ACCELERATION_AXIS_Y];
    for (int j = 0; j<2; j++)
    {
        for (int i = 0; i<[self.areas[j] getAreaNumber]; i++)
        {
            Area* areaPointer = [self.areas[j] getArea:i];
            [self statisticalAnalyse:areaPointer];
        }
    }
    if (abs(self.left_middle_yaw - self.right_middle_yaw)>=180)
    {
        int temp_middle_yaw= self.left_middle_yaw;
        self.left_middle_yaw = self.right_middle_yaw;
        self.right_middle_yaw = temp_middle_yaw;
        self.left_middle_yaw += 360;
    }
    self.normalized_yaw = (int) ((self.left_middle_yaw+self.right_middle_yaw)/2.0f);
    if (self.normalized_yaw > 360.0f)
    {
        self.normalized_yaw -= 360.0f;
    }
}
-(BOOL)isInRange:(double)startAngle endAngle:(double)endAngle targetAngle:(double)targetAngle
{
    startAngle = [self getNormalizedAngle:startAngle];
    endAngle = [self getNormalizedAngle:endAngle];
    targetAngle = [self getNormalizedAngle:targetAngle];
    if (fabs(startAngle - endAngle) > 180.0f)
    {
        if ( (targetAngle > startAngle) || (targetAngle < endAngle))
        {
            return true;
        }
    }
        else
        {
            if ((targetAngle > startAngle) && (targetAngle < endAngle))
            {
                return true;
            }
        }
    return false;
}
#pragma mark - 处理第二阶段
-(void)classifyAreas
{
    for (int j = 0 ; j < 2 ; j++)
    {
        for (int i = 0; i < [self.areas[j] getAreaNumber] ; i++)
        {
            Area* areaPointer = [self.areas[j] getArea:i];
            //刷上面的咬合面或者上门牙内侧
            if ([self approximatelyEqualTo:areaPointer.rollMedian :0])
            {
                /*Conditon 1 left_middle_yaw*/
                if (areaPointer.yawMedian == self.left_middle_yaw)
                    areaPointer.type = left_middle_up;
                /*condition 2 right_middle_yaw*/
                else if (areaPointer.yawMedian == self.right_middle_yaw)
                    areaPointer.type = right_middle_up;
                /*condition 3 in range between normalized_yaw and left_middle_yaw*/
                else if ([self isInRange:self.normalized_yaw endAngle:self.left_middle_yaw targetAngle:areaPointer.yawMedian])
                {
                    if(abs(areaPointer.pitchMedian - self.left_middle_pitch) < 10 )
                        areaPointer.type = left_middle_up;
                    else
                        areaPointer.type = front_inner_up;
                }
                /*condition 4 in range between right_middle_yaw and normalized_yaw*/
              else if([self isInRange:self.right_middle_yaw endAngle:self.normalized_yaw targetAngle:areaPointer.yawMedian])
                {
                    if(abs(areaPointer.yawMedian - self.right_middle_pitch) < 10 )
                        areaPointer.type = right_middle_up;
                    else
                        areaPointer.type = front_inner_up;
                }
                /*condition 5 if all conditions before is not satisfied*/
                else
                    areaPointer.type = unknown;
            }
           
             //刷下方的咬合面或下门牙内侧
            else if([self approximatelyEqualTo:areaPointer.rollMedian :180] || [self approximatelyEqualTo:areaPointer.rollMedian :-180])
            {
                if(areaPointer.yawMedian == self.left_middle_yaw)
                   areaPointer.type = left_middle_down;
                else if(areaPointer.yawMedian == self.right_middle_yaw)
                    areaPointer.type = right_middle_down;
                else if([self isInRange:self.normalized_yaw endAngle:self.left_middle_yaw targetAngle:areaPointer.yawMedian])
                {
                    if(abs(areaPointer.pitchMedian - self.left_middle_pitch) < 10 )
                        areaPointer.type = left_middle_down;
                    else
                        areaPointer.type = front_inner_down;
                }
                else if([self isInRange:self.right_middle_yaw endAngle:self.normalized_yaw targetAngle:areaPointer.yawMedian])
                {
                    if(abs(areaPointer.pitchMedian - self.right_middle_pitch) < 10 )
                        areaPointer.type = right_middle_down;
                    else
                        areaPointer.type = front_inner_down;
                }
                else
                    areaPointer.type = unknown;
            }
            // 左边外侧或右边里侧或者门牙外侧
            else if((areaPointer.rollMedian > ANGLE_ERROR) && (areaPointer.rollMedian < (180 - ANGLE_ERROR)))
            {
                if([self isInRange:self.left_middle_yaw endAngle:self.left_middle_yaw + 45 targetAngle:areaPointer.yawMedian])
                    areaPointer.type = left_outer;
                else if([self isInRange:self.right_middle_yaw - 45 endAngle:self.right_middle_yaw targetAngle:areaPointer.yawMedian])
                {
                    if (areaPointer.rollMedian > ANGLE_ERROR && areaPointer.rollMedian < 90)
                        areaPointer.type = right_inner_up;
                    else
                        areaPointer.type = right_inner_down;
                }
                else
                    areaPointer.type = front_outer;
            }
            // 左边里侧或右边外侧或者门牙外侧
            else if((areaPointer.rollMedian > (-180 + ANGLE_ERROR)) && (areaPointer.rollMedian < -ANGLE_ERROR))
            {
                if([self isInRange:self.left_middle_yaw endAngle:self.left_middle_yaw + 45 targetAngle:areaPointer.yawMedian])
                {
                    if((areaPointer.rollMedian > -90) && (areaPointer.rollMedian < -ANGLE_ERROR))
                        areaPointer.type = left_inner_up;
                    else
                        areaPointer.type = left_inner_down;
                }
                else if([self isInRange:self.right_middle_yaw - 45 endAngle:self.right_middle_yaw targetAngle:areaPointer.yawMedian])
                {
                    areaPointer.type = right_outer;
                }
                else
                    areaPointer.type = front_outer;
            }
        }
    }
}
-(AnalysisResultSet*)getFinalResult
{
    AnalysisResultSet* analysisResultSet = [[AnalysisResultSet alloc]init];
    for (int j = 0 ; j < 2 ; j++ )
    {
        for (int i = 0 ; i < [self.areas[j] getAreaNumber]; i++)
        {
            Area* area = [[Area alloc] init];
            area = [self.areas[j] getArea:i];
            AnalysisResultItem* item = [[AnalysisResultItem alloc] init];
            item.brushTime = [area getBrushTime];
            item.duration = [area getDuration];
            item.startTime = area.startTime;
            item.endTime = area.endTime;
/*第一个分支*/if(area.type >= 0 && area.type < 7)
            {
                if (j==0)
                item.isCorrect = true;
                else
                item.isCorrect = false;
            }
/*第二个分支*/else if(area.type >= 7 && area.type < 13)
            {
                if(j==1)
                    item.isCorrect = true;
                else
                    item.isCorrect = false;
            }
/*第三个分支*/else
            {
                item.isCorrect = false;
            }
            [analysisResultSet addResultItem:area.type result:item];
        }//第二层for循环
    }//第一层for循环
    return analysisResultSet;
}
#pragma mark - 清除数据
-(void)clearStatistic
{
    self.areas = nil;
    self.lastPeakPoint = nil;
    self.tempDirection = nil;
    self.direction = nil;
    self.sensorData = [SensorData DataStore];
    self.lastPeakPoint = [[NSMutableArray alloc]init];
    self.areas = [[NSMutableArray alloc]init];
    self.left_middle_yaw = self.right_middle_yaw = self.left_middle_pitch = self.right_middle_pitch = -1;
    self.tempDirection = [[NSMutableArray alloc]init];
    self.direction = [[NSMutableArray alloc]init];
    for (int i = 0 ; i<2; i++)
    {
        //初始化x和Y轴的leak point , direction and temp direction
        [self.lastPeakPoint addInt:INVALID_NON_TIMESTAMP_VALUE];
        [self.direction addInt:0];//下标0 等同 ACCELERATION_AXIS_X, 1等同 ACCELERATION_AXIS_Y,下同
        [self.tempDirection addInt:1];
        [self.areas addObject:[[AreaGroup alloc] init]];
    }
    [_sensorData clearStatistic];
}
@end
