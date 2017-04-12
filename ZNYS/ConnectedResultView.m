//
//  ConnectedResultView.m
//  ZNYS
//
//  Created by yu243e on 16/7/14.
//  Copyright © 2016年 Woodseen. All rights reserved.
//
#define insertTestData

#import "ConnectedResultView.h"
#import "MAKAFakeRootAlertView.h"
#import "CalendarItemManager.h"
#import "ConnectedResultContentView.h"
#import "UserManager.h"

#define offsetWidth (kSCREEN_WIDTH * 0.8)
@interface ConnectedResultView()

@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) NSMutableArray<ConnectedResultContentView *> * contentViewArray;
@property (nonatomic) NSInteger contentNum;
@property (nonatomic, strong) NSMutableArray<CalendarItem *> * models;

- (void)rightButtonAction;
- (void)leftButtonAction;
- (void)hiddenButton;
- (void)changeReinforcerImageAndLabel;
@end


@implementation ConnectedResultView

#pragma mark life cycle
- (void)dealloc{
    _dismissBlock = nil;
    _scrollView = nil;
    _contentViewArray = nil;
    _models = nil;
    _leftButton = nil;
    _rightButton = nil;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        //蓝色背景
        [self setBackgroundColor:RGBCOLOR(147, 214, 243)];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.backgroundImageView];
        [self addSubview:self.scrollView];
        [self addSubview:self.rightButton];
        [self addSubview:self.leftButton];
        
        WS(weakSelf, self);
        
        [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left).with.offset(CustomWidth(0));
            make.top.equalTo(weakSelf.mas_top).with.offset(CustomHeight(0));
            make.width.mas_equalTo(weakSelf.mas_width);
            make.height.mas_equalTo(weakSelf.mas_height);
        }];
        
        [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakSelf.mas_centerX);
            make.top.equalTo(weakSelf.mas_top).with.offset(CustomHeight(12));
            make.width.mas_equalTo(kSCREEN_WIDTH*0.8);
            make.height.mas_equalTo(kSCREEN_WIDTH*0.8);
        }];
        
        [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.scrollView.mas_right).with.offset(CustomWidth(5));
            make.width.mas_equalTo(CustomWidth(20));
            make.height.mas_equalTo(CustomHeight(30));
            make.centerY.equalTo(weakSelf.scrollView.mas_centerY);
        }];
        
        [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.scrollView.mas_left).with.offset(CustomWidth(-5));
            make.width.mas_equalTo(CustomWidth(20));
            make.height.mas_equalTo(CustomHeight(30));
            make.centerY.equalTo(weakSelf.scrollView.mas_centerY);
        }];
        
        
        //scrollView 内容
        
        self.contentNum = [self.models count];
        self.scrollView.contentSize = CGSizeMake ((offsetWidth * self.contentNum), offsetWidth);
        
        NSInteger offset = offsetWidth;
        for (NSInteger i = 0; i < self.contentNum; i++) {
            [self.contentViewArray[i] setFrame:CGRectMake(i*offset + CustomHeight(1),  CustomHeight(1), offsetWidth-2,  offsetWidth-2)];
            [self.scrollView addSubview:self.contentViewArray[i]];
            //初值
            if (i == 0) {
                self.leftButton.hidden = YES;
            }
        }
        
        [self.scrollView setDelegate:self];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //[self.reinforcerLabel sizeToFit];
}

#pragma mark UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"scrollViewDidEndDecelerating");
    [self hiddenButton];
    [self changeReinforcerImageAndLabel];
}


- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    NSLog(@"scrollViewDidEndScrollingAnimation");
    [self hiddenButton];
    [self changeReinforcerImageAndLabel];
    
}

#pragma mark private method

- (void)hiddenButton {
    self.leftButton.userInteractionEnabled = YES;
    self.rightButton.userInteractionEnabled = YES;
    
    NSInteger offset =  (self.scrollView.contentOffset.x) / (self.scrollView.frame.size.width);
    NSInteger maxOffset = (self.scrollView.contentSize.width) / (self.scrollView.frame.size.width) - 1;
    if (offset == 0) {
        self.leftButton.hidden = YES;
    } else {
        self.leftButton.hidden = NO;
    }
    
    if (offset == maxOffset) {
        self.rightButton.hidden = YES;
    } else {
        self.rightButton.hidden = NO;
    }
}

