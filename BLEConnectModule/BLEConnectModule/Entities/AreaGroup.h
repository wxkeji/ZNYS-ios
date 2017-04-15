//
//  AreaGroup.h
//  bluetoothUnitTest
//
//  Created by 张恒铭 on 10/12/15.
//  Copyright © 2015 张恒铭. All rights reserved.
//
#define AREA_LENGTH_THRESHOLD 1100
#define AMPLITUDE_THRESHOLD 2000
#define SEPARATED_RATIO 2 

#import <Foundation/Foundation.h>
#import "Area.h"
@interface AreaGroup : NSObject
-(void)add:(long)timeStamp amplitude:(int)amplitude;
-(Area*)getArea:(int)index;
-(void)deleteUselessArea;
-(int)getAreaNumber;
-(long)getStartTime;
-(long)getEndTime;
@end
