//
//  CalendarViewController.m
//  ZNYS
//
//  Created by yu243e on 16/6/21.
//  Copyright © 2016年 Woodseen. All rights reserved.
//
#define insertTestData
#import "CalendarViewController.h"

#import "CoreDataHelper.h"

#import "CalendarDetailModalViewController.h"
#import "CalendarView.h"
#import "CalendarDetailView.h"
#import "UserInformationView.h"

#import "CalendarItemManager.h"

#import "CalendarDetailModel.h"
#import "CalendarModel.h"

@interface CalendarViewController ()

//view
@property (nonatomic, strong) UIButton * dismissButton;

@property (nonatomic, strong) UIImageView *backgroundImageViewTop;
@property (nonatomic, strong) UIImageView *backgroundImageViewDown;
@property (nonatomic, strong) UIImageView *backgroundLogoImageView;

@property (nonatomic, strong) UserInformationView *userInformationView;
@property (nonatomic, strong) CalendarView *calendarView;

@property (nonatomic, strong) UILabel *dateLabel;

@property (nonatomic, strong) UIImageView *goalImageView;
@property (nonatomic, strong) UILabel *goalLabel;

//model
@property (nonatomic, strong) NSMutableArray<CalendarItem *> * calendarItemArray;
@property (nonatomic, strong) NSDate *firstDate;

//transformModel
@property (nonatomic, strong) NSMutableArray<CalendarModel *> * calendarModelArray;
@property (nonatomic, strong) NSMutableArray<NSMutableArray<CalendarDetailModel *>*> * calendarDetailModelsArray;

@end

@implementation CalendarViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nav.hidden = YES;
    
    [self.view addSubview:self.backgroundImageViewTop];
    [self.view addSubview:self.backgroundImageViewDown];
    [self.view addSubview:self.backgroundLogoImageView];
    [self.view addSubview:self.dismissButton];
    [self.view addSubview:self.userInformationView];
    [self.view addSubview:self.calendarView];
    [self.view addSubview:self.dateLabel];
    [self.view addSubview:self.goalImageView];
    [self.view addSubview:self.goalLabel];
    
    [self setupConstraintsForSubviews];
    
    [self.dismissButton addTarget:self action:@selector(dismissButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    WS(weakSelf, self);
    self.calendarView.buttonClickBlock = ^(NSInteger tag){
        if (weakSelf.calendarModelArray[tag].validData == YES) {
            CalendarDetailModalViewController *presentedModalViewController = [[CalendarDetailModalViewController alloc]init];
            presentedModalViewController.calendarDetailModels = weakSelf.calendarDetailModelsArray[tag];
            
            presentedModalViewController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            presentedModalViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            [weakSelf presentViewController:presentedModalViewController animated:YES completion:nil];
        }
    };
}

- (void)setupConstraintsForSubviews {
    WS(weakSelf, self);
    CGFloat logoHeight = CustomHeight(85);
    //logo 不包括突出部分高度
    CGFloat logoBaseHeight = logoHeight*125.62601f/152.f;
    CGFloat navigationAndUserHeight = 20+52+52;
    [self.backgroundImageViewTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left);
        make.right.equalTo(weakSelf.view.mas_right);
        make.top.equalTo(weakSelf.view.mas_top);
        make.bottom.equalTo(weakSelf.view.mas_top).with.offset(navigationAndUserHeight + logoHeight);
    }];
    
    [self.backgroundImageViewDown mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left);
        make.right.equalTo(weakSelf.view.mas_right);
        make.top.equalTo(weakSelf.dateLabel.mas_top);
        make.bottom.equalTo(weakSelf.view.mas_bottom);
        
    }];
    
    [self.backgroundLogoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.backgroundImageViewTop.mas_bottom).offset(logoHeight -logoBaseHeight);