- (void)changeReinforcerImageAndLabel {
    NSInteger offset =  (self.scrollView.contentOffset.x) / (self.scrollView.frame.size.width);
}
#pragma mark event action

- (void)leftButtonAction {
    CGPoint contentOffset = CGPointMake(self.scrollView.contentOffset.x - self.scrollView.frame.size.width,  0.0);
    [self.scrollView setContentOffset:contentOffset animated:YES];
    self.leftButton.userInteractionEnabled = NO;
}

- (void)rightButtonAction {
    CGPoint contentOffset = CGPointMake(self.scrollView.contentOffset.x + self.scrollView.frame.size.width,  0.0);
    [self.scrollView setContentOffset:contentOffset animated:YES];
    self.rightButton.userInteractionEnabled = NO;
}
#pragma mark getters and setters

- (UIImageView *)backgroundImageView {
    if (!_backgroundImageView) {
        //深的蓝色，暂代图片
        _backgroundImageView = [[UIImageView alloc]init];
        [_backgroundImageView setImage:[UIImage imageWithColor:RGBCOLOR(29,168,237)]];
    }
    return _backgroundImageView;
}


- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        self.scrollView.directionalLockEnabled = YES;
        self.scrollView.pagingEnabled = YES;
        [_scrollView setBackgroundColor:[UIColor clearColor]];
    }
    return _scrollView;
}

- (UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightButton setBackgroundImage:[UIImage imageNamed:@"arrow_head_right"] forState:UIControlStateNormal];
        [_rightButton addTarget:self action:@selector(rightButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}

- (UIButton *)leftButton {
    if (!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftButton setBackgroundImage:[UIImage imageNamed:@"arrow_head_left"] forState:UIControlStateNormal];
        [_leftButton addTarget:self action:@selector(leftButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftButton;
}

- (NSMutableArray<ConnectedResultContentView *> * )contentViewArray {
    if (!_contentViewArray) {
        _contentViewArray = [[NSMutableArray alloc]init];
        for (CalendarItem *calendarItem in self.models) {
            ConnectedResultContentView *view = [[ConnectedResultContentView alloc]initWithModel:calendarItem];
            [_contentViewArray addObject:view];
        }
    }
    return _contentViewArray;
}

- (NSMutableArray<CalendarItem *> *)models {
    if (!_models) {
        _models = [[NSMutableArray alloc] init];
        //NSMutableArray<CalendarItem *> *_models = [CalendarItemManager sharedInstance];
        
#ifdef insertTestData
        /*------------------------插入假数据-----------------------------------*/
        
        
        CalendarItem *calendarItem2 = [[CalendarItemManager sharedInstance] createCalendarItem];
        calendarItem2.connectStarNumber = @1;
        calendarItem2.morningStarNumber = @8;
        calendarItem2.eveningStarNumber = @2;
        calendarItem2.starNumber = @11;
        calendarItem2.userID = [[UserManager sharedInstance] currentUser].uuid;
        calendarItem2.date = @"2016-06-20";
        [_models addObject:calendarItem2];
        
        CalendarItem *calendarItem3 = [[CalendarItemManager sharedInstance] createCalendarItem];
        calendarItem3.connectStarNumber = @1;
        calendarItem3.morningStarNumber = @4;
        calendarItem3.eveningStarNumber = @2;
        calendarItem3.starNumber = @7;
        calendarItem3.userID = [[UserManager sharedInstance] currentUser].uuid;
        calendarItem3.date = @"2016-07-01";
        [_models addObject:calendarItem3];
        
        CalendarItem *calendarItem = [[CalendarItemManager sharedInstance] createCalendarItem];
        calendarItem.connectStarNumber = @0;
        calendarItem.morningStarNumber = @5;
        calendarItem.eveningStarNumber = @4;
        calendarItem.starNumber = @9;
        calendarItem.userID = [[UserManager sharedInstance] currentUser].uuid;
        calendarItem.date = @"2016-07-02";
        [_models addObject:calendarItem];
        
        
#else
        
#endif
    }
    return _models;
}


@end
