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

@interface AddAccountView()

@property (nonatomic,strong) UILabel * chooseThumbLabel;

@property (nonatomic,strong) UILabel * nameLabel;

@property (nonatomic,strong) UILabel * chooseBirthLabel;

@end

@implementation AddAccountView

#pragma mark life cycle

- (void)dealloc{
    _chooseThumbLabel = nil;
    _nameLabel = nil;
    _chooseBirthLabel = nil;
    _boysButton = nil;
    _girlsButton = nil;
    _nameTextField = nil;
    _birthButton = nil;
    _delegate = nil;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor blueColor];
        
        UIView * bgView = [[UIView alloc] init];
        bgView.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.chooseThumbLabel];
        [self addSubview:self.nameLabel];
        [self addSubview:self.chooseBirthLabel];
        [self addSubview:bgView];
        [bgView addSubview:self.boysButton];
        [bgView addSubview:self.girlsButton];
        [self addSubview:self.nameTextField];
        [self addSubview:self.birthButton];
        
        WS(weakSelf, self);
        [self.chooseThumbLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left).with.offset(25);
            make.top.equalTo(weakSelf.mas_top).with.offset(30);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(25);
        }];
        
        [self.boysButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bgView.mas_left).with.offset(5);
            make.top.equalTo(bgView.mas_top).with.offset(10);
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(50);
        }];
        
        [self.girlsButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(bgView.mas_right).with.offset(-5);
            make.centerY.mas_equalTo(weakSelf.boysButton.mas_centerY);
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(50);
        }];
        
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.mas_right).with.offset(-20);
            make.centerY.mas_equalTo(weakSelf.chooseThumbLabel.mas_centerY);
            make.height.mas_equalTo(70);
            make.width.mas_equalTo(120);
        }];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left).with.offset(25);
            make.centerY.mas_equalTo(weakSelf.mas_centerY);
            make.height.mas_equalTo(25);
            make.width.mas_equalTo(40);
        }];
        
        [self.nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.mas_right).with.offset(-25);
            make.centerY.mas_equalTo(weakSelf.nameLabel.mas_centerY);
            make.height.mas_equalTo(25);
            make.width.mas_equalTo(110);
        }];
        
        [self.chooseBirthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left).with.offset(25);
            make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-30);
            make.height.mas_equalTo(25);
            make.width.mas_equalTo(40);
        }];
        
        [self.birthButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.mas_right).with.offset(-25);
            make.centerY.mas_equalTo(weakSelf.chooseBirthLabel.mas_centerY);
            make.height.mas_equalTo(25);
            make.width.mas_equalTo(110);
        }];
    }
    return self;
}

#pragma mark event action

- (void)thumbButtonAction:(UIButton *)choice{
    [self.delegate changeChoice:choice];
}

- (void)birthButtonAction{
    [self.delegate showPickerView];
}

#pragma mark getters and setters

- (UIButton *)boysButton{
    if (!_boysButton) {
        _boysButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _boysButton.tag = 0;
//        [_boysButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
//        [_boysButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
        [_boysButton setBackgroundColor:[UIColor redColor]];
        [_boysButton addTarget:self action:@selector(thumbButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _boysButton;
}

- (UIButton *)girlsButton{
    if (!_girlsButton) {
        _girlsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _girlsButton.tag = 1;
//        [_girlsButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
//        [_girlsButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
        [_girlsButton setBackgroundColor:[UIColor yellowColor]];
        [_girlsButton addTarget:self action:@selector(thumbButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _girlsButton;
}

- (UITextField *)nameTextField{
    if (!_nameTextField) {
        _nameTextField = [[UITextField alloc] init];
        _nameTextField.font = [UIFont systemFontOfSize:15.f];
        _nameTextField.placeholder = @"请输入昵称";
        _nameTextField.textAlignment = NSTextAlignmentCenter;
        _nameTextField.backgroundColor = [UIColor redColor];
    }
    return _nameTextField;
}

- (UIButton *)birthButton{
    if (!_birthButton) {
        _birthButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _birthButton.titleLabel.font = [UIFont systemFontOfSize:13.f];
        [_birthButton setTitle:@"请选择生日" forState:UIControlStateNormal];
        [_birthButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_birthButton setBackgroundColor:[UIColor redColor]];
        [_birthButton addTarget:self action:@selector(birthButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _birthButton;
}

- (UILabel *)chooseBirthLabel{
    if (!_chooseBirthLabel) {
        _chooseBirthLabel = [[UILabel alloc] init];
        _chooseBirthLabel.text = @"生日";
        _chooseBirthLabel.textColor = [UIColor whiteColor];
        _chooseBirthLabel.font = [UIFont systemFontOfSize:15.f];
    }
    return _chooseBirthLabel;
}

- (UILabel *)chooseThumbLabel{
    if (!_chooseThumbLabel) {
        _chooseThumbLabel = [[UILabel alloc]init];
        _chooseThumbLabel.text = @"选择头像颜色";
        _chooseThumbLabel.textColor = [UIColor whiteColor];
        _chooseThumbLabel.font = [UIFont systemFontOfSize:15.f];
    }
    return _chooseThumbLabel;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = @"昵称";
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.font = [UIFont systemFontOfSize:15.f];
    }
    return _nameLabel;
}

@end
