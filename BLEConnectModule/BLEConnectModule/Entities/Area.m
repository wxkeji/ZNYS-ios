//
//  Area.m
//  bluetoothUnitTest
//
//  Created by 张恒铭 on 10/12/15.
//  Copyright © 2015 张恒铭. All rights reserved.
//

#import "Area.h"

@implementation Area
-(instancetype)init
{
    self = [super init];
    self.startTime = self.endTime = self.yawMedian = self.rollMedian = self.pitchMedian = 0;
    self.type= unknown;
    self.rollVector = [[NSMutableArray alloc] init];
    self.pitchVector = [[NSMutableArray alloc] init];
    self.yawVector = [[NSMutableArray alloc] init];
    self.amplitudeVector = [[NSMutableArray alloc] init];
    return self;
}
-(AreaType)getAreaType
{
    return self.type;
}
-(long)getDuration
{
    return (self.endTime - self.startTime);
}
-(int)getBrushTime
{
    return (int)[self.amplitudeVector count]/2;
}
-(int)getAmplitudeAverage
{
    if(self.amplitudeAverage == 0)
    {
        int sum = 0;
        for (NSNumber *i in self.amplitudeVector)
        {
            sum += [i intValue];
        }
        self.amplitudeAverage = sum / [self.amplitudeVector count];
    }
    return self.amplitudeAverage;
}
@end
