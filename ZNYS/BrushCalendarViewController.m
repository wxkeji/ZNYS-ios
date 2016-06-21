//
//  CalenderViewController.m
//  ZNYS
//
//  Created by yu243e on 16/6/21.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "BrushCalendarViewController.h"
#import "CoreDataHelper.h"

@interface BrushCalendarViewController ()

@property (nonatomic, strong) UIButton * dismissButton;

@property (nonatomic, strong) UIImageView * backgroundImageView;

@property (nonatomic,strong) UIImageView * userImageView;

@property (nonatomic,strong) UILabel * userLabel;

@property (nonatomic,strong) UIImageView * coinView;

@property (nonatomic,strong) UILabel * coinLabel;

@end

@implementation BrushCalendarViewController

#pragma mark life cycle

- (void)dealloc{
    _dismissButton = nil;
    _backgroundImageView = nil;
    _userImageView = nil;
    _userLabel = nil;
    _coinLabel = nil;
    _coinView = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nav.hidden = YES;
    
    [self.view addSubview:self.backgroundImageView];
    [self.view addSubview:self.dismissButton];
    [self.view addSubview:self.userImageView];
    [self.view addSubview:self.userLabel];
    [self.view addSubview:self.coinLabel];
    [self.view addSubview:self.coinView];
    
    WS(weakSelf, self);
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).with.offset(0);
        make.right.equalTo(weakSelf.view.mas_right).with.offset(0);
        make.top.equalTo(weakSelf.view.mas_top).with.offset(0);
        make.bottom.equalTo(weakSelf.view.mas_bottom).with.offset(0);
        //make.height.mas_equalTo(CustomHeight(667));

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
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark private met

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

- (UIView *)backgroundImageView{
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] init];
        _backgroundImageView.image = [UIImage imageNamed:@"brushCalendarBackground"];
        //_backgroundImageView.backgroundColor = [UIColor blueColor];
    }
    return _backgroundImageView;
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

@end
