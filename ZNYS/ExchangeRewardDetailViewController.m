
//
//  ExchangeRewardDetailViewController.m
//  ZNYS
//
//  Created by Ellise on 16/5/3.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "ExchangeRewardDetailViewController.h"
#import "VerifyPasswordView.h"
#import "AwardManager.h"

@interface ExchangeRewardDetailViewController ()

@property (nonatomic,strong) UIButton * dismissButton;

@property (nonatomic,strong) UIView * backgroundView;

@property (nonatomic,strong) UIImageView * userImageView;

@property (nonatomic,strong) UILabel * userLabel;

@property (nonatomic,strong) UIImageView * coinView;

@property (nonatomic,strong) UILabel * coinLabel;

@property (nonatomic,strong) VerifyPasswordView * passwordView;

@property (nonatomic,strong) RewardItemView * itemView;

@property (nonatomic,strong) UILabel * tipsLabel;

@property (nonatomic,strong) NSMutableArray * tipsArray;

@property (nonatomic,strong) NSMutableArray * inputArray;

@end

@implementation ExchangeRewardDetailViewController

#pragma mark life cycle

- (void)dealloc{
    _model = nil;
    _dismissButton = nil;
    _backgroundView = nil;
    _userImageView = nil;
    _userLabel = nil;
    _coinLabel = nil;
    _coinView = nil;
    _passwordView = nil;
    _tipsLabel = nil;
    _itemView = nil;
    _tipsArray = nil;
    _inputArray = nil;
}

- (instancetype)initWithModel:(Award *)model{
    self = [super init];
    if (self) {
        self.model = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.nav.hidden = YES;
    [self setTipsNumber];

    [self.view addSubview:self.backgroundView];
    [self.view addSubview:self.dismissButton];
    [self.view addSubview:self.userImageView];
    [self.view addSubview:self.userLabel];
    [self.view addSubview:self.coinLabel];
    [self.view addSubview:self.coinView];
    [self.view addSubview:self.passwordView];
    [self.view addSubview:self.tipsLabel];
    [self.view addSubview:self.itemView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:@"exchangeAwardSuccess" object:nil];
    
    WS(weakSelf, self);
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).with.offset(0);
        make.right.equalTo(weakSelf.view.mas_right).with.offset(0);
        make.top.equalTo(weakSelf.view.mas_top).with.offset(0);
        make.height.mas_equalTo(CustomHeight(200));
    }];
    
    [self.dismissButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).with.offset(CustomWidth(15));
        make.top.equalTo(weakSelf.view.mas_top).with.offset(CustomHeight(30));
        make.width.mas_equalTo(CustomWidth(50));
        make.height.mas_equalTo(CustomHeight(50));
    }];
    
    [self.userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).with.offset(CustomWidth(125));
        make.top.equalTo(weakSelf.view.mas_top).with.offset(CustomHeight(100));
        make.width.mas_equalTo(CustomWidth(20));
        make.height.mas_equalTo(CustomHeight(20));
    }];
    
    [self.userLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.userImageView.mas_right).with.offset(CustomWidth(2));
        make.centerY.mas_equalTo(weakSelf.userImageView.mas_centerY);
        make.width.mas_equalTo(CustomWidth(50));
        make.height.mas_equalTo(CustomHeight(17));
    }];
    
    [self.coinView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.userLabel.mas_right).with.offset(CustomWidth(2));
        make.centerY.mas_equalTo(weakSelf.userImageView.mas_centerY);
        make.width.mas_equalTo(CustomWidth(20));
        make.height.mas_equalTo(CustomHeight(20));
    }];
    
    [self.coinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.coinView.mas_right).with.offset(CustomWidth(2));
        make.centerY.mas_equalTo(weakSelf.userImageView.mas_centerY);
        make.width.mas_equalTo(CustomWidth(50));
        make.height.mas_equalTo(CustomHeight(17));
    }];

    [self.passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.itemView.mas_right).with.offset(CustomWidth(17));
        make.centerY.mas_equalTo(weakSelf.itemView.mas_centerY);
        make.width.mas_equalTo(CustomWidth(220));
        make.height.mas_equalTo(CustomHeight(230));
    }];
    
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.view.mas_right).with.offset(CustomWidth(-15));
        make.bottom.equalTo(weakSelf.view.mas_bottom).with.offset(CustomHeight(-100));
        make.width.mas_equalTo(CustomWidth(280));
        make.height.mas_equalTo(CustomHeight(40));
    }];
}

#pragma mark RewardItemDelegate

