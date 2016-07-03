//
//  CalendarDetailView.h
//  ZNYS
//
//  Created by yu243e on 16/6/29.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "ZNYSBaseView.h"
#import "CalendarItem+CoreDataProperties.h"
#import "CalendarDetailModel.h"

typedef void(^DismissBlock)();

@interface CalendarDetailView : ZNYSBaseView<UIScrollViewDelegate>

@property (nonatomic, copy) DismissBlock dismissBlock;
@property (nonatomic, strong) NSMutableArray<CalendarDetailModel *> * models;

- (instancetype)initWithModel:(NSMutableArray<CalendarDetailModel *> *) models;

@end
