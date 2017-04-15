//
//  AnalysisResultItem.h
//  bluetoothUnitTest
//
//  Created by 张恒铭 on 10/7/15.
//  Copyright © 2015 张恒铭. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnalysisResultItem : NSObject
@property(nonatomic) long duration;
@property(nonatomic) int brushTime;
@property(nonatomic) bool isCorrect;
@property(nonatomic) long startTime;
@property(nonatomic) long endTime;

-(void)addDuration:(long) newDuration;
-(void)addBrushTime:(int) newBrushTime;
@end
