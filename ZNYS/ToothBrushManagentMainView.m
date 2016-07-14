//
//  ToothBrushManagentMainView.m
//  ZNYS
//
//  Created by 张恒铭 on 6/12/16.
//  Copyright © 2016 Woodseen. All rights reserved.
//

#import "ToothBrushManagentMainView.h"
#import "UILabel+Font.h"
#import "ToolMacroes.h"
#import "Masonry.h"
#import "CollectionViewLayout.h"
#import "ToothBrushCollectionViewCell.h"
#import "ToothBrushManagentFindView.h"
@interface ToothBrushManagentMainView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UIImageView* iconView;
@property (nonatomic,strong) UILabel* userNickNameHintLabel;
@property (nonatomic,strong) UILabel* userNickNameContentLabel;
@property (nonatomic,strong) UILabel* toothBrushHintLabel;
@property (nonatomic,strong) UILabel* toothBrushBindingNumberLabel;
@property (nonatomic,strong) UILabel* titleLabel;



@property(nonatomic,strong) ToothBrushManagentFindView* findView;


@end
@implementation ToothBrushManagentMainView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self addSubview:self.titleLabel];
    [self.headerView addSubview:self.iconView];
    
    [self.headerView addSubview:self.userNickNameHintLabel];
    [self.headerView addSubview:self.userNickNameContentLabel];
    
    [self.headerView addSubview:self.toothBrushHintLabel];
    [self.headerView addSubview:self.toothBrushBindingNumberLabel];
    
    
    [self.bottomView addSubview:self.findView];
    [self setConstraints];
    
    return self;
}


- (void)setConstraints {
    WS(weakSelf, self);
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker* make) {
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.centerY.equalTo(weakSelf.returnButton.mas_centerY);
    }];
    
    [self.iconView mas_makeConstraints:^(MASConstraintMaker* make) {
        make.height.equalTo(@(CustomHeight(80)));
        make.width.equalTo(@(CustomWidth(80)));
        make.top.equalTo(weakSelf.mas_top).with.offset(CustomHeight(80));
        make.left.equalTo(weakSelf.mas_left).with.offset(CustomWidth(70));
    }];
    [self.userNickNameHintLabel mas_makeConstraints:^(MASConstraintMaker* make) {
        make.left.equalTo(weakSelf.iconView.mas_right).with.offset(23);
        make.top.equalTo(weakSelf.iconView.mas_top).with.offset(CustomWidth(10));
        
    }];
    [self.toothBrushHintLabel mas_makeConstraints:^(MASConstraintMaker* make) {
        make.left.equalTo(weakSelf.userNickNameHintLabel.mas_left);
        make.bottom.equalTo(weakSelf.iconView.mas_bottom).with.offset(-CustomHeight(10));
        
    }];
    [self.toothBrushBindingNumberLabel mas_makeConstraints:^(MASConstraintMaker* make) {
        make.left.equalTo(weakSelf.toothBrushHintLabel.mas_right);
        make.baseline.equalTo(weakSelf.toothBrushHintLabel.mas_baseline);
    }];
    [self.userNickNameContentLabel mas_makeConstraints:^(MASConstraintMaker* make) {
        make.left.equalTo(weakSelf.userNickNameHintLabel.mas_right);
        make.baseline.equalTo(weakSelf.userNickNameHintLabel.mas_baseline);
    }];
}
#pragma mark - UICollectionVeiw delegate

//
//#pragma mark - UICollectionView datasource
//-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    if (section == 0) {
//        return self.connectedToothBrushArray.count;
//    } else if(section == 1) {
//        return self.newToothBrushArray.count;
//    } else {
//        return 0;//should not reach here
//    }
//    
//}
//
//- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    return nil;
//}
#pragma mark - set view content

- (void)setToothBrushNumber:(NSInteger)number {
    self.toothBrushBindingNumberLabel.text = @(number).description;
}

