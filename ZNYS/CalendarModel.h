//
//  CalendarModel.h
//  ZNYS
//
//  Created by yu243e on 16/7/3.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalendarModel : NSObject

@property (nonatomic, strong) NSDate * date;
@property (nonatomic, assign) NSInteger tag;
@property (nonatomic, assign) NSInteger starNum;

@property (nonatomic, assign) BOOL validData;
@property (nonatomic, assign) BOOL future;

@end
