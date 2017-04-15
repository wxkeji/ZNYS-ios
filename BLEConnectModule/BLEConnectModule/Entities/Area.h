//
//  Area.h
//  bluetoothUnitTest
//
//  Created by 张恒铭 on 10/12/15.
//  Copyright © 2015 张恒铭. All rights reserved.
//
#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger,AreaType){
    front_outer, left_outer, right_outer, left_inner_up, left_inner_down, right_inner_up, right_inner_down, front_inner_up, front_inner_down, left_middle_up, left_middle_down, right_middle_up, right_middle_down, unknown
};
#pragma mark - properties
@interface Area : NSObject
@property AreaType type;
@property long startTime,endTime;
@property int yawMedian;
@property int rollMedian;
@property int pitchMedian;
@property int amplitudeAverage;
@property NSMutableArray* amplitudeVector;
@property NSMutableArray* yawVector;
@property NSMutableArray* pitchVector;
@property NSMutableArray* rollVector;
@property Area* next;
#pragma mark - public method
-(AreaType)getAreaType;
-(long)getDuration;
-(int)getBrushTime;
-(int)getAmplitudeAverage;
@end
