//
//  CalendarViewController.m
//  ZNYS
//
//  Created by yu243e on 16/6/21.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "BrushCalendarViewController.h"
#import "CoreDataHelper.h"
#import "CalendarView.h"
#import "CalendarDetailView.h"
#import "MAKAFakeRootAlertView.h"

@interface BrushCalendarViewController ()

@property (nonatomic, strong) UIButton * dismissButton;

@property (nonatomic, strong) UIImageView * backgroundImageView;

@property (nonatomic,strong) UIImageView * userImageView;

@property (nonatomic,strong) UILabel * userLabel;

@property (nonatomic,strong) UIImageView * coinView;

@property (nonatomic,strong) UILabel * coinLabel;

@property (nonatomic, strong) CalendarView * calendarView;

@property (nonatomic, strong) UILabel *dateLabel;

@property (nonatomic, strong) UILabel *goalLabel;

//@property (nonatomic, strong) CalendarDetailView* calendarDetailView;

- (NSInteger)currentWeekday:(NSDate *)date;
@end

@implementation BrushCalendarViewController

#pragma mark life cycle

- (void)dealloc{
    _dismissButton = nil;
    _backgroundImageView = nil;
    _userImageView = nil;
    _userLabel = nil;
    _coinLabel = nil;
    _coinView = nil;
    _calendarView = nil;
    _dateLabel = nil;
    _goalLabel = nil;
    //_calendarDetailView = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nav.hidden = YES;
    
    [self.view addSubview:self.backgroundImageView];
    [self.view addSubview:self.dismissButton];
    [self.view addSubview:self.userImageView];
    [self.view addSubview:self.userLabel];
    [self.view addSubview:self.coinLabel];
    [self.view addSubview:self.coinView];
    [self.view addSubview:self.calendarView];
    [self.view addSubview:self.dateLabel];
    [self.view addSubview:self.goalLabel];
    
    WS(weakSelf, self);
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).with.offset(0);
        make.right.equalTo(weakSelf.view.mas_right).with.offset(0);
        make.top.equalTo(weakSelf.view.mas_top).with.offset(0);
        make.bottom.equalTo(weakSelf.view.mas_bottom).with.offset(0);
        //make.height.mas_equalTo(CustomHeight(667));

    }];
    
    [self.dismissButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).with.offset(CustomWidth(15));
        make.top.equalTo(weakSelf.view.mas_top).with.offset(CustomHeight(30));
        make.width.mas_equalTo(CustomWidth(50));
        make.height.mas_equalTo(CustomHeight(50));
    }];
    
    [self.userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).with.offset(CustomWidth(125));
        make.top.equalTo(weakSelf.view.mas_top).with.offset(CustomHeight(100));
        make.width.mas_equalTo(CustomWidth(20));
        make.height.mas_equalTo(CustomHeight(20));
    }];
    
    [self.userLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.userImageView.mas_right).with.offset(CustomWidth(2));
        make.centerY.mas_equalTo(weakSelf.userImageView.mas_centerY);
        make.width.mas_equalTo(CustomWidth(50));
        make.height.mas_equalTo(CustomHeight(17));
    }];
    
    [self.coinView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.userLabel.mas_right).with.offset(CustomWidth(2));
        make.centerY.mas_equalTo(weakSelf.userImageView.mas_centerY);
        make.width.mas_equalTo(CustomWidth(20));
        make.height.mas_equalTo(CustomHeight(20));
    }];
    
    [self.coinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.coinView.mas_right).with.offset(CustomWidth(2));
        make.centerY.mas_equalTo(weakSelf.userImageView.mas_centerY);
        make.width.mas_equalTo(CustomWidth(50));
        make.height.mas_equalTo(CustomHeight(17));
    }];
    
    
