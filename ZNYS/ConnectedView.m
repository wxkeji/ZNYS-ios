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
        //looks good
    }
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
        [_bottomRectangleView addSubview:self.bottomToothBrushView];
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
-(UIButton*)scrollDownButton
{
    if (!_scrollDownButton)
    {
      //  _scrollDownButton = [UIButton alloc] initWithFrame:CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>);
    }
    return _scrollDownButton;
}
#pragma mark - Button actions
-(void)returnToHome
{
    [self.delegate returnToHome];
}
-(void)scrollToNextPage
{
    [self.delegate scrollToNextPage];
}
@end
