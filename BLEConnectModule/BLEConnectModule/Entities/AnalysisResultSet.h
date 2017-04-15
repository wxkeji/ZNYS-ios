//
//  AnalysisResultSet.h
//  bluetoothUnitTest
//
//  Created by 张恒铭 on 10/23/15.
//  Copyright © 2015 张恒铭. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AnalysisResultItem.h"
@interface AnalysisResultSet : NSObject
@property(nonatomic,strong)NSMutableDictionary* dataDictionary;
-(void)addResultItem:(NSUInteger)areaType result:(AnalysisResultItem*)item;
@end
