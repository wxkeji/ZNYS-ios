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

@protocol CalendarDetailViewDataSource <NSObject>
- (NSUInteger)numberOfItemsInView;
- (UIImage *)itemImageAtIndex:(NSUInteger)index;
- (NSUInteger)numberOfCoinsAtIndex:(NSUInteger)index;
@end

@interface CalendarDetailView : ZNYSBaseView <UIScrollViewDelegate>
@property (nonatomic, weak) id<CalendarDetailViewDataSource> dataSource;
- (void)configureTheme;
@end


