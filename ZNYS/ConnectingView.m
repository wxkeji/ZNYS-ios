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
@interface ConnectingView()
@property(strong,nonatomic)UIButton*    returnButton;
@property(strong,nonatomic)UIImageView* backgroundView;
@property(strong,nonatomic)UIImageView* topBarView;
@property(strong,nonatomic)UIView*      transparentView;
@property(strong,nonatomic)UIImageView* progressView;
@property(strong,nonatomic)UIImageView* bottomPattern;
@property(strong,nonatomic)UIImageView* progressViewInside;
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
        [self.progressView startAnimating];
        WS(weakSelf, self);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.progressView setImage:[UIImage imageNamed:@"进度100"]];
            
        });
    }
    return self;
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
-(UIImageView*)progressView
{
    if(!_progressView)
    {
      //  _progressView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BCProgressEmpty"]];
        _progressView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"进度0"]];
        _progressView = [[UIImageView alloc] initWithFrame:CGRectMake((kSCREEN_WIDTH - CustomWidth(321)-CustomWidth(8))/2, kSCREEN_HEIGHT - CustomHeight(150)-CustomHeight(39), CustomWidth(321), CustomHeight(73))];
      //  [_progressView setFrame:CGRectMake((kSCREEN_WIDTH - CustomWidth(321)-CustomWidth(8))/2, kSCREEN_HEIGHT - CustomHeight(150)-CustomHeight(39), 321, 73)];
        _progressView.animationImages = [NSArray arrayWithObjects:
                                         [UIImage imageNamed:@"进度10"],
                                         [UIImage imageNamed:@"进度20"],
                                         [UIImage imageNamed:@"进度30"],
                                         [UIImage imageNamed:@"进度40"],
                                         [UIImage imageNamed:@"进度50"],
                                         [UIImage imageNamed:@"进度60"],
                                         [UIImage imageNamed:@"进度70"],
                                         [UIImage imageNamed:@"进度80"],
                                         [UIImage imageNamed:@"进度90"],
                                         [UIImage imageNamed:@"进度100"],
                                         nil];
        _progressView.animationDuration = 2;
        _progressView.animationRepeatCount = 1;
       //[_progressView setFrame:CGRectMake((kSCREEN_WIDTH - CustomWidth(300))/2, kSCREEN_HEIGHT-CustomHeight(150), 300,34)];
    }
    return _progressView;
}
//-(UIView*)progressViewInside
//{
//    if(!_progressViewInside)
//    {
//        _progressViewInside = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BCProgress_fill"]];
//        [_progressViewInside setFrame:CGRectMake(self.progressView.frame.origin.x + CustomWidth(9), self.progressView.frame.origin.y + CustomHeight(8.7) , 275.5, 17)];
//    }
//    return _progressViewInside;
//}
-(UIImageView*)bottomPattern
{
    if(!_bottomPattern)
    {
        _bottomPattern = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BCBottomPattern"]];
        [_bottomPattern setFrame:CGRectMake(self.progressView.frame.origin.x+CustomWidth(86),self.progressView.frame.origin.y+self.progressView.frame.size.height-72,252,160)];
    }
    return _bottomPattern;
}

@end
