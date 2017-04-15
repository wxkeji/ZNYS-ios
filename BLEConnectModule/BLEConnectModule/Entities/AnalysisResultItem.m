//
//  AnalysisResultItem.m
//  bluetoothUnitTest
//
//  Created by 张恒铭 on 10/7/15.
//  Copyright © 2015 张恒铭. All rights reserved.
//

#import "AnalysisResultItem.h"


@implementation AnalysisResultItem

-(instancetype)init
{
    self = [super init];
    self.startTime = -1;
    self.endTime = -1;
    self.duration = 0;
    return self;
}
-(void)addDuration:(long) newDuration
{
    self.duration += newDuration;
}
-(void)addBrushTime:(int) newBrushTime
{
    self.brushTime += newBrushTime;
}
-(void)setStartTime:(long)newStartTime
{
    if (self.startTime == -1) {
        self.startTime = newStartTime;
    }
}
@end