- (void)setUserNickname:(NSString*)nickname {
    self.userNickNameContentLabel.text = nickname;
}

#pragma mark - getters

- (UIImageView *)iconView {
	if(_iconView == nil) {
		_iconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CustomWidth(100) , CustomHeight(100))];
        _iconView.layer.cornerRadius = 10.0f;
        [_iconView setBackgroundColor:[UIColor redColor]];
	}
	return _iconView;
}

- (UILabel *)userNickNameHintLabel {
	if(_userNickNameHintLabel == nil) {
		_userNickNameHintLabel = [[UILabel alloc] initWithCustomFont:15.0f];
        [_userNickNameHintLabel setTextColor:[UIColor whiteColor]];
        [_userNickNameHintLabel sizeToFit];
        [_userNickNameHintLabel setText:@"昵称:"];
	}
	return _userNickNameHintLabel;
}

- (UILabel *)userNickNameContentLabel {
	if(_userNickNameContentLabel == nil) {
		_userNickNameContentLabel = [[UILabel alloc] initWithCustomFont:15.0f];
        [_userNickNameContentLabel sizeToFit];
        _userNickNameContentLabel.text = @"宝宝";
        [_userNickNameContentLabel setTextColor:[UIColor yellowColor]];
	}
	return _userNickNameContentLabel;
}

- (UILabel *)toothBrushHintLabel {
	if(_toothBrushHintLabel == nil) {
		_toothBrushHintLabel = [[UILabel alloc] initWithCustomFont:15.0f];
        [_toothBrushHintLabel setText:@"绑定牙刷数:"];
        [_toothBrushHintLabel setTextColor:[UIColor whiteColor]];
        [_toothBrushHintLabel sizeToFit];
	}
	return _toothBrushHintLabel;
}

- (UILabel *)toothBrushBindingNumberLabel {
	if(_toothBrushBindingNumberLabel == nil) {
		_toothBrushBindingNumberLabel = [[UILabel alloc] initWithCustomFont:15.0f];
        [_toothBrushBindingNumberLabel  setText: @"1把"];
        [_toothBrushBindingNumberLabel sizeToFit];
        [_toothBrushBindingNumberLabel setTextColor:[UIColor yellowColor]];

	}
	return _toothBrushBindingNumberLabel;
}

- (UILabel *)titleLabel {
	if(_titleLabel == nil) {
		_titleLabel = [[UILabel alloc] initWithCustomFont:25.0f];
        [_titleLabel setTextColor:[UIColor whiteColor]];
        [_titleLabel sizeToFit];
        [_titleLabel setText:@"宝宝的牙刷"];
	}
	return _titleLabel;
}


//- (UICollectionView *)babysToothBrushCollectionView {
//	if(_babysToothBrushCollectionView == nil) {
//		_babysToothBrushCollectionView = [[UICollectionView alloc] init];
//        _babysToothBrushCollectionView.collectionViewLayout = self.linearLayout;
//        _babysToothBrushCollectionView.delegate = self;
//        _babysToothBrushCollectionView.dataSource = self;
//	}
//	return _babysToothBrushCollectionView;
//}
//
//- (UICollectionView *)findNewToothBrushCollectionView {
//	if(_findNewToothBrushCollectionView == nil) {
//		_findNewToothBrushCollectionView = [[UICollectionView alloc] init];
//	}
//	return _findNewToothBrushCollectionView;
//}
//
//- (CollectionViewLayout *)linearLayout {
//	if(_linearLayout == nil) {
//		_linearLayout = [[CollectionViewLayout alloc] init];
//	}
//	return _linearLayout;
//}




- (ToothBrushManagentFindView *)findView {
	if(_findView == nil) {
		_findView = [[ToothBrushManagentFindView alloc] initWithFrame:self.bottomView.bounds];
        [_findView setBackgroundColor:[UIColor whiteColor]];
	}
	return _findView;
}

@end
