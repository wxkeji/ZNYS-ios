//
//  ConnectedResultContentView.h
//  ZNYS
//
//  Created by yu243e on 16/7/14.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "ZNYSBaseView.h"
#import "CalendarItem+CoreDataProperties.h"

@interface ConnectedResultContentView : ZNYSBaseView

@property(nonatomic, strong) CalendarItem * model;

- (instancetype)initWithModel:(CalendarItem *)model;
@end