//        make.baseline.equalTo(weakSelf.backgroundImageViewTop.mas_bottom);
//        make.width.mas_equalTo(CustomWidth(233));
        make.height.mas_equalTo(logoHeight);//可能只能放大图缩放使用？
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        
    }];
    [self.dismissButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).with.offset(15);
        make.top.equalTo(weakSelf.view.mas_top).with.offset(28);
        make.width.mas_equalTo(44);
        make.height.mas_equalTo(44);
    }];
    
    [self.userInformationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left);
        make.right.equalTo(weakSelf.view.mas_right);
        make.top.equalTo(weakSelf.view.mas_top).with.offset(80);
    }];
    
    [self.calendarView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.backgroundImageViewTop.mas_bottom).with.offset(ZNYSGetSizeByWidth(-1, 5, 15));
        make.width.mas_equalTo(CustomWidth(370));
        make.height.mas_equalTo(CustomHeight(280));
        make.centerX.equalTo(weakSelf.view.mas_centerX);
    }];

    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view.mas_top).with.offset(CustomWidth(513));
        
        make.width.mas_equalTo(CustomWidth(375));
        make.height.mas_equalTo(CustomHeight(30));
    }];
    
    [self.goalImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.dateLabel.mas_bottom).with.offset(CustomWidth(10));
        make.left.equalTo(weakSelf.view.mas_left).with.offset(CustomWidth(20));
        make.height.mas_equalTo(CustomWidth(100));
        make.width.mas_lessThanOrEqualTo(CustomWidth(350));
    }];
    
    [self.goalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.view.mas_bottom).with.offset(CustomWidth(-35));
        make.left.equalTo(weakSelf.view.mas_left).with.offset(CustomWidth(175));
        make.width.mas_equalTo(CustomWidth(180));
        make.height.mas_equalTo(CustomHeight(30));
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
   
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
//    self.calendarView.frame = CGRectMake(CustomWidth(2.5f), CustomHeight(190), CustomWidth(370), CustomHeight(280));
}

#pragma mark private met
- (CalendarItem *)calendarItemFromArrayWithDate: (NSDate *)date {
    if(!date) {
        return nil;
    }
    NSTimeInterval timeOffset = 24*60*60;
    for(CalendarItem * calendarItem in self.calendarItemArray) {
        NSTimeInterval timeInterval = [[NSDate dateFromString:calendarItem.date] timeIntervalSinceDate:date];
        if (timeInterval >= 0 && timeInterval < timeOffset) {
            return calendarItem;
        }
    }
    return nil;
}

- (NSMutableArray<CalendarDetailModel *> *)transformCalendarItemToDetailModels:(CalendarItem *)calendarItem {
    NSMutableArray<CalendarDetailModel *> * calendarDetailModels = [[NSMutableArray alloc] init];
    
    if (!calendarItem) {
        return  calendarDetailModels;
    }
    if ([calendarItem.morningStarNumber integerValue]> 0) {
        CalendarDetailModel * calendarDetailModel = [[CalendarDetailModel alloc]init];
        calendarDetailModel.pictureURL = [NSString stringWithFormat:@"calendar/reward_dayTime"];
        calendarDetailModel.reinforcerPictureURL = [NSString stringWithFormat:@"calendar/star"];
        calendarDetailModel.reinforcerCount = [calendarItem.morningStarNumber integerValue];
        [calendarDetailModels addObject:calendarDetailModel];
    }
    
    if ([calendarItem.eveningStarNumber integerValue] > 0) {
        CalendarDetailModel * calendarDetailModel = [[CalendarDetailModel alloc]init];
        calendarDetailModel.pictureURL = [NSString stringWithFormat:@"calendar/reward_night"];
        calendarDetailModel.reinforcerPictureURL = [NSString stringWithFormat:@"calendar/star"];
        calendarDetailModel.reinforcerCount = [calendarItem.eveningStarNumber integerValue];
        [calendarDetailModels addObject:calendarDetailModel];
    }
    
    if ([calendarItem.connectStarNumber integerValue] > 0) {
        CalendarDetailModel * calendarDetailModel = [[CalendarDetailModel alloc]init];
        calendarDetailModel.pictureURL = [NSString stringWithFormat:@"calendar/reward_bluetooh"];
        calendarDetailModel.reinforcerPictureURL = [NSString stringWithFormat:@"calendar/star"];
        calendarDetailModel.reinforcerCount = [calendarItem.connectStarNumber integerValue];
        [calendarDetailModels addObject:calendarDetailModel];
    }
    
    return calendarDetailModels;
}
#pragma mark event action

- (void)dismissButtonClicked{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark getters and setters

- (UIButton *)dismissButton{
    if (!_dismissButton) {
        _dismissButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_dismissButton setImage:[UIImage imageNamed:@"navigation/homeButton"] forState:UIControlStateNormal];
    }
    return _dismissButton;
}

- (UIView *)backgroundImageViewTop{
    if (!_backgroundImageViewTop) {
        _backgroundImageViewTop = [[UIImageView alloc] init];
        _backgroundImageViewTop.image = [UIImage imageWithColor:RGBCOLOR(139, 213, 245)];
        //_backgroundImageViewTop.backgroundColor = [UIColor blueColor];
    }
    return _backgroundImageViewTop;
}

