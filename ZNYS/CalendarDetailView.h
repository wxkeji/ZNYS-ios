//
//  CalendarDetailView.h
//  ZNYS
//
//  Created by yu243e on 16/6/29.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "ZNYSBaseView.h"
@class CalendarItem;

typedef void(^DismissBlock)();

@interface CalendarDetailView : ZNYSBaseView

@property (nonatomic,copy) DismissBlock dismissBlock;

- (instancetype)initWithModel:(CalendarItem *)model;

@end
