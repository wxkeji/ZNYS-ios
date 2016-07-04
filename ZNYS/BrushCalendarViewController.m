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
#import "CalendarItemManager.h"
#import "CalendarItem+CoreDataProperties.h"
#import "CalendarDetailModel.h"
#import "CalendarModel.h"

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



@property (nonatomic, strong) NSMutableArray<CalendarItem *> * calendarItemArray;

@property (nonatomic, strong) NSMutableArray<CalendarModel *> * calendarModelArray;


@property (nonatomic, strong) NSDate *firstDate;

- (CalendarItem *)calendarItemFromArrayWithDate: (NSDate *)date ;
- (NSMutableArray<CalendarDetailModel *> *)transformCalendarItemToDetailModels:(CalendarItem *)calendarItem;

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
    _calendarItemArray = nil;
    _calendarModelArray = nil;
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
    
    
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view.mas_top).with.offset(CustomWidth(513));
        
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
//    NSLog(@"\n\ncalendarView %@\n",NSStringFromCGRect(self.calendarView.frame));
//    for (UIImageView *aImage in self.calendarView.dayButtonArray) {
//        NSLog(@"dayButtonArray %ld %@\n",(long)aImage.tag, NSStringFromCGRect(aImage.frame));
//    }
//    for (CalendarModel *model in self.calendarModelArray) {
//        NSLog(@"%@",model);
//    }
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark private met
- (CalendarItem *)calendarItemFromArrayWithDate: (NSDate *)date {
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
    if (!calendarItem) {
        return nil;
    }
    NSMutableArray<CalendarDetailModel *> * calendarDetailModels = [[NSMutableArray alloc] init];
    
    if ([calendarItem.morningStarNumber integerValue]> 0) {
        CalendarDetailModel * calendarDetailModel = [[CalendarDetailModel alloc]init];
        calendarDetailModel.pictureURL = [NSString stringWithFormat:@"dayTimeReward"];
        calendarDetailModel.reinforcerPictureURL = [NSString stringWithFormat:@"star"];
        calendarDetailModel.reinforcerCount = [calendarItem.morningStarNumber integerValue];
        [calendarDetailModels addObject:calendarDetailModel];
    }
    
    if ([calendarItem.eveningStarNumber integerValue] > 0) {
        CalendarDetailModel * calendarDetailModel = [[CalendarDetailModel alloc]init];
        calendarDetailModel.pictureURL = [NSString stringWithFormat:@"nightReward"];
        calendarDetailModel.reinforcerPictureURL = [NSString stringWithFormat:@"star"];
        calendarDetailModel.reinforcerCount = [calendarItem.eveningStarNumber integerValue];
        [calendarDetailModels addObject:calendarDetailModel];
    }
    
    if ([calendarItem.connectStarNumber integerValue] > 0) {
        CalendarDetailModel * calendarDetailModel = [[CalendarDetailModel alloc]init];
        calendarDetailModel.pictureURL = [NSString stringWithFormat:@"bluetoothReward"];
        calendarDetailModel.reinforcerPictureURL = [NSString stringWithFormat:@"star"];
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
        _calendarView = [[CalendarView alloc] initWithFrame:CGRectMake(CustomWidth(2.5), CustomHeight(190), CustomWidth(370), CustomHeight(280)) firstDay:[NSDate  currentWeek:self.firstDate]];
        _calendarView.layer.cornerRadius = 8.0f;
        [_calendarView setModels:self.calendarModelArray];
        NSInteger dayOffset = ([[NSDate date] timeIntervalSinceDate:self.firstDate]) / (60*24*60);
        [_calendarView changeTodayButtonColor:(dayOffset)];
        
        
         WS(weakSelf, self);
        _calendarView.buttonClickBlock = ^(NSInteger tag){
#           ifdef debug
            NSLog(@"tap %ld",(long)tag);
#           endif
            
            if (weakSelf.calendarModelArray[tag].validData == YES) {
                CalendarDetailView *calendarDetailView = [[CalendarDetailView alloc] initWithModel:[weakSelf transformCalendarItemToDetailModels:[weakSelf calendarItemFromArrayWithDate:weakSelf.calendarModelArray[tag].date]]];
                calendarDetailView.frame = CGRectMake(0, 0, CustomWidth(275), CustomHeight(330));
                MAKAFakeRootAlertView * alertView = [[MAKAFakeRootAlertView alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
                
                [alertView setUpView:calendarDetailView];
                calendarDetailView.dismissBlock = ^{
                    [alertView dismiss];
                };
                alertView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
                [alertView show];
            }
        };
    }
    
    return _calendarView;
}

- (UILabel *)dateLabel {
    if(!_dateLabel) {
        NSDate *lastDate;
        NSString *firstDateString;
        NSString *lastDateString;
        
        
        
        //firstDay
        firstDateString = [NSDate stringFromDate:self.firstDate withFormat:@"yyyy年MM月dd日"];
        
        //lastDay
        lastDate = [[NSDate alloc]initWithTimeInterval:(NSTimeInterval)(20*24*60*60) sinceDate:self.firstDate];
        lastDateString = [NSDate stringFromDate:lastDate withFormat:@"yyyy年MM月dd日"];
        
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
        _calendarModelArray = [[NSMutableArray alloc]init];
        
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

//当前周期第一天
- (NSDate *)firstDate {
    if (!_firstDate) {
        //firstDate = 测试日期
        
        _firstDate = [NSDate beginningOfDay:[NSDate dateFromString:@"2016-06-24"]];
        
//        NSLog(@"firstDate %@", _firstDate);
//        NSLog(@"dateFromString %@", [NSDate stringFromDate:[NSDate dateFromString:@"2016-10-06"]]);
//        NSLog(@"first %@", [_firstDate descriptionWithLocale:[NSLocale currentLocale]]);
//        NSLog(@"first today %@", [NSDate stringFromDate:[NSDate beginningOfDay:_firstDate]]);
    }
    return _firstDate;
}
//- (CalendarDetailView *)calendarDetailView {
//    if (!_calendarDetailView) {
//        _calendarDetailView = [[CalendarDetailView alloc]init];
//    }
//    return _calendarDetailView;
//}
@end
