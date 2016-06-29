//
//  CalendarView.h
//  ZNYS
//
//  Created by yu243e on 16/6/22.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "ZNYSBaseView.h"

typedef void(^ButtonClickBlock)(NSInteger number);

@interface CalendarView : ZNYSBaseView

@property (nonatomic,copy) ButtonClickBlock buttonClickBlock;
@property (nonatomic, strong) NSMutableArray <UIButton *> * dayBackgroundArray;


- (void)changeTodayBackgroundColor:(NSInteger) tag;

//周日到周六 1 - 7
- (instancetype)initWithFrame:(CGRect)frame firstDay:(NSInteger)weekDay;
@end
