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
        self.returnButton   = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.returnButton setBackgroundImage:[UIImage imageNamed:@"BCTopBarReturnButton"] forState:UIControlStateNormal];
        [self.returnButton sizeToFit];
        [self.returnButton setFrame:CGRectMake(25, 30, 30, 30)];
        [self.returnButton addTarget:self action:@selector(returnToHome) forControlEvents:UIControlEventTouchUpInside];
    }
    return _returnButton;
}
-(UIImageView*)backgroundView
{
    if(!_backgroundView)
    {
        self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BCBackground"]];
        [self.backgroundView setFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
    }
    return _backgroundView;
}
-(UIImageView*)topBarView
{
    if(!_topBarView)
    {
        self.topBarView     = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BCTopBar"]];
        [self.topBarView setFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 75)];
    }
    return _topBarView;
}
@end
