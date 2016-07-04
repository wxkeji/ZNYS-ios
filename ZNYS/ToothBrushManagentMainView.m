//
//  ToothBrushManagentMainView.m
//  ZNYS
//
//  Created by 张恒铭 on 6/12/16.
//  Copyright © 2016 Woodseen. All rights reserved.
//

#import "ToothBrushManagentMainView.h"

@interface ToothBrushManagentMainView()

@property (nonatomic,strong) UIImageView* iconView;
@property (nonatomic,strong) UILabel* userNickNameHintLabel;
@property (nonatomic,strong) UILabel* userNickNameContentLabel;
@property (nonatomic,strong) UILabel* toothBrushHintLabel;
@property (nonatomic,strong) UILabel* toothBrushBindingNumberLabel;
@property (nonatomic,strong) UILabel* titleLabel;
@property (nonatomic,strong) UIView* backgroundTopView;
@property (nonatomic,strong) UIView* backgroundButtomView;
@property (nonatomic,strong) UILabel* babysToothBrushHintLabel;
@property (nonatomic,strong) UILabel* findNewToothBrushHintLabel;
@property (nonatomic,strong) UICollectionView* babysToothBrushCollectionView;
@property (nonatomic,strong) UICollectionView* findNewToothBrushCollectionView;

@end
@implementation ToothBrushManagentMainView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    
    
    return self;
}

#pragma mark - getters

- (UIImageView *)iconView {
	if(_iconView == nil) {
		_iconView = [[UIImageView alloc] init];
	}
	return _iconView;
}

- (UILabel *)userNickNameHintLabel {
	if(_userNickNameHintLabel == nil) {
		_userNickNameHintLabel = [[UILabel alloc] init];
	}
	return _userNickNameHintLabel;
}

- (UILabel *)userNickNameContentLabel {
	if(_userNickNameContentLabel == nil) {
		_userNickNameContentLabel = [[UILabel alloc] init];
	}
	return _userNickNameContentLabel;
}

- (UILabel *)toothBrushHintLabel {
	if(_toothBrushHintLabel == nil) {
		_toothBrushHintLabel = [[UILabel alloc] init];
	}
	return _toothBrushHintLabel;
}

- (UILabel *)toothBrushBindingNumberLabel {
	if(_toothBrushBindingNumberLabel == nil) {
		_toothBrushBindingNumberLabel = [[UILabel alloc] init];
	}
	return _toothBrushBindingNumberLabel;
}

- (UILabel *)titleLabel {
	if(_titleLabel == nil) {
		_titleLabel = [[UILabel alloc] init];
	}
	return _titleLabel;
}

- (UIView *)backgroundTopView {
	if(_backgroundTopView == nil) {
		_backgroundTopView = [[UIView alloc] init];
	}
	return _backgroundTopView;
}

- (UIView *)backgroundButtomView {
	if(_backgroundButtomView == nil) {
		_backgroundButtomView = [[UIView alloc] init];
	}
	return _backgroundButtomView;
}

- (UILabel *)babysToothBrushHintLabel {
	if(_babysToothBrushHintLabel == nil) {
		_babysToothBrushHintLabel = [[UILabel alloc] init];
	}
	return _babysToothBrushHintLabel;
}

- (UILabel *)findNewToothBrushHintLabel {
	if(_findNewToothBrushHintLabel == nil) {
		_findNewToothBrushHintLabel = [[UILabel alloc] init];
	}
	return _findNewToothBrushHintLabel;
}

- (UICollectionView *)babysToothBrushCollectionView {
	if(_babysToothBrushCollectionView == nil) {
		_babysToothBrushCollectionView = [[UICollectionView alloc] init];
	}
	return _babysToothBrushCollectionView;
}

- (UICollectionView *)findNewToothBrushCollectionView {
	if(_findNewToothBrushCollectionView == nil) {
		_findNewToothBrushCollectionView = [[UICollectionView alloc] init];
	}
	return _findNewToothBrushCollectionView;
}

@end
