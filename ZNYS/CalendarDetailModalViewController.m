//
//  CalendarDetailModalViewController.m
//  ZNYS
//
//  Created by yu243e on 16/8/18.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "CalendarDetailModalViewController.h"
#import "CalendarDetailView.h"

@interface CalendarDetailModalViewController ()
@property (nonatomic, strong) CalendarDetailView *calendarDetailView;
@end

@implementation CalendarDetailModalViewController
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureTheme];
    [self.view addSubview:self.calendarDetailView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    CGFloat width = CustomWidth(275);
    CGFloat height = CustomHeight(320);
    CGFloat x = (kSCREEN_WIDTH - width)/2.;
    CGFloat y = (kSCREEN_HEIGHT - height)/2.;
    self.calendarDetailView.frame = CGRectMake(x ,y ,width , height);
}
#pragma mark - private methods
- (void)configureTheme {
    [self.calendarDetailView configureTheme];
}

#pragma mark - getters and setters
- (CalendarDetailView *)calendarDetailView {
    if (!_calendarDetailView) {
        _calendarDetailView = [[CalendarDetailView alloc] init];
        [_calendarDetailView setModels:self.calendarDetailModels];
    }
    return _calendarDetailView;
}
@end
