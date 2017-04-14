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
@property (nonatomic, strong) NSMutableArray *calendarRecord;
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
- (NSUInteger)numberOfItemsInView {
    return self.calendarRecord.count;
}

- (NSUInteger)numberOfCoinsAtIndex:(NSUInteger)index {
    NSInteger number;
    switch ([self.calendarRecord[index] integerValue]) {
        case 1:
            number = self.calendarModel.morningStarNumber;
            break;
        case 2:
            number = self.calendarModel.eveningStarNumber;
            break;
        case 3:
            number = self.calendarModel.connectStarNumber;
        default:
            break;
    }
    return number;
}

- (UIImage *)itemImageAtIndex:(NSUInteger)index {
    UIImage *image = [UIImage imageNamed:@"calendar/reward_dayTime"];
    switch ([self.calendarRecord[index] integerValue]) {
        case 1:
            image = [UIImage imageNamed:@"calendar/reward_dayTime"];
            break;
        case 2:
            image = [UIImage imageNamed:@"calendar/reward_night"];
            break;
        case 3:
            image = [UIImage imageNamed:@"calendar/reward_bluetooth"];
            break;
        default:
            break;
    }
    return image;
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
- (NSMutableArray *)calendarRecord {
    if (!_calendarRecord) {
        _calendarRecord = [[NSMutableArray alloc] init];
        if (self.calendarModel.morningStarNumber != 0) {
            [_calendarRecord addObject:@1];
        }
        if (self.calendarModel.eveningStarNumber != 0) {
            [_calendarRecord addObject:@2];
        }
        if (self.calendarModel.connectStarNumber != 0) {
            [_calendarRecord addObject:@3];
        }
    }
    return _calendarRecord;
}
@end
