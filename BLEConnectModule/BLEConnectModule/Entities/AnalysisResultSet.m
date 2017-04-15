//
//  AnalysisResultSet.m
//  bluetoothUnitTest
//
//  Created by 张恒铭 on 10/23/15.
//  Copyright © 2015 张恒铭. All rights reserved.
//

#import "AnalysisResultSet.h"
#import "AnalysisResultItem.h"
#import "Area.h"
@interface AnalysisResultSet()
@end

@implementation AnalysisResultSet
-(instancetype)init
{
    self = [super init];
    self.dataDictionary = [[NSMutableDictionary alloc]init];
    return self;
}
-(void)addResultItem:(NSUInteger)areaType result:(AnalysisResultItem*)item
{
    AnalysisResultItem* analysisResultItem = [_dataDictionary objectForKey:[NSString stringWithFormat:@"%lu",(unsigned long)areaType]];
    if (analysisResultItem == nil)
    {
        if (areaType != unknown)
        {
            analysisResultItem = item;
            [self.dataDictionary setObject:analysisResultItem forKey:[NSString stringWithFormat:@"%lu",(unsigned long)areaType]];
        }
    }
    else if([item isCorrect])//注意对指针的操作
    {
        analysisResultItem.endTime=item.endTime;
        [analysisResultItem addDuration:item.duration]  ;
        [analysisResultItem addBrushTime:item.brushTime];
        analysisResultItem.isCorrect = item.isCorrect;
    }
}
-(AnalysisResultItem*) getResultItem:(NSUInteger)areaType
{
    return [self.dataDictionary objectForKey:[NSString stringWithFormat:@"%lu",(unsigned long)areaType]];
}
@end
