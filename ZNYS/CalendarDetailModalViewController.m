//
//  CalendarDetailModalViewController.m
//  ZNYS
//
//  Created by yu243e on 16/8/18.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "CalendarDetailModalViewController.h"
#import "CalendarDetailView.h"

@interface CalendarDetailModalViewController () <CalendarDetailViewDataSource>
@property (nonatomic, strong) CalendarDetailView *calendarDetailView;
@end

@implementation CalendarDetailModalViewController
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    
    [self configureTheme];
    [self updatePreferredContentSize];  //更新UIViewConroller.view的 size
    
    [self.view addSubview:self.calendarDetailView];
}
- (void)updatePreferredContentSize {
    self.preferredContentSize = CGSizeMake(CustomWidth(275), CustomHeight(320));
}

- (void)viewDidLayoutSubviews {
    self.calendarDetailView.frame = self.view.bounds;
}
#pragma mark - CalendarDetailViewDataSource
//+++ 需要连接数据
- (NSUInteger)numberOfItemsInView {
    return 2;
}

- (NSUInteger)numberOfCoinsAtIndex:(NSUInteger)index {
    return index + 3;
}

- (UIImage *)itemImageAtIndex:(NSUInteger)index {
    UIImage *temp = [UIImage imageNamed:@"calendar/reward_dayTime"];
    return temp;
}

#pragma mark - private methods
- (void)configureTheme {
    [self.calendarDetailView configureTheme];
}

#pragma mark - getters and setters
- (CalendarDetailView *)calendarDetailView {
    if (!_calendarDetailView) {
        _calendarDetailView = [[CalendarDetailView alloc] init];
        _calendarDetailView.dataSource = self;
    }
    return _calendarDetailView;
}
@end
