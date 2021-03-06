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

#import "ModalPresentationController.h"

#import "CalendarDetailModalViewController.h"
#import "CalendarView.h"
#import "CalendarDetailView.h"
#import "UserInformationView.h"

#import "CalendarItemManager.h"

#import "CalendarModel.h"

#import "UserManager.h"

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
@property (nonatomic, strong) NSSet<CalendarItem *> * calendarItemSet;
@property (nonatomic, strong) NSDate *firstDate;

//transformModel
@property (nonatomic, strong) NSMutableArray<CalendarModel *> * calendarModelArray;

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
    
//    [[ThemeManager sharedManager] configureTheme:ZNYSThemeStyleBlue];
    [self configureTheme];
    [self setupConstraintsForSubviews];
    
    [self.dismissButton addTarget:self action:@selector(dismissButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    WS(weakSelf, self);
    self.calendarView.buttonClickBlock = ^(NSInteger tag){
        [weakSelf configureTheme];
        
        if (weakSelf.calendarModelArray[tag].validData == YES) {
            CalendarDetailModalViewController * modalViewController = [[CalendarDetailModalViewController alloc] init];
            modalViewController.calendarModel = weakSelf.calendarModelArray[tag];
            
            //因为没有被强持有，必须用NS_VALID_UNTIL_END_OF_SCOPE 保持其存在
            //参考 APPLE Custom View Controller Presentations and Transitions
            ModalPresentationController *presentationController NS_VALID_UNTIL_END_OF_SCOPE;
            presentationController = [[ModalPresentationController alloc] initWithPresentedViewController:modalViewController presentingViewController:self];
            [presentationController setModalStyle:CHYCModalPresentationStyleCenter];
            
            modalViewController.transitioningDelegate = presentationController;
            modalViewController.modalPresentationStyle = UIModalPresentationCustom;
            [weakSelf presentViewController:modalViewController animated:YES completion:nil];
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
        make.left.equalTo(weakSelf.view.mas_left).with.offset(MIN_EDGE_X);
        make.top.equalTo(weakSelf.view.mas_top).with.offset(NAVIGATION_BUTTON_Y);
        make.width.mas_equalTo(MIN_BUTTON_H_W);
        make.height.mas_equalTo(MIN_BUTTON_H_W);
    }];
    
    [self.userInformationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left);
        make.right.equalTo(weakSelf.view.mas_right);
        make.top.equalTo(weakSelf.view.mas_top).with.offset(USER_INFORMATIN_Y);
    }];
    
    [self.calendarView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.backgroundImageViewTop.mas_bottom).with.offset(ZNYSGetSizeByWidth(-3, 5, MIN_EDGE_X));
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
        make.left.equalTo(weakSelf.view.mas_left).with.offset(CustomWidth(16));
        make.height.mas_equalTo(CustomWidth(100));
        make.width.mas_equalTo(CustomWidth(350));
    }];
    
    [self.goalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.goalImageView.mas_top).with.offset(CustomWidth(52));
        make.left.equalTo(weakSelf.view.mas_left).with.offset(CustomWidth(134));
        make.width.mas_equalTo(CustomWidth(220));
        make.height.mas_equalTo(CustomHeight(30));
    }];
}

#pragma mark private method
- (void)configureTheme {
    self.backgroundImageViewTop.image = [UIImage themedImageWithNamed:@"color/primary"];
    self.backgroundImageViewDown.image = [UIImage themedImageWithNamed:@"color/primary"];
    self.backgroundLogoImageView.image = [UIImage themedImageWithNamed:@"logo"];
    
    [self.dismissButton setImage:[UIImage themedImageWithNamed:@"navigation/homeButton"] forState:UIControlStateNormal];
    
    self.dateLabel.backgroundColor = [UIColor colorWithThemedImageNamed:@"color/primary_dark"];
    [self.calendarView configureTheme];
    self.goalImageView.image = [UIImage themedImageWithNamed:@"calendar/goal"];
    
    self.goalLabel.textColor = [UIColor colorWithThemedImageNamed:@"color/primary_dark"];
}

