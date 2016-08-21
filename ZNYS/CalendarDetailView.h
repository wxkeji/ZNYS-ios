//
//  CalendarDetailView.h
//  ZNYS
//
//  Created by yu243e on 16/6/29.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "ZNYSBaseView.h"
@class CalendarDetailModel;
@class CalendarDetailView;

@interface CalendarDetailView : ZNYSBaseView <UIScrollViewDelegate>

- (void)setModels:(NSMutableArray<CalendarDetailModel *> *)models;

@end


