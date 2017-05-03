//
//  AddAccountView.m
//  UserAccountModule
//
//  Created by Ellise on 15/12/17.
//  Copyright © 2015年 ellise. All rights reserved.
//

#import "AddAccountView.h"
#import <Masonry.h>
#import "ToolMacroes.h"
#import "UITextField+Font.h"
#import "UIButton+Font.h"
#import "UILabel+Font.h"

@interface AddAccountView()

@property (nonatomic,strong) UILabel * chooseThumbLabel;

@property (nonatomic,strong) UILabel * nameLabel;

@property (nonatomic,strong) UILabel * chooseBirthLabel;

@property (nonatomic, strong) UIImageView *girlsImageView;
@property (nonatomic, strong) UIImageView *boysImageView;
@end

@implementation AddAccountView

#pragma mark life cycle
- (instancetype)init{
    self = [super init];
    if (self) {
        
//        UIView * bgView = [[UIView alloc] init];
//        bgView.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.chooseThumbLabel];
        [self addSubview:self.nameLabel];
        [self addSubview:self.chooseBirthLabel];
//        [self addSubview:bgView];
        [self addSubview:self.boysImageView];
        [self addSubview:self.boysButton];
        [self addSubview:self.girlsImageView];
        [self addSubview:self.girlsButton];
        [self addSubview:self.nameTextField];
        [self addSubview:self.birthButton];
        [self addSubview:self.titleLabel];
        [self addSubview:self.dismissButton];
        
        WS(weakSelf, self);
        [self.chooseThumbLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left).with.offset(CustomWidth(33));
            make.top.equalTo(weakSelf.mas_top).with.offset(CustomHeight(160));
            make.height.mas_equalTo(CustomHeight(31));
        }];
        
        [self.boysButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.chooseThumbLabel.mas_right).with.offset(CustomWidth(16));
            make.centerY.mas_equalTo(weakSelf.chooseThumbLabel.mas_centerY);
            make.width.mas_equalTo(CustomWidth(105));
            make.height.mas_equalTo(CustomHeight(105));
        }];
        [self.boysImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.chooseThumbLabel.mas_right).with.offset(CustomWidth(16));
            make.centerY.mas_equalTo(weakSelf.chooseThumbLabel.mas_centerY);
            make.width.mas_equalTo(CustomWidth(105));
            make.height.mas_equalTo(CustomHeight(105));
        }];
        [self.girlsButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.boysButton.mas_right).with.offset(CustomWidth(16));
            make.centerY.mas_equalTo(weakSelf.boysButton.mas_centerY);
            make.width.mas_equalTo(CustomWidth(105));
            make.height.mas_equalTo(CustomHeight(105));
        }];
        [self.girlsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.boysButton.mas_right).with.offset(CustomWidth(16));
            make.centerY.mas_equalTo(weakSelf.boysButton.mas_centerY);
            make.width.mas_equalTo(CustomWidth(105));
            make.height.mas_equalTo(CustomHeight(105));
        }];
        
//        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(weakSelf.mas_right).with.offset(-20);
//            make.centerY.mas_equalTo(weakSelf.chooseThumbLabel.mas_centerY);
//            make.height.mas_equalTo(70);
//            make.width.mas_equalTo(120);
//        }];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left).with.offset(CustomWidth(33));
            make.top.equalTo(weakSelf.chooseThumbLabel.mas_bottom).with.offset(CustomHeight(74));
            make.height.mas_equalTo(CustomHeight(31));
        }];
        
        [self.nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.nameLabel.mas_right).with.offset(CustomWidth(16));
            make.centerY.mas_equalTo(weakSelf.nameLabel.mas_centerY);
            make.height.mas_equalTo(CustomHeight(43));
            make.width.mas_equalTo(CustomWidth(227));
        }];
        
        [self.chooseBirthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left).with.offset(CustomWidth(33));
            make.top.equalTo(weakSelf.nameLabel.mas_bottom).with.offset(CustomHeight(37));
            make.height.mas_equalTo(CustomHeight(31));
        }];
        
        [self.birthButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.chooseBirthLabel.mas_right).with.offset(CustomWidth(16));
            make.centerY.mas_equalTo(weakSelf.chooseBirthLabel.mas_centerY);
            make.height.mas_equalTo(CustomHeight(43));
            make.width.mas_equalTo(CustomWidth(227));
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.mas_top).with.offset(CustomHeight(32.5));
            make.centerX.mas_equalTo(weakSelf.mas_centerX);
            make.height.mas_equalTo(CustomHeight(29));
        }];
        
        [self.dismissButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left).with.offset(CustomWidth(24));
            make.centerY.mas_equalTo(weakSelf.titleLabel.mas_centerY);
            make.width.mas_equalTo(CustomWidth(32.5));
            make.height.mas_equalTo(CustomHeight(32.5));
        }];
    }
    return self;
}
#pragma mark - public methods
- (void)configureTheme {
    self.backgroundColor = [UIColor colorWithThemedImageNamed:@"color/primary"];
    [self.dismissButton setImage:[UIImage themedImageWithNamed:@"navigation/dismissButton"] forState:UIControlStateNormal];
}