- (void)playRecord:(Award *)model{
    
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

- (void)refresh{
    self.coinLabel.text = [NSString stringWithFormat:@"%@",[User currentUserTokenOwned]];
}

#pragma mark event action

- (void)dismissButtonClicked{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark getters and setters

- (UIButton *)dismissButton{
    if (!_dismissButton) {
        _dismissButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _dismissButton.backgroundColor = [UIColor grayColor];
        [_dismissButton addTarget:self action:@selector(dismissButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dismissButton;
}

- (UIView *)backgroundView{
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] init];
        _backgroundView.backgroundColor = [UIColor greenColor];
    }
    return _backgroundView;
}

- (UIImageView *)userImageView{
    if (!_userImageView) {
        _userImageView = [[UIImageView alloc] init];
        _userImageView.backgroundColor = [UIColor purpleColor];
    }
    return _userImageView;
}

- (UIImageView *)coinView{
    if (!_coinView) {
        _coinView = [[UIImageView alloc] init];
        _coinView.backgroundColor = [UIColor purpleColor];
    }
    return _coinView;
}

- (UILabel *)userLabel{
    if (!_userLabel) {
        _userLabel = [[UILabel alloc] initWithCustomFont:15.f];
        _userLabel.text = [User currentUserName];
        _userLabel.textColor = [UIColor blueColor];
        _userLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _userLabel;
}

- (UILabel *)coinLabel{
    if (!_coinLabel) {
        _coinLabel = [[UILabel alloc] initWithCustomFont:15.f];
        _coinLabel.text = [NSString stringWithFormat:@"%@",[User currentUserTokenOwned]];
        _coinLabel.textColor = [UIColor blueColor];
        _coinLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _coinLabel;
}

- (RewardItemView *)itemView{
    if (!_itemView) {
        _itemView = [[RewardItemView alloc] initWithFrame:CGRectMake(CustomWidth(10), CustomHeight(270), CustomWidth(120), CustomHeight(160)) type:RecordType model:self.model];
        _itemView.coinLabel.text = [NSString stringWithFormat:@"x %ld",(long)self.model.price];
        if ([self.model.pitcureURL isEqualToString:@"testImage1"]) {
            _itemView.bgView.backgroundColor = [UIColor greenColor];
        }else if ([self.model.pitcureURL isEqualToString:@"testImage2"]){
            _itemView.bgView.backgroundColor = [UIColor redColor];
        }else if ([self.model.pitcureURL isEqualToString:@"testImage3"]){
            _itemView.bgView.backgroundColor = [UIColor cyanColor];
        }else{
            _itemView.bgView.backgroundColor = [UIColor yellowColor];
        }
        _itemView.selectButton.hidden = YES;
        _itemView.delegate = self;
    }
    return _itemView;
}

- (VerifyPasswordView *)passwordView{
    if (!_passwordView) {
        _passwordView = [[VerifyPasswordView alloc] initWithFrame:CGRectMake(CustomWidth(200), CustomHeight(400), CustomWidth(220), CustomHeight(220))];
        _passwordView.layer.cornerRadius = 8.0f;
        
        WS(weakSelf, self);
        _passwordView.buttonClickBlock = ^(NSInteger number){
            NSString * numberString = [NSString stringWithFormat:@"%ld",(long)number];
            [weakSelf.inputArray addObject:numberString];
            
            if (self.inputArray.count == 3) {
                BOOL isCorrect = ([[weakSelf.inputArray objectAtIndex:0] integerValue] == [[weakSelf.tipsArray objectAtIndex:0] integerValue]) && ([[weakSelf.inputArray objectAtIndex:1] integerValue] == [[weakSelf.tipsArray objectAtIndex:1] integerValue]) && ([[weakSelf.inputArray objectAtIndex:2] integerValue] == [[weakSelf.tipsArray objectAtIndex:2] integerValue]);
                if (isCorrect) {
                    [[AwardManager sharedInstance] exchangeAwardWithAwarduuid:weakSelf.model.uuid];
                    [SVProgressHUD showInfoWithStatus:@"兑换成功"];
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }else{
                    [SVProgressHUD setBackgroundColor:RGBCOLOR(241, 141, 172)];
                    [SVProgressHUD showErrorWithStatus:@"输入有误，请重新输入"];
                    [weakSelf.inputArray removeAllObjects];
                }
            }
        };

    }
    return _passwordView;
}

- (UILabel *)tipsLabel{
    if (!_tipsLabel) {
        _tipsLabel = [[UILabel alloc] initWithCustomFont:20.f];
        
        NSString * first = [self changeNumberToString:[[self.tipsArray objectAtIndex:0] integerValue]];
        NSString * second = [self changeNumberToString:[[self.tipsArray objectAtIndex:1] integerValue]];
        NSString * third = [self changeNumberToString:[[self.tipsArray objectAtIndex:2] integerValue]];
        _tipsLabel.text = [NSString stringWithFormat:@"请输入数字%@、%@、%@",first,second,third];
        
        _tipsLabel.textColor = RGBCOLOR(241, 141, 172);
        _tipsLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _tipsLabel;
}

- (NSMutableArray *)inputArray{
    if (!_inputArray) {
        _inputArray = [[NSMutableArray alloc] init];
    }
    return _inputArray;
}

- (NSMutableArray *)tipsArray{
    if (!_tipsArray) {
        _tipsArray = [[NSMutableArray alloc] init];
    }
    return _tipsArray;
}

@end
