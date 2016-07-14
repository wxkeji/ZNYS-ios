//
//  SensorDataHandler.h
//  bluetoothUnitTest
//
//  Created by 张恒铭 on 10/9/15.
//  Copyright © 2015 张恒铭. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SensorData.h"
#import "Area.h"
#import "AreaGroup.h"
#import "AccelerationPackage.h"
#import "AnalysisResultSet.h"
#import "QuaternionPackage.h"

@interface SensorDataHandler : NSObject

//+(instancetype) sharedInstance;

-(void)pushAcceleration:(AccelerationPackage*)acceleration;
-(NSArray*)pushQuaternion:(QuaternionPackage*)quaternion;

-(void)classifyAreas;
-(void)statisticalAnalyseAll;
-(AnalysisResultSet*)getFinalResult;
-(AnalysisResultSet*)analysisAndGetFinalResult;

-(void)clearStatistic;
@end
