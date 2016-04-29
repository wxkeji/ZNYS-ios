//
//  ConnectingView.m
//  ZNYS
//
//  Created by 张恒铭 on 12/18/15.
//  Copyright © 2015 Woodseen. All rights reserved.
//

#import "ConnectingView.h"
#import "ConnectedView.h"
#import <Masonry.h>
#import "ToolMacroes.h"
#import "CustomProgressBar.h"
@interface ConnectingView()
@property(strong,nonatomic)UIButton*     returnButton;
@property(strong,nonatomic)UIImageView*  backgroundView;
@property(strong,nonatomic)UIImageView*  topBarView;
@property(strong,nonatomic)UIView*       transparentView;
@property(strong,nonatomic)CustomProgressBar* progressView;
@property(strong,nonatomic)UIImageView*  bottomPattern;
@property(strong,nonatomic)UIImageView*  progressViewInside;


@property(nonatomic,strong) UIImageView* indicatorView;
@property(nonatomic,strong) UILabel*     indicatorLabel;
@end

@implementation ConnectingView

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
    if (self)
    {
        [self addSubview:self.backgroundView];
        [self addSubview:self.topBarView];
        [self addSubview:self.returnButton];
        [self addSubview:self.bottomPattern];
        [self addSubview:self.progressView];
        [self addSubview:self.indicatorView];
        
        WS(weakSelf, self);

        [self.indicatorLabel mas_makeConstraints:^(MASConstraintMaker* make){
            make.centerX.equalTo(weakSelf.indicatorView.mas_centerX);
            make.top.equalTo(weakSelf.indicatorView.mas_top).with.offset(5);
        }];
        
        [self.indicatorView mas_makeConstraints:^(MASConstraintMaker*make){
            make.bottom.equalTo(weakSelf.progressView.mas_top).with.offset(9);
            make.width.equalTo(@51);
            make.height.equalTo(@48);
            make.centerX.equalTo(weakSelf.progressView.mas_left).with.offset(9 + weakSelf.progressView.progress * (CustomWidth(321) - 18) );
        }];
        
    }
    return self;
}

- (void)setProgress:(float)progress
{

    [UIView animateWithDuration:0.0 animations:^{
       // [self.indicatorView setFrame:CGRectMake(self.indicatorView.frame.origin.x + progress * (CGRectGetWidth(self.progressView.frame) - 18), CGRectGetMinY(self.indicatorView.frame), CGRectGetWidth(self.indicatorView.frame),CGRectGetHeight(self.indicatorView.frame))];
        [self.indicatorView setFrame:CGRectMake(self.progressView.frame.origin.x + 9 + progress * (CGRectGetWidth(self.progressView.frame) - 18), CGRectGetMinY(self.indicatorView.frame), CGRectGetWidth(self.indicatorView.frame),CGRectGetHeight(self.indicatorView.frame))];
    }];
        [self.progressView updateProgress:progress];
}

#pragma mark - button actions
-(void)returnToHome
{
    [self.delegate returnToHome];
}
#pragma mark - getter and setters
-(UIButton*)returnButton
{
    if(!_returnButton)
    {
        _returnButton   = [UIButton buttonWithType:UIButtonTypeCustom];
        [_returnButton setBackgroundImage:[UIImage imageNamed:@"BCTopBarReturnButton"] forState:UIControlStateNormal];
        [_returnButton sizeToFit];
        [_returnButton setFrame:CGRectMake(25,kSCREEN_WIDTH*154/750-CustomHeight(42),30,30)];
          [_returnButton addTarget:self action:@selector(returnToHome) forControlEvents:UIControlEventTouchUpInside];
    }
    return _returnButton;
}
-(UIImageView*)backgroundView
{
    if(!_backgroundView)
    {
        _backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BCBackground"]];
        [_backgroundView setFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
    }
    return _backgroundView;
}
-(UIImageView*)topBarView
{
    if(!_topBarView)
    {
        _topBarView     = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BCTopBar"]];
        [_topBarView setFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_WIDTH*154/750)];
    }
    return _topBarView;
}
-(CustomProgressBar*)progressView
{
    if(!_progressView)
    {
        _progressView = [[CustomProgressBar alloc] initWithFrame:CGRectMake((kSCREEN_WIDTH - CustomWidth(321)-CustomWidth(8))/2, kSCREEN_HEIGHT - CustomHeight(150)-CustomHeight(39), CustomWidth(321), CustomHeight(35))];
         }
    return _progressView;
}

-(UIImageView*)bottomPattern
{
    if(!_bottomPattern)
    {
        _bottomPattern = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BCBottomPattern"]];
        [_bottomPattern setFrame:CGRectMake(self.progressView.frame.origin.x+CustomWidth(86),self.progressView.frame.origin.y+self.progressView.frame.size.height-72,252,160)];
    }
    return _bottomPattern;
}
- (UIImageView*)indicatorView
{
    if (!_indicatorView) {
        _indicatorView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ProgressRectangle"]];
        _indicatorView.frame = CGRectMake(100, 100, 51, 48);
        [_indicatorView addSubview:self.indicatorLabel];
    }
    return _indicatorView;
}
- (UILabel *)indicatorLabel {
    if(_indicatorLabel == nil) {
        _indicatorLabel = [[UILabel alloc] init];
        [_indicatorLabel setText:@"0%"];
        [_indicatorLabel setTextColor:[UIColor whiteColor]];
    }
    return _indicatorLabel;
}
@end