- (UIView *)backgroundLogoImageView{
    if (!_backgroundLogoImageView) {
        _backgroundLogoImageView = [[UIImageView alloc] init];
        _backgroundLogoImageView.image = [UIImage imageNamed:@"children/logo_boy"];
        _backgroundLogoImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _backgroundLogoImageView;
}

- (UIView *)backgroundImageViewDown{
    if (!_backgroundImageViewDown) {
        _backgroundImageViewDown = [[UIImageView alloc] init];
        _backgroundImageViewDown.image = [UIImage imageWithColor:RGBCOLOR(139, 213, 245)];
        //_backgroundImageViewDown.backgroundColor = [UIColor blueColor];
    }
    return _backgroundImageViewDown;
}

- (UserInformationView *)userInformationView {
    if (!_userInformationView) {
        _userInformationView = [[UserInformationView alloc]init];
    }
    return _userInformationView;
}

- (CalendarView *)calendarView {
    if(!_calendarView) {
        //周日到周六 1 - 7
        _calendarView = [[CalendarView alloc] init];
        
        [_calendarView setFirstDayWeek:[NSDate  currentWeek:self.firstDate]];
        [_calendarView setModels:self.calendarModelArray];
        NSInteger dayOffset = ([[NSDate date] timeIntervalSinceDate:self.firstDate]) / (60*24*60);
        [_calendarView changeTodayButtonColor:(dayOffset)];
    }
    
    return _calendarView;
}

- (UILabel *)dateLabel {
    if(!_dateLabel) {
        NSDate *lastDate;
        NSString *firstDateString;
        NSString *lastDateString;
        
        //firstDay
        firstDateString = [NSDate stringFromDate:self.firstDate withFormat:@"yyyy年 MM月dd日"];
        
        //lastDay
        lastDate = [[NSDate alloc]initWithTimeInterval:(NSTimeInterval)(20*24*60*60) sinceDate:self.firstDate];
        lastDateString = [NSDate stringFromDate:lastDate withFormat:@"MM月dd日"];
        
        _dateLabel = [[UILabel alloc]init];
        _dateLabel.text = [[NSString alloc] initWithFormat:@"%@ - %@", firstDateString, lastDateString];
        _dateLabel.textAlignment = NSTextAlignmentCenter;
        
        _dateLabel.textColor = [UIColor whiteColor];
        _dateLabel.backgroundColor = RGBCOLOR(16,180,255);
    }
    return _dateLabel;
}

- (UIView *)goalImageView{
    if (!_goalImageView) {
        _goalImageView = [[UIImageView alloc] init];
        _goalImageView.image = [UIImage imageNamed:@"calendar/goal_boy"];
        _goalImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _goalImageView;
}

- (UILabel *)goalLabel {
    if (!_goalLabel) {
        _goalLabel = [[UILabel alloc]init];
        _goalLabel.text = [[NSString alloc]initWithFormat:@"我要在21天消灭蛀牙"];
        
        _goalLabel.textColor = RGBCOLOR(15,112,135);
        _goalLabel.backgroundColor = RGBCOLOR(16,180,255);
        
    }
    return _goalLabel;
}


//当前周期第一天
- (NSDate *)firstDate {
    if (!_firstDate) {
        //firstDate = 测试日期
        
        _firstDate = [NSDate beginningOfDay:[NSDate dateFromString:@"2016-06-24"]];
        
        //2016-06-24
//        NSLog(@"firstDate %@", _firstDate);
//        NSLog(@"dateFromString %@", [NSDate stringFromDate:[NSDate dateFromString:@"2016-10-06"]]);
//        NSLog(@"first %@", [_firstDate descriptionWithLocale:[NSLocale currentLocale]]);
//        NSLog(@"first today %@", [NSDate stringFromDate:[NSDate beginningOfDay:_firstDate]]);
    }
    return _firstDate;
}

- (NSMutableArray<CalendarItem *> *)calendarItemArray{
    if (!_calendarItemArray) {
        _calendarItemArray = [[NSMutableArray alloc] init];
        //NSMutableArray<CalendarItem *> *_calendarItemArray = [CalendarItemManager sharedInstance];
        
#ifdef insertTestData
        /*------------------------插入假数据-----------------------------------*/
        CalendarItem *calendarItem = [[CalendarItemManager sharedInstance] createCalendarItem];
        calendarItem.connectStarNumber = @0;
        calendarItem.morningStarNumber = @5;
        calendarItem.eveningStarNumber = @4;
        calendarItem.starNumber = @9;
        calendarItem.userID = [User currentUserUUID];
        calendarItem.date = @"2016-07-02";
        [_calendarItemArray addObject:calendarItem];
        
        CalendarItem *calendarItem2 = [[CalendarItemManager sharedInstance] createCalendarItem];
        calendarItem2.connectStarNumber = @1;
        calendarItem2.morningStarNumber = @8;
        calendarItem2.eveningStarNumber = @2;
        calendarItem2.starNumber = @11;
        calendarItem2.userID = [User currentUserUUID];
        calendarItem2.date = @"2016-06-20";
        [_calendarItemArray addObject:calendarItem2];
        
        CalendarItem *calendarItem3 = [[CalendarItemManager sharedInstance] createCalendarItem];
        calendarItem3.connectStarNumber = @1;
        calendarItem3.morningStarNumber = @4;
        calendarItem3.eveningStarNumber = @2;
        calendarItem3.starNumber = @7;
        calendarItem3.userID = [User currentUserUUID];
        calendarItem3.date = @"2016-07-01";
        [_calendarItemArray addObject:calendarItem3];
        
        CalendarItem *calendarItem4 = [[CalendarItemManager sharedInstance] createCalendarItem];
        calendarItem4.connectStarNumber = @1;
        calendarItem4.morningStarNumber = @4;
        calendarItem4.eveningStarNumber = @2;
        calendarItem4.starNumber = @7;
        calendarItem4.userID = [User currentUserUUID];
        calendarItem4.date = @"2016-07-04";
        [_calendarItemArray addObject:calendarItem4];
        
        CalendarItem *calendarItem5 = [[CalendarItemManager sharedInstance] createCalendarItem];
        calendarItem5.connectStarNumber = @1;
        calendarItem5.morningStarNumber = @4;
        calendarItem5.eveningStarNumber = @2;
        calendarItem5.starNumber = @7;
        calendarItem5.userID = [User currentUserUUID];
        calendarItem5.date = @"2016-07-05";
        
        [_calendarItemArray addObject:calendarItem5];
        
#else
        _calendarItemArray = [[CalendarItemManager sharedInstance] getCalendarItemsByUserID:[User currentUserUUID]];
#endif
    }
    return _calendarItemArray;
}

- (NSMutableArray<CalendarModel *> *)calendarModelArray {
    if (!_calendarModelArray) {
        _calendarModelArray = [[NSMutableArray alloc]initWithCapacity:21];
        
        NSTimeInterval timeOffset = 24*60*60;
        NSDate * date;
        
        for (NSInteger i = 0; i < 21; i++) {
            date = [NSDate dateWithTimeInterval:(timeOffset*i) sinceDate:self.firstDate];
            CalendarModel *model = [[CalendarModel alloc]init];
            model.date = date;
            model.tag = i;
            
            BOOL find = NO;
            for(CalendarItem * calendarItem in self.calendarItemArray) {
                NSTimeInterval timeInterval = [[NSDate dateFromString:calendarItem.date] timeIntervalSinceDate:date];
                if (timeInterval >= 0 && timeInterval < timeOffset) {
                    model.starNum = [calendarItem.starNumber integerValue];
                    model.validData = YES;
                    find = YES;
                    break;
                }
            }
            if (find == NO) {
                CalendarModel *model = [[CalendarModel alloc]init];
                model.starNum = 0;
                model.validData = NO;
            }
            if ([[NSDate nextDay:[NSDate date]] timeIntervalSinceDate:date] <= 0) {
                model.future = YES;
            } else {
                model.future = NO;
            }
            [self.calendarModelArray addObject:model];
        }
        
        
    }
    return _calendarModelArray;
}

- (NSMutableArray<NSMutableArray<CalendarDetailModel *>*> *)calendarDetailModelsArray {
    if (!_calendarDetailModelsArray) {
        _calendarDetailModelsArray = [[NSMutableArray alloc]initWithCapacity:21];
        for (NSInteger i = 0 ; i < 21; i++) {
            NSMutableArray *modelArray = [self transformCalendarItemToDetailModels:[self calendarItemFromArrayWithDate:self.calendarModelArray[i].date]];
            [_calendarDetailModelsArray addObject:modelArray];
        }
    }
    return _calendarDetailModelsArray;
}
@end
