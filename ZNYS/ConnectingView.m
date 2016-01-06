//
//  ConnectingView.m
//  ZNYS
//
//  Created by 张恒铭 on 12/18/15.
//  Copyright © 2015 Woodseen. All rights reserved.
//

#import "ConnectingView.h"
#import <Masonry.h>
#import "ToolMacroes.h"
@interface ConnectingView()
@property(strong,nonatomic)UIButton* returnButton;
@property(strong,nonatomic)UIImageView* backgroundView;
@property(strong,nonatomic)UIImageView* topBarView;
@property(strong,nonatomic)UIProgressView* progressView;
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
    self = [super init];
    if (self)
    {
        [self addSubview:self.backgroundView];
        [self addSubview:self.topBarView];
        [self addSubview:self.returnButton];
        [self addSubview:self.progressView];
    }
    return self;
}
#pragma mark - button actions
-(void)returnToHome
{
    NSLog(@"准备返回");
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
        [_returnButton setFrame:CGRectMake(25,kSCREEN_WIDTH*154/750-42,30,30)];
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
-(UIProgressView*)progressView
{
    if(!_progressView)
    {
        _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        [_progressView setFrame:CGRectMake(40, kSCREEN_HEIGHT - 150, 3000, 3005)];
//        _progressView.progressImage = [UIImage imageNamed:@"BCProgress_fill"];
//        _progressView.trackImage = [UIImage imageNamed:@"BCProgressEmpty"];
    }
    return _progressView;
}
@end
