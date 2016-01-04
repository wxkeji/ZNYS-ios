//
//  VerifyPasswordViewController.m
//  ZNYS
//
//  Created by Ellise on 16/1/2.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "VerifyPasswordViewController.h"
#import "VerifyPasswordView.h"

@interface VerifyPasswordViewController()

@property (nonatomic,strong) UILabel * titleLabel;

@property (nonatomic,strong) UILabel * inputTipsLabel;

@property (nonatomic,strong) VerifyPasswordView * keyboardView;

@property (nonatomic,strong) NSMutableArray * tipsArray;

@property (nonatomic,strong) NSMutableArray * inputArray;

@property (nonatomic,strong) UIImageView * logoImage;

@property (nonatomic,strong) UIButton * dismissButton;

@end

@implementation VerifyPasswordViewController

#pragma mark life cycle

- (void)dealloc{
    _titleLabel = nil;
    _inputTipsLabel = nil;
    _keyboardView = nil;
    _tipsArray = nil;
    _inputArray = nil;
    _logoImage = nil;
    _dismissButton = nil;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setTipsNumber];
   

    
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.inputTipsLabel];
    [self.view addSubview:self.logoImage];
    [self.view addSubview:self.keyboardView];
    [self.view addSubview:self.dismissButton];
    
    WS(weakSelf, self);
    [self.dismissButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).with.offset(25);
        make.top.equalTo(weakSelf.view.mas_top).with.offset(33);
        make.width.mas_equalTo(32);
        make.height.mas_equalTo(32);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view.mas_top).with.offset(82);
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
        make.height.mas_equalTo(44);
     
    }];
    
    [self.inputTipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.logoImage.mas_right).with.offset(2);
        make.top.equalTo(weakSelf.titleLabel.mas_bottom).with.offset(11);
        make.height.mas_equalTo(18);
    }];
    
    [self.logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.keyboardView.mas_left).with.offset(-10);
        make.top.equalTo(weakSelf.titleLabel.mas_bottom).with.offset(11);
        make.height.mas_equalTo(0.307*kSCREEN_WIDTH);
        make.width.mas_equalTo(0.307*kSCREEN_WIDTH);
    }];
    
    [self.keyboardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.logoImage.mas_bottom).with.offset(-10);
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
        make.width.mas_equalTo(0.784*kSCREEN_WIDTH);
        make.height.mas_equalTo(0.42*kSCREEN_HEIGHT);
    }];
}

#pragma mark private method

- (void)setTipsNumber{
    for (NSInteger i = 0; i<3; i++) {
        NSInteger ran = (arc4random()%9+1);
        NSString * ranString = [NSString stringWithFormat:@"%ld",(long)ran];
        [self.tipsArray addObject:ranString];
    }
}

- (NSString *)changeNumberToString:(NSInteger)number{
    switch (number) {
        case 1:
            return @"一";
            break;
           
        case 2:
            return @"二";
            break;
            
        case 3:
            return @"三";
            break;
            
        case 4:
            return @"四";
            break;
         
        case 5:
            return @"五";
            break;
            
        case 6:
            return @"六";
            break;
            
        case 7:
            return @"七";
            break;
            
        case 8:
            return @"八";
            break;
            
        case 9:
            return @"九";
            break;
            
        default:
            return nil;
            break;
    }
}

#pragma mark event action

- (void)dismissButtonAction{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark getters and setters

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithCustomFont:50.f isBold:YES];
        _titleLabel.text = @"只适用于父母";
        _titleLabel.textColor = RGBCOLOR(241, 141, 172);
    }
    return _titleLabel;
}

- (UIButton *)dismissButton{
    if (!_dismissButton) {
        _dismissButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_dismissButton setImage:[UIImage imageNamed:@"userAccount_back"] forState:UIControlStateNormal];
        [_dismissButton addTarget:self action:@selector(dismissButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dismissButton;
}

- (UILabel *)inputTipsLabel{
    if (!_inputTipsLabel) {
        _inputTipsLabel = [[UILabel alloc]initWithCustomFont:19.f isBold:YES];
        
        NSString * first = [self changeNumberToString:[[self.tipsArray objectAtIndex:0] integerValue]];
        NSString * second = [self changeNumberToString:[[self.tipsArray objectAtIndex:1] integerValue]];
        NSString * third = [self changeNumberToString:[[self.tipsArray objectAtIndex:2] integerValue]];
        _inputTipsLabel.text = [NSString stringWithFormat:@"请输入数字%@、%@、%@",first,second,third];
        
        _inputTipsLabel.textColor = RGBCOLOR(241, 141, 172);
    }
    return _inputTipsLabel;
}

- (VerifyPasswordView *)keyboardView{
    if (!_keyboardView) {
        _keyboardView = [[VerifyPasswordView alloc] init];
        _keyboardView.layer.cornerRadius = 8.0f;
        
        WS(weakSelf, self);
        _keyboardView.buttonClickBlock = ^(NSInteger number){
            NSString * numberString = [NSString stringWithFormat:@"%ld",(long)number];
            [weakSelf.inputArray addObject:numberString];
            
            if (self.inputArray.count == 3) {
                BOOL isCorrect = ([[weakSelf.inputArray objectAtIndex:0] integerValue] == [[weakSelf.tipsArray objectAtIndex:0] integerValue]) && ([[weakSelf.inputArray objectAtIndex:1] integerValue] == [[weakSelf.tipsArray objectAtIndex:1] integerValue]) && ([[weakSelf.inputArray objectAtIndex:2] integerValue] == [[weakSelf.tipsArray objectAtIndex:2] integerValue]);
                if (isCorrect) {
                    weakSelf.logoImage.hidden = YES;
                }else{
                    [SVProgressHUD setBackgroundColor:RGBCOLOR(241, 141, 172)];
                    [SVProgressHUD showErrorWithStatus:@"输入有误，请重新输入"];
                    [weakSelf.inputArray removeAllObjects];
                }
            }
        };
    }
    return _keyboardView;
}

- (UIImageView *)logoImage{
    if (!_logoImage) {
        _logoImage = [[UIImageView alloc] init];
        _logoImage.backgroundColor =[UIColor redColor];
        _logoImage.image = [UIImage imageNamed:@"userAccount_logo"];
    }
    return _logoImage;
}

- (NSMutableArray *)tipsArray{
    if (!_tipsArray) {
        _tipsArray = [[NSMutableArray alloc] init];
    }
    return _tipsArray;
}

- (NSMutableArray *)inputArray{
    if (!_inputArray) {
        _inputArray = [[NSMutableArray alloc] init];
    }
    return _inputArray;
}

@end
