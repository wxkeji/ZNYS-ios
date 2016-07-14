//
//  ToothBrushCollectionViewCell.m
//  ZNYS
//
//  Created by 张恒铭 on 7/13/16.
//  Copyright © 2016 Woodseen. All rights reserved.
//

#import "ToothBrushCollectionViewCell.h"
#import "ToolMacroes.h"
#import "UILabel+Font.h"
#import "Masonry.h"

@interface ToothBrushCollectionViewCell()

@property(nonatomic,strong) UILabel* titleLabel;

@property(nonatomic,strong) UILabel* bindTimeHintLabel;

@property(nonatomic,strong) UILabel* bindTimeContentLabel;

@property(nonatomic,strong) UILabel* lastConnectTimeHintLabel;

@property(nonatomic,strong) UILabel* lastConnectTimeContentLabel;

@property(nonatomic,strong) UIImageView* toothbrushItemView;

@property(nonatomic,strong) UIButton* moreButton;

@end
@implementation ToothBrushCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.layer.cornerRadius = 10.0f;
    [self setBackgroundColor:cellOriginalColor];
    [self addSubview:self.titleLabel];
    [self addSubview:self.toothbrushItemView];
    [self addSubview:self.bindTimeHintLabel];
    [self addSubview:self.bindTimeContentLabel];
    [self addSubview:self.lastConnectTimeHintLabel];
    [self addSubview:self.lastConnectTimeContentLabel];
    [self addSubviewConstraints];
    return self;
}
#pragma mark - private methods
- (void)addSubviewConstraints {
    WS(weakSelf, self);
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker* make) {
        make.centerX.equalTo(weakSelf.mas_centerX);
//        make
    }];
    
    [self.bindTimeHintLabel mas_makeConstraints:^(MASConstraintMaker* make) {
        
    }];
    
    [self.bindTimeContentLabel mas_makeConstraints:^(MASConstraintMaker* make) {
        
    }];
    
    [self.lastConnectTimeHintLabel mas_makeConstraints:^(MASConstraintMaker* make) {
        
    }];
    
    [self.lastConnectTimeContentLabel mas_makeConstraints:^(MASConstraintMaker* make) {
        
    }];
    
    [self.toothbrushItemView mas_makeConstraints:^(MASConstraintMaker* make) {
        make.height.equalTo(@92);
        make.width.equalTo(@18);
        make.left.equalTo(weakSelf.mas_left).with.offset(15);
        make.top.equalTo(weakSelf.mas_top).with.offset(36);
    }];
    

}



- (void)onMoreButtonClicked {
    
}

#pragma mark - public methods
- (void)setToothBrush:(ToothBrush *)brush {
    self.titleLabel.text = brush.nickname;
    self.bindTimeContentLabel.text = brush.bindTime;
    self.lastConnectTimeHintLabel.text = brush.lastConnectTime;
}
#pragma mark - getter
- (UILabel *)titleLabel {
	if(_titleLabel == nil) {
		_titleLabel = [[UILabel alloc] init];
        [_titleLabel setFont:[UIFont systemFontOfSize:25.0f]];
        [_titleLabel sizeToFit];
        [_titleLabel setText:@"测试用牙刷"];
        [_titleLabel setTextColor:[UIColor whiteColor]];
        
        
	}
	return _titleLabel;
}

- (UILabel *)bindTimeHintLabel {
	if(_bindTimeHintLabel == nil) {
		_bindTimeHintLabel = [[UILabel alloc] init];
        [_bindTimeHintLabel setTextColor:[UIColor whiteColor]];
        [_bindTimeHintLabel setFont:[UIFont systemFontOfSize:15.f]];
    }
	return _bindTimeHintLabel;
}

- (UILabel *)bindTimeContentLabel {
	if(_bindTimeContentLabel == nil) {
		_bindTimeContentLabel = [[UILabel alloc] init];
	}
	return _bindTimeContentLabel;
}

- (UILabel *)lastConnectTimeHintLabel {
	if(_lastConnectTimeHintLabel == nil) {
		_lastConnectTimeHintLabel = [[UILabel alloc] init];
        [_lastConnectTimeHintLabel setTextColor:[UIColor whiteColor]];
        [_lastConnectTimeHintLabel setFont:[UIFont systemFontOfSize:15.f]];
	}
	return _lastConnectTimeHintLabel;
}

- (UILabel *)lastConnectTimeContentLabel {
	if(_lastConnectTimeContentLabel == nil) {
		_lastConnectTimeContentLabel = [[UILabel alloc] init];
	}
	return _lastConnectTimeContentLabel;
}

- (UIImageView *)toothbrushItemView {
	if(_toothbrushItemView == nil) {
		_toothbrushItemView = [[UIImageView alloc] init];
        [_toothbrushItemView setImage:[UIImage imageNamed:@"TBCToothBrush"]];//SIZE:18*91
	}
	return _toothbrushItemView;
}

- (UIButton *)moreButton {
	if(_moreButton == nil) {
		_moreButton = [[UIButton alloc] init];
        [_moreButton addTarget:self action:@selector(onMoreButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
	return _moreButton;
}

@end
