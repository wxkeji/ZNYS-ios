


//
//  SettingBaseView.m
//  ZNYS
//
//  Created by 张恒铭 on 7/11/16.
//  Copyright © 2016 Woodseen. All rights reserved.
//

#import "SettingBaseView.h"
#import "Masonry.h"
#import "SettingHeaderView.h"
#import "AppDelegate.h"
@interface SettingBaseView()

@end

@implementation SettingBaseView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self setBackgroundColor:[UIColor clearColor]];
    [self addSubview:self.headerView];
    [self addSubview:self.bottomView];
    [self.headerView addSubview:self.returnButton];
    [self makeConstraints];
    return self;
}


- (void)makeConstraints {
    
}


#pragma mark - button actions

- (void)onReturnButonClicked {
    [[[AppDelegate sharedInstance] getCurrentTopViewController].navigationController popViewControllerAnimated:YES];
}

#pragma mark - getters
- (UIButton *)returnButton {
	if(_returnButton == nil) {
		_returnButton = [[UIButton alloc] initWithFrame:CGRectMake(0.061*kSCREEN_WIDTH, 0.042*kSCREEN_HEIGHT, 35, 35)];
        [_returnButton setImage:[UIImage imageNamed:@"userAccount_back"] forState:UIControlStateNormal];
        [_returnButton addTarget:self action:@selector(onReturnButonClicked) forControlEvents:UIControlEventTouchUpInside];
	}
	return _returnButton;
}

- (UIView *)headerView {
	if(_headerView == nil) {
		_headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 0.298*kSCREEN_HEIGHT)];
        [_headerView setBackgroundColor:RGBCOLOR(95.0f, 187.0f, 237.0f)];
	}
	return _headerView;
}

- (UIView *)bottomView {
	if(_bottomView == nil) {
		_bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0.298*kSCREEN_HEIGHT, kSCREEN_WIDTH, (1-0.298)*kSCREEN_HEIGHT)];
        [_bottomView setBackgroundColor:[UIColor clearColor]];
	}
	return _bottomView;
}

@end