#pragma mark event action
- (void)dismissButtonClicked{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark getters and setters
- (UIButton *)dismissButton{
    if (!_dismissButton) {
        _dismissButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _dismissButton;
}

- (UIView *)backgroundImageViewTop{
    if (!_backgroundImageViewTop) {
        _backgroundImageViewTop = [[UIImageView alloc] init];
        _backgroundImageViewTop.contentMode = UIViewContentModeScaleToFill;
    }
    return _backgroundImageViewTop;
}

- (UIView *)backgroundLogoImageView{
    if (!_backgroundLogoImageView) {
        _backgroundLogoImageView = [[UIImageView alloc] init];
        _backgroundLogoImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _backgroundLogoImageView;
}

- (UIView *)backgroundImageViewDown{
    if (!_backgroundImageViewDown) {
        _backgroundImageViewDown = [[UIImageView alloc] init];
        _backgroundImageViewDown.contentMode = UIViewContentModeScaleToFill;
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
        
        [_calendarView configureFirstDayWeek:[NSDate  currentWeek:self.firstDate]];
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
    }
    return _dateLabel;
}

- (UIView *)goalImageView{
    if (!_goalImageView) {
        _goalImageView = [[UIImageView alloc] init];
        _goalImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _goalImageView;
}

- (UILabel *)goalLabel {
    if (!_goalLabel) {
        _goalLabel = [[UILabel alloc]init];
        [_goalLabel setFont:[UIFont fontWithName:kCustomFont size:kAutoFontSize]];
        _goalLabel.text = [[NSString alloc]initWithFormat:@"我要在21天消灭蛀牙"];
        _goalLabel.adjustsFontSizeToFitWidth = YES;
        _goalLabel.textAlignment = NSTextAlignmentLeft;
        
    }
    return _goalLabel;
}


//当前周期第一天
- (NSDate *)firstDate {
    if (!_firstDate) {
        //firstDate = 测试日期
        
        _firstDate = [NSDate beginningOfDay:[NSDate dateFromString:@"2016年6月24日"]];
        
    }
    return _firstDate;
}

- (NSSet<CalendarItem *> *)calendarItemSet{
    if (!_calendarItemSet) {
#ifdef insertTestData
        /*------------------------插入假数据-----------------------------------*/
        CalendarItem *calendarItem = [CalendarItemManager  createCalendarItem];
        calendarItem.connectStarNumber = 0;
        calendarItem.morningStarNumber = 5;
        calendarItem.eveningStarNumber = 4;
        calendarItem.starNumber = 9;
        calendarItem.date = @"2016年7月2日";
        calendarItem.user = [[UserManager sharedInstance] currentUser];
        
        CalendarItem *calendarItem2 = [CalendarItemManager createCalendarItem];
        calendarItem2.connectStarNumber = 1;
        calendarItem2.morningStarNumber = 8;
        calendarItem2.eveningStarNumber = 2;
        calendarItem2.starNumber = 11;
        calendarItem2.date = @"2016年6月12日";
        calendarItem2.user = [[UserManager sharedInstance] currentUser];

        CalendarItem *calendarItem3 = [CalendarItemManager createCalendarItem];
        calendarItem3.connectStarNumber = 1;
        calendarItem3.morningStarNumber = 4;
        calendarItem3.eveningStarNumber = 2;
        calendarItem3.starNumber = 7;
        calendarItem3.date = @"2016年7月1日";
        calendarItem3.user = [[UserManager sharedInstance] currentUser];
        
        CalendarItem *calendarItem4 = [CalendarItemManager createCalendarItem];
        calendarItem4.connectStarNumber = 1;
        calendarItem4.morningStarNumber = 4;
        calendarItem4.eveningStarNumber = 2;
        calendarItem4.starNumber = 7;
        calendarItem4.date = @"2016年7月4日";
        calendarItem4.user = [[UserManager sharedInstance] currentUser];
        
        CalendarItem *calendarItem5 = [CalendarItemManager createCalendarItem];
        calendarItem5.connectStarNumber = 1;
        calendarItem5.morningStarNumber = 4;
        calendarItem5.eveningStarNumber = 2;
        calendarItem5.starNumber = 7;
        calendarItem5.date = @"2016年7月5日";
        calendarItem5.user = [[UserManager sharedInstance] currentUser];
        
        [[CoreDataHelper sharedInstance] save];
        
        _calendarItemSet = [[UserManager sharedInstance] currentUser].calenderItems;
#else
        _calendarItemSet = [[UserManager sharedInstance] currentUser].calenderItems;
#endif
    }
    return _calendarItemSet;
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
            for(CalendarItem * calendarItem in self.calendarItemSet) {
                NSTimeInterval timeInterval = [[NSDate dateFromString:calendarItem.date] timeIntervalSinceDate:date];
                if (timeInterval >= 0 && timeInterval < timeOffset) {
                    model.starNumber = calendarItem.starNumber;
                    model.morningStarNumber = calendarItem.morningStarNumber;
                    model.eveningStarNumber = calendarItem.eveningStarNumber;
                    model.connectStarNumber = calendarItem.connectStarNumber;
                    model.validData = YES;
                    find = YES;
                    break;
                }
            }
            if (find == NO) {
                CalendarModel *model = [[CalendarModel alloc]init];
                model.starNumber = 0;
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
@end