//    [self.calendarView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(weakSelf.view.mas_top).with.offset(CustomHeight(205));
//        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
//        
//    }];
    
    
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view.mas_top).with.offset(CustomWidth(513));
        make.centerY.mas_equalTo(weakSelf.view.mas_centerY);
        make.width.mas_equalTo(CustomWidth(375));
        make.height.mas_equalTo(CustomHeight(30));
    }];
    
    [self.goalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.view.mas_bottom).with.offset(CustomWidth(-40));
        make.left.equalTo(weakSelf.view.mas_left).with.offset(CustomWidth(170));
        make.width.mas_equalTo(CustomWidth(180));
        make.height.mas_equalTo(CustomHeight(30));
    }];
}
- (void)viewWillAppear:(BOOL)animated {
    
    
    [super viewWillAppear:animated];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"\n\ncalendarView %@\n",NSStringFromCGRect(self.calendarView.frame));
    for (UIImageView *aImage in self.calendarView.dayBackgroundArray) {
        NSLog(@"dayBackgroundArray %ld %@\n",(long)aImage.tag, NSStringFromCGRect(aImage.frame));
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark private met

- (NSInteger)currentWeekday:(NSDate *)date{
    NSCalendar *gregorianCalendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger weekday = [gregorianCalendar component:NSCalendarUnitWeekday fromDate:date];
    NSLog(@"%ld weekday",weekday);
    return weekday;
}

#pragma mark event action

- (void)dismissButtonClicked{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark getters and setters

- (UIButton *)dismissButton{
    if (!_dismissButton) {
        _dismissButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _dismissButton.backgroundColor = [UIColor grayColor];
        [_dismissButton addTarget:self action:@selector(dismissButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dismissButton;
}

- (UIView *)backgroundImageView{
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] init];
        _backgroundImageView.image = [UIImage imageNamed:@"brushCalendarBackground"];
        //_backgroundImageView.backgroundColor = [UIColor blueColor];
    }
    return _backgroundImageView;
}

- (UIImageView *)userImageView{
    if (!_userImageView) {
        _userImageView = [[UIImageView alloc] init];
        _userImageView.backgroundColor = [UIColor purpleColor];
    }
    return _userImageView;
}

- (UIImageView *)coinView{
    if (!_coinView) {
        _coinView = [[UIImageView alloc] init];
        _coinView.backgroundColor = [UIColor purpleColor];
    }
    return _coinView;
}

- (UILabel *)userLabel{
    if (!_userLabel) {
        _userLabel = [[UILabel alloc] initWithCustomFont:15.f];
        _userLabel.text = [User currentUserName];
        _userLabel.textColor = [UIColor blueColor];
        _userLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _userLabel;
}

- (UILabel *)coinLabel{
    if (!_coinLabel) {
        _coinLabel = [[UILabel alloc] initWithCustomFont:15.f];
        _coinLabel.text = [NSString stringWithFormat:@"%@",[User currentUserTokenOwned]];
        _coinLabel.textColor = [UIColor blueColor];
        _coinLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _coinLabel;
}

- (CalendarView *)calendarView {
    if(!_calendarView) {
        //周日到周六 1 - 7
        _calendarView = [[CalendarView alloc] initWithFrame:CGRectMake(CustomWidth(2.5), CustomHeight(190), CustomWidth(370), CustomHeight(280)) firstDay:[self currentWeekday:[NSDate date]]];
        _calendarView.layer.cornerRadius = 8.0f;
        [_calendarView changeTodayBackgroundColor:2];
        
        _calendarView.buttonClickBlock = ^(NSInteger number){
            NSLog(@"tap %ld",(long)number);
            
            CalendarDetailView *calendarDetailView = [[CalendarDetailView alloc] init];
            calendarDetailView.frame = CGRectMake(0, 0, CustomWidth(300), CustomHeight(350));
            
            MAKAFakeRootAlertView * alertView = [[MAKAFakeRootAlertView alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
            
            [alertView setUpView:calendarDetailView];
            calendarDetailView.dismissBlock = ^{
                [alertView dismiss];
            };
            alertView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
            [alertView show];
        };
    }
    
    return _calendarView;
}

- (UILabel *)dateLabel {
    if(!_dateLabel) {
        NSDate *firstDate;
        NSDate *lastDate;
        NSString *firstDateString;
        NSString *lastDateString;
        
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
        [formatter setDateFormat:@"YYYY年MM月dd日"];
        
        //firstDate = 测试日期
        NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
        dateComponents.day = 10;
        dateComponents.month = 6;
        dateComponents.year = 2016;
        NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        firstDate = [gregorianCalendar dateFromComponents:dateComponents];
        
        //firstDay
        firstDateString = [formatter stringFromDate:firstDate];
        
        //lastDay
        lastDate = [[NSDate alloc]initWithTimeInterval:(NSTimeInterval)(21*24*60*60) sinceDate:firstDate];
        lastDateString = [formatter stringFromDate:lastDate];
        
        _dateLabel = [[UILabel alloc]init];
        _dateLabel.text = [[NSString alloc] initWithFormat:@"%@ - %@", firstDateString, lastDateString];
        _dateLabel.textAlignment = NSTextAlignmentCenter;
        
        _dateLabel.textColor = [UIColor whiteColor];
        _dateLabel.backgroundColor = RGBCOLOR(16,180,255);
    }
    return _dateLabel;
}

- (UILabel *)goalLabel {
    if (!_goalLabel) {
        _goalLabel = [[UILabel alloc]init];
        _goalLabel.text = [[NSString alloc]initWithFormat:@"我要在21天消灭蛀牙"];
        
        _dateLabel.textColor = RGBCOLOR(15,112,135);
        _goalLabel.backgroundColor = RGBCOLOR(16,180,255);
        
    }
    return _goalLabel;
}

//- (CalendarDetailView *)calendarDetailView {
//    if (!_calendarDetailView) {
//        _calendarDetailView = [[CalendarDetailView alloc]init];
//    }
//    return _calendarDetailView;
//}
@end
