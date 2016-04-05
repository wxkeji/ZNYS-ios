//
//  ConnectedView.m
//  ZNYS
//
//  Created by 张恒铭 on 12/18/15.
//  Copyright © 2015 Woodseen. All rights reserved.
//

#import "ConnectedView.h"
#import "ToolMacroes.h"
#import "UILabel+Font.h"
#import "UIButton+Font.h"
#import "Masonry.h"
@interface ConnectedView()
@property(nonatomic,strong) UIScrollView* scrollView;
@property(nonatomic,strong) UIImageView*  topBarView;
@property(nonatomic,strong) UILabel*      topBarTextLabel;
@property(nonatomic,strong) UIButton*     returnToHomeButton;
@property(nonatomic,strong) UIImageView*  indicatorPatternView;
@property(nonatomic,strong) UIImageView*  toothPatternView;
@property(nonatomic,strong) UIImageView*  bottomRectangleView;
@property(nonatomic,strong) UIImageView*  bottomToothBrushView;
@property(nonatomic,strong) UILabel*      toothBrushingTimesLabel;
@property(nonatomic,strong) UIImageView*  bottomClockView;
@property(nonatomic,strong) UILabel*      toothBrushingDurationLabel;
@property(nonatomic,strong) UIImageView*  bottomStarView;
@property(nonatomic,strong) UILabel*      numberOfStarsGotLabel;
@property(nonatomic,strong) UIImageView*  backgroundView;
@property(nonatomic,strong) UIButton*     scrollUpButton;
@property(nonatomic,strong) UIButton*     scrollDownButton;
@property(nonatomic,strong) UIButton*     cleanLevelButton;//清洁度
@property(nonatomic,strong) UIButton*     pressureLevelButton;//力度
@property(nonatomic,strong) UIButton*     speedLevelButton;//速度
@property(nonatomic,strong) UIImageView*  toothBrushingResultView;
@property(nonatomic,strong) UILabel*      toothBrushingTimesTextLabel;//今日刷牙*次
@property(nonatomic,strong) UILabel*      toothBrushingTimesContentLabel;//刷牙次数（上面的*内容）
@property(nonatomic,strong) UILabel*      toothBrushingDurationTextLabel;//刷牙时间*
@property(nonatomic,strong) UILabel*      toothBrushingDrationContentLabel;//刷牙时间内容
@property(nonatomic,strong) UILabel*      numbersOfStarsGotTextLabel;//获得星星*颗
@property(nonatomic,strong) UILabel*      numbersOfStarsGotContentLabel;//获得星星数量的内容
@property(nonatomic,strong) UILabel*      toothBrushingPressureTextLabel;//刷牙用力*
@property(nonatomic,strong) UILabel*      toothBrushingPressureContentLabel;//上面*的内容
@property(nonatomic,strong) UILabel*      toothBrushingSpeedTextLabel;//刷牙速度*
@property(nonatomic,strong) UILabel*      toothBrushingSpeedContentLabel;//上面*的内容
@end
@implementation ConnectedView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)init
{
    self = [super initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
    [self addSubview:self.backgroundView];
    [self addSubview:self.topBarView];
    [self addSubview:self.topBarTextLabel];
    [self addSubview:self.returnToHomeButton];
    [self addSubview:self.scrollView];
    return self;
}
#pragma mark - Getters
-(UIScrollView*)scrollView
{
    if(!_scrollView)
    {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.topBarView.frame.size.height, kSCREEN_WIDTH, kSCREEN_HEIGHT-self.topBarView.frame.size.height)];
        _scrollView.contentSize = CGSizeMake(kSCREEN_WIDTH, (kSCREEN_HEIGHT - self.topBarView.frame.size.height)*2);
        [_scrollView setBackgroundColor:[UIColor clearColor]];
        [_scrollView setPagingEnabled:YES];
      //还要modify frame  [_scrollView addSubview:self.indicatorPatternView];
        [_scrollView addSubview:self.cleanLevelButton];
        [_scrollView addSubview:self.speedLevelButton];
        [_scrollView addSubview:self.pressureLevelButton];
        [_scrollView addSubview:self.indicatorPatternView];
        [_scrollView addSubview:self.toothPatternView];
        [_scrollView addSubview:self.scrollUpButton];
        [_scrollView addSubview:self.bottomRectangleView];
        [_scrollView addSubview:self.scrollDownButton];
        [_scrollView addSubview:self.toothBrushingResultView];
    }
    return _scrollView;
}
-(UIImageView*)topBarView
{
    if(!_topBarView)
    {
        _topBarView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TBCTopBar"]];
        [_topBarView setFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_WIDTH*154/750)];
    }
    return _topBarView;
}
-(UILabel*)topBarTextLabel
{
    if(!_topBarTextLabel)
    {
        _topBarTextLabel = [[UILabel alloc] initWithCustomFont:21.0f];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
        [formatter setDateFormat:@"YYYY年MM月DD日"];
        _topBarTextLabel.text =[formatter stringFromDate:[NSDate date]];
        [_topBarTextLabel sizeToFit];
        _topBarTextLabel.textColor = [UIColor whiteColor];
        NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                              [UIFont fontWithName:@"DFPWaWaW5" size:21.0f], NSFontAttributeName,
                                              nil];
        CGRect LabelRect = [_topBarTextLabel.text boundingRectWithSize:CGSizeMake(9999, 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributesDictionary context:nil ];
        [_topBarTextLabel setFrame:CGRectMake((kSCREEN_WIDTH - LabelRect.size.width)/2, CustomHeight(35), LabelRect.size.width, 20)];
    }
    return _topBarTextLabel;
}
-(UIButton*)returnToHomeButton
{
    if (!_returnToHomeButton)
    {
        _returnToHomeButton = [[UIButton alloc] initWithFrame:CGRectMake(CustomWidth(30), CustomHeight(30), CustomWidth(32), CustomHeight(32))];
        [_returnToHomeButton setBackgroundImage:[UIImage imageNamed:@"TBCReturnToHome"] forState:UIControlStateNormal];
        [_returnToHomeButton addTarget:self action:@selector(returnToHome) forControlEvents:UIControlEventTouchUpInside];
    }
    return _returnToHomeButton;
}
-(UIImageView*)backgroundView
{
    if (!_backgroundView)
    {
        _backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TBCBackground"]];
        [_backgroundView setFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
    }
    return _backgroundView;
}
-(UIButton*)cleanLevelButton
{
    if (!_cleanLevelButton)
    {
     //   _cleanLevelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH/3, 60)];
        _cleanLevelButton = [[UIButton alloc] initWithCustomFont:32];
        [_cleanLevelButton setFrame:CGRectMake(0, 0, kSCREEN_WIDTH/3, CustomHeight(60))];
        [_cleanLevelButton setTitle:@"清洁度" forState:UIControlStateNormal];
        [_cleanLevelButton setBackgroundColor:[UIColor colorWithRed:225.0f/255 green:205.0f/255 blue:144.0f/255 alpha:1.0f]];
        
    }
    return _cleanLevelButton;
}
-(UIButton*)pressureLevelButton
{
    if (!_pressureLevelButton)
    {
        //   _cleanLevelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH/3, 60)];
        _pressureLevelButton = [[UIButton alloc] initWithCustomFont:32];
        [_pressureLevelButton setFrame:CGRectMake(kSCREEN_WIDTH/3, 0, kSCREEN_WIDTH/3, CustomHeight(60))];
        [_pressureLevelButton setTitle:@"力度" forState:UIControlStateNormal];
        [_pressureLevelButton setBackgroundColor:[UIColor colorWithRed:241.0f/255 green:160.0f/255 blue:195.0f/255 alpha:1.0f]];
        
    }
    return _pressureLevelButton;
}

-(UIButton*)speedLevelButton
{
    if (!_speedLevelButton)
    {
        _speedLevelButton = [[UIButton alloc] initWithCustomFont:32];
        [_speedLevelButton setFrame:CGRectMake(kSCREEN_WIDTH*2/3,0,kSCREEN_WIDTH/3,CustomHeight(60))];
        [_speedLevelButton setTitle:@"速度" forState:UIControlStateNormal];
        [_speedLevelButton setBackgroundColor:[UIColor colorWithRed:24.0f/255 green:137.0f/255 blue:190.0f/255 alpha:1.0f]];
    }
    return _speedLevelButton;
}
-(UIImageView*)indicatorPatternView
{
    if (!_indicatorPatternView)
    {
        _indicatorPatternView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TBCIndicatorPattern"]];
        [_indicatorPatternView setFrame:CGRectMake((kSCREEN_WIDTH - CustomWidth(145))/2, CustomHeight(107) , CustomWidth(145), CustomHeight(33))];
    }
    return _indicatorPatternView;
}
-(UIImageView*)toothPatternView
{
    if (!_toothPatternView)
    {
        _toothPatternView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TBCToothPattern"]];
        [_toothPatternView setFrame:CGRectMake((kSCREEN_WIDTH - CustomWidth(247))/2, CustomHeight(155), CustomWidth(247),CustomWidth(247))];
    }
    return _toothPatternView;
}

-(UIButton*)scrollUpButton
{
    if (!_scrollUpButton)
    {
        _scrollUpButton = [[UIButton alloc] initWithFrame:CGRectMake((kSCREEN_WIDTH - CustomWidth(29))/2,CustomHeight(438), CustomWidth(29), CustomHeight(31))];
        [_scrollUpButton setBackgroundImage:[UIImage imageNamed:@"TBCScrollUp"] forState:UIControlStateNormal];
        [_scrollUpButton addTarget:self action:@selector(scrollToNextPage) forControlEvents:UIControlEventTouchUpInside];
    }
    return _scrollUpButton;
}
-(UIImageView*)bottomRectangleView
{
    if (!_bottomRectangleView)
    {
        _bottomRectangleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TBCBottomPattern"]];
        [_bottomRectangleView setFrame:CGRectMake((kSCREEN_WIDTH - CustomWidth(327))/2, CustomHeight(475), CustomWidth(327), CustomHeight(91))];
        _bottomRectangleView.clipsToBounds = YES;
        [_bottomRectangleView addSubview:self.bottomToothBrushView];
        [_bottomRectangleView addSubview:self.bottomClockView];
        [_bottomRectangleView addSubview:self.bottomStarView];
        [_bottomRectangleView addSubview:self.toothBrushingTimesLabel];
        [_bottomRectangleView addSubview:self.toothBrushingDurationLabel];
        [_bottomRectangleView addSubview:self.numberOfStarsGotLabel];
    }
    return _bottomRectangleView;
}
-(UIImageView*)bottomToothBrushView
{
    if (!_bottomToothBrushView)
    {
        _bottomToothBrushView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TBCToothBrush"]];
        [_bottomToothBrushView setFrame:CGRectMake(CustomWidth(25), CustomHeight(20), CustomWidth(18), CustomHeight(91))];
    }
    return _bottomToothBrushView;
}
-(UILabel*)toothBrushingTimesLabel
{
    if (!_toothBrushingTimesLabel)
    {
        _toothBrushingTimesLabel = [[UILabel alloc] initWithCustomFont:41.5f];
        [_toothBrushingTimesLabel setFrame:CGRectMake(self.bottomToothBrushView.frame.origin.x + CustomWidth(30), self.bottomToothBrushView.frame.origin.y + CustomHeight(12), CustomWidth(20), CustomHeight(25))];
        [_toothBrushingTimesLabel setText:@"3"];
        [_toothBrushingTimesLabel setTextColor:[UIColor whiteColor]];
        [_toothBrushingTimesLabel sizeToFit];
    }
    return _toothBrushingTimesLabel;
}


-(UIImageView*)bottomClockView
{
    if (!_bottomClockView)
    {
        _bottomClockView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TBCClock"]];
        CGRect bcvFrame = self.bottomToothBrushView.frame;
        bcvFrame.origin.x = self.bottomToothBrushView.frame.origin.x + CustomWidth(75);
        bcvFrame.origin.y = self.bottomToothBrushView.frame.origin.y + CustomHeight(15);
        bcvFrame.size.width = bcvFrame.size.height = 31;
        [_bottomClockView setFrame:bcvFrame];
    }
    return _bottomClockView;
}
-(UILabel*)toothBrushingDurationLabel
{
    if (!_toothBrushingDurationLabel)
    {
         _toothBrushingDurationLabel = [[UILabel alloc] initWithCustomFont:27.0f];
        [_toothBrushingDurationLabel setFrame:CGRectMake(self.bottomClockView.frame.origin.x + CustomWidth(35), self.bottomClockView.frame.origin.y + CustomHeight(6), CustomWidth(75), CustomHeight(25))];
        [_toothBrushingDurationLabel setText: @"08:00"];
        [_toothBrushingDurationLabel setTextColor:[UIColor whiteColor]];
        [_toothBrushingDurationLabel sizeToFit];
    }
    return _toothBrushingDurationLabel;
}
-(UIImageView*)bottomStarView
{
    if (!_bottomStarView)
    {
        _bottomStarView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TBCStar"]];
        CGRect bsvFrame = self.bottomClockView.frame;
        bsvFrame.origin.x = self.bottomClockView.frame.origin.x + CustomWidth(125);
        bsvFrame.size.width = bsvFrame.size.height = 35;
        [_bottomStarView setFrame:bsvFrame];
    }
    return _bottomStarView;
}
-(UILabel*)numberOfStarsGotLabel
{
    if (!_numberOfStarsGotLabel)
    {
        _numberOfStarsGotLabel = [[UILabel alloc] initWithCustomFont:41.5f];
        CGRect nofsglFrame = self.toothBrushingTimesLabel.frame;
        _numberOfStarsGotLabel.text = @"5";
        nofsglFrame.origin.x += CustomWidth(205);
        [_numberOfStarsGotLabel  setFrame:nofsglFrame];
        _numberOfStarsGotLabel.textColor = [UIColor whiteColor];
        [_numberOfStarsGotLabel sizeToFit];
    }
    return _numberOfStarsGotLabel;
}
-(UIButton*)scrollDownButton
{
    if (!_scrollDownButton)
    {
        UIImage* sdbImage = [UIImage imageNamed:@"TBCScrollUp"];
          _scrollDownButton = [[UIButton alloc] initWithFrame:CGRectMake((kSCREEN_WIDTH - 30)/2, kSCREEN_HEIGHT - self.topBarView.frame.size.height + CustomWidth(24), 30, 30)];
        [_scrollDownButton setBackgroundImage:sdbImage forState:UIControlStateNormal];
        _scrollDownButton.transform = CGAffineTransformMakeRotation( M_PI);
        [_scrollDownButton addTarget:self action:@selector(scrollToPreviousPage) forControlEvents:UIControlEventTouchUpInside];
    }
    return _scrollDownButton;
}
-(UIImageView*)toothBrushingResultView
{
    if (!_toothBrushingResultView)
    {
        _toothBrushingResultView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TBCDataAnalysis"]];
        [_toothBrushingResultView setFrame:CGRectMake((kSCREEN_WIDTH - CustomWidth(302))/2, kSCREEN_HEIGHT - self.topBarView.frame.size.height + CustomWidth(75), CustomWidth(302), CustomHeight(457))];
        
        [_toothBrushingResultView addSubview:self.toothBrushingTimesTextLabel];
        [_toothBrushingResultView addSubview:self.toothBrushingDurationTextLabel];
        [_toothBrushingResultView addSubview:self.numbersOfStarsGotTextLabel];
        [_toothBrushingResultView addSubview:self.toothBrushingPressureTextLabel];
        [_toothBrushingResultView addSubview:self.toothBrushingSpeedTextLabel];
        WS(weakSelf, self);
        [self.toothBrushingDurationTextLabel mas_makeConstraints:^(MASConstraintMaker* make){
            make.top.equalTo(weakSelf.toothBrushingTimesTextLabel.mas_bottom).with.offset(CustomHeight(28));
            make.left.equalTo(weakSelf.toothBrushingTimesTextLabel);
        }];
        [self.numbersOfStarsGotTextLabel mas_makeConstraints:^(MASConstraintMaker*make){
            make.top.equalTo(weakSelf.toothBrushingDurationTextLabel.mas_bottom).with.offset(CustomHeight(28));
            make.left.equalTo(weakSelf.toothBrushingTimesTextLabel);
        }];
        [self.toothBrushingPressureTextLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(weakSelf.numbersOfStarsGotTextLabel.mas_bottom).with.offset(CustomHeight(28));
            make.left.equalTo(weakSelf.numbersOfStarsGotTextLabel);
        }];
        [self.toothBrushingSpeedTextLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(weakSelf.toothBrushingPressureTextLabel.mas_bottom).with.offset(CustomHeight(28));
            make.left.equalTo(weakSelf.numbersOfStarsGotTextLabel);
        }];
    }
    return _toothBrushingResultView;
}
-(UILabel*)toothBrushingTimesTextLabel
{
    if (!_toothBrushingTimesTextLabel)
    {
        _toothBrushingTimesTextLabel = [[UILabel alloc] initWithCustomFont:29.83f];
        [_toothBrushingTimesTextLabel setText:@"今日刷牙   次"];
        [_toothBrushingTimesTextLabel setFrame:CGRectMake(CustomWidth(50), CustomHeight(50), CustomWidth(200), CustomHeight(41))];
        [_toothBrushingTimesTextLabel setTextColor:[UIColor colorWithRed:59/255.0 green:156/255.0 blue:194/255.0 alpha:1.0f]];
        [_toothBrushingTimesTextLabel sizeToFit];
    }
    return _toothBrushingTimesTextLabel;
}
-(UILabel*)toothBrushingDurationTextLabel
{
    if (!_toothBrushingDurationTextLabel)
    {
        _toothBrushingDurationTextLabel = [[UILabel alloc] initWithCustomFont:29.83f];
       
        [_toothBrushingDurationTextLabel setText:@"刷牙时间"];
        [_toothBrushingDurationTextLabel sizeToFit];
        [_toothBrushingDurationTextLabel setTextColor:[UIColor colorWithRed:59/255.0 green:156/255.0 blue:194/255.0 alpha:1.0f]];
    }
    return _toothBrushingDurationTextLabel;
}
-(UILabel*)numbersOfStarsGotTextLabel
{
    if (!_numbersOfStarsGotTextLabel)
    {
        _numbersOfStarsGotTextLabel = [[UILabel alloc] initWithCustomFont:29.83f];
        [_numbersOfStarsGotTextLabel  setTextColor:[UIColor colorWithRed:59/255.0 green:156/255.0 blue:194/255.0 alpha:1.0f]];
        _numbersOfStarsGotTextLabel.text = @"获得星星   颗";
        [_numbersOfStarsGotTextLabel sizeToFit];
    }
    return _numbersOfStarsGotTextLabel;
}
-(UILabel*)toothBrushingPressureTextLabel
{
    if (!_toothBrushingPressureTextLabel)
    {
        _toothBrushingPressureTextLabel = [[UILabel alloc] initWithCustomFont:29.83f];
        [_toothBrushingPressureTextLabel setTextColor:[UIColor colorWithRed:59/255.0 green:156/255.0 blue:194/255.0 alpha:1.0f]];
        _toothBrushingPressureTextLabel.text = @"刷牙用力";
    }
    return _toothBrushingPressureTextLabel;
}
-(UILabel*)toothBrushingSpeedTextLabel
{
    if (!_toothBrushingSpeedTextLabel)
    {
        _toothBrushingSpeedTextLabel = [[UILabel alloc] initWithCustomFont:29.83f];
        [_toothBrushingSpeedTextLabel setTextColor:[UIColor colorWithRed:59/255.0 green:156/255.0 blue:194/255.0 alpha:1.0f]];
        _toothBrushingSpeedTextLabel.text = @"刷牙速度";
        [_toothBrushingSpeedTextLabel sizeToFit];
    }
    return _toothBrushingSpeedTextLabel;
}
#pragma mark - Button actions
-(void)returnToHome
{
    [self.delegate returnToHome];
}
-(void)scrollToNextPage
{
  //  [self.delegate scrollToNextPage];
    CGRect frame = self.scrollView.frame;
    frame.origin.y = self.scrollView.contentSize.height/2;//滑动至第2页
    [self.scrollView scrollRectToVisible:frame animated:YES];
}
-(void)scrollToPreviousPage
{
    CGRect frame = self.scrollView.frame;
    frame.origin.y = 0;
    [self.scrollView scrollRectToVisible:frame animated:YES];
}

#pragma mark - Update UI
-(void)setBrushingTimes:(NSUInteger)brushingTime
{
    self.toothBrushingTimesLabel.text =[NSString stringWithFormat:@"%lu",(unsigned long)brushingTime];
}
-(void)setBrushingDuration:(NSUInteger)brushingDuration
{
    self.toothBrushingDurationLabel.text = [NSString stringWithFormat:@"%u:%lu",(unsigned int)brushingDuration/60,brushingDuration%60];
}
-(void)setNumbesOfStarsGot:(NSUInteger)starsGot
{
    self.numberOfStarsGotLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)starsGot];
}
@end
