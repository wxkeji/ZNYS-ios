//
//  CalendarDetailModalViewController.h
//  ZNYS
//
//  Created by yu243e on 16/8/18.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "PresentedBaseModalViewController.h"
#import "CalendarDetailModel.h"

@interface CalendarDetailModalViewController : PresentedBaseModalViewController
@property (nonatomic, strong) NSMutableArray<CalendarDetailModel *> * calendarDetailModels;

@end