#pragma mark event action

- (void)thumbButtonAction:(UIButton *)choice{
    [self.delegate changeChoice:choice];
}

- (void)birthButtonAction{
    [self.delegate showPickerView];
}

- (void)dismissButtonAction{
    [self.delegate dismissButtonAction];
}

#pragma mark getters and setters

- (UIButton *)boysButton{
    if (!_boysButton) {
        _boysButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _boysButton.tag = 0;
//        [_boysButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
//        [_boysButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
        [_boysButton setBackgroundColor:[UIColor clearColor]];
        [_boysButton addTarget:self action:@selector(thumbButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _boysButton;
}
- (UIImageView *)boysImageView {
    if (!_boysImageView) {
        _boysImageView = [[UIImageView alloc] init];
        [_boysImageView setImage:[UIImage imageNamed:@"user/boyDefault"]];
    }
    return _boysImageView;
}

- (UIButton *)girlsButton{
    if (!_girlsButton) {
        _girlsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _girlsButton.tag = 1;
//        [_girlsButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
//        [_girlsButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
        [_girlsButton setBackgroundColor:RGBACOLOR(0, 0, 0, 0.3)];
        [_girlsButton addTarget:self action:@selector(thumbButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _girlsButton;
}
- (UIImageView *)girlsImageView {
    if (!_girlsImageView) {
        _girlsImageView = [[UIImageView alloc] init];
        [_girlsImageView setImage:[UIImage imageNamed:@"user/girlDefault"]];
    }
    return _girlsImageView;
}

- (UITextField *)nameTextField{
    if (!_nameTextField) {
        _nameTextField = [[UITextField alloc] initWithCustomFont:22.f];
//        _nameTextField.placeholder = @"请输入昵称";
        _nameTextField.textAlignment = NSTextAlignmentCenter;
        _nameTextField.textColor = [UIColor whiteColor];
        _nameTextField.backgroundColor = [UIColor clearColor];
    }
    return _nameTextField;
}

- (UIButton *)birthButton{
    if (!_birthButton) {
        _birthButton = [[UIButton alloc] initWithCustomFont:22.f];
    //    [_birthButton setTitle:@"请选择生日" forState:UIControlStateNormal];
        [_birthButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_birthButton setBackgroundColor:[UIColor clearColor]];
        [_birthButton addTarget:self action:@selector(birthButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _birthButton;
}

- (UILabel *)chooseBirthLabel{
    if (!_chooseBirthLabel) {
        _chooseBirthLabel = [[UILabel alloc] initWithCustomFont:20.f];
        _chooseBirthLabel.text = @"生日：";
        _chooseBirthLabel.textColor = [UIColor whiteColor];
    }
    return _chooseBirthLabel;
}

- (UILabel *)chooseThumbLabel{
    if (!_chooseThumbLabel) {
        _chooseThumbLabel = [[UILabel alloc]initWithCustomFont:20.f];
        _chooseThumbLabel.text = @"头像：";
        _chooseThumbLabel.textColor = [UIColor whiteColor];
    }
    return _chooseThumbLabel;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithCustomFont:20.f];
        _nameLabel.text = @"昵称：";
        _nameLabel.textColor = [UIColor whiteColor];
    }
    return _nameLabel;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithCustomFont:23.f];
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _titleLabel;
}

- (UIButton *)dismissButton{
    if (!_dismissButton) {
        _dismissButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_dismissButton addTarget:self action:@selector(dismissButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dismissButton;
}

@end
