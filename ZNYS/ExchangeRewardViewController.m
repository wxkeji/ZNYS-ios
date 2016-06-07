//
//  ExchangeRewardViewController.m
//  ZNYS
//
//  Created by Ellise on 16/5/3.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "ExchangeRewardViewController.h"
#import "Award.h"
#import "CoreDataHelper.h"
#import "AwardManager.h"
#import "ExchangeRewardDetailViewController.h"

@interface ExchangeRewardViewController ()

@property (nonatomic,strong) UIButton * dismissButton;

@property (nonatomic,strong) UIScrollView * itemScrollView;

@property (nonatomic,strong) UIView * backgroundView;

@property (nonatomic,strong) UIImageView * userImageView;

@property (nonatomic,strong) UILabel * userLabel;

@property (nonatomic,strong) UIImageView * coinView;

@property (nonatomic,strong) UILabel * coinLabel;

@property (nonatomic,strong) NSMutableArray<Award *> * dataArray;

@end

@implementation ExchangeRewardViewController

#pragma mark life cycle

- (void)dealloc{
    _dismissButton = nil;
    _itemScrollView = nil;
    _backgroundView = nil;
    _userImageView = nil;
    _userLabel = nil;
    _coinLabel = nil;
    _coinView = nil;
    _dataArray = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.nav.hidden = YES;
    
    [self.view addSubview:self.backgroundView];
    [self.view addSubview:self.dismissButton];
    [self.view addSubview:self.userImageView];
    [self.view addSubview:self.userLabel];
    [self.view addSubview:self.coinLabel];
    [self.view addSubview:self.coinView];
    [self.view addSubview:self.itemScrollView];
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
    
    [self.itemScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.backgroundView.mas_bottom).with.offset(0);
        make.left.equalTo(weakSelf.view.mas_left).with.offset(0);
        make.right.equalTo(weakSelf.view.mas_right).with.offset(0);
        make.bottom.equalTo(weakSelf.view.mas_bottom).with.offset(0);
    }];
}

#pragma mark RewardItemViewDelegate

- (void)playRecord:(Award *)model{
    NSLog(@"vvvv");
}

- (void)showNextPage:(Award *)model{
    ExchangeRewardDetailViewController * vc = [[ExchangeRewardDetailViewController alloc] initWithModel:model];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark private method

- (void)refresh{
    self.coinLabel.text = [NSString stringWithFormat:@"%@",[User currentUserTokenOwned]];
    
    for (RewardItemView * item in self.itemScrollView.subviews) {
        [item removeFromSuperview];
    }
    self.dataArray = nil;
    
    self.dataArray = [[AwardManager sharedInstance] getAllAddedAwardWithUseruuid:[User currentUserUUID]];
    [self initItemScrollView];
}

- (void)initItemScrollView{

    CGFloat width = CustomWidth(107);
    CGFloat height = CustomHeight(142);
    
    for (NSInteger i = 0; i<self.dataArray.count; i++) {
        RewardItemView * item = [[RewardItemView alloc] initWithFrame:CGRectMake(13+(i%3)*CustomWidth(120),CustomHeight(14)+(i/3)*CustomHeight(175),width,height) type:RecordType model:[self.dataArray objectAtIndex:i]];
        item.tag = [self.dataArray objectAtIndex:i].price;
        item.selectButton.hidden = YES;
        item.coinLabel.text = [NSString stringWithFormat:@"x %ld",(long)[self.dataArray objectAtIndex:i].price];
        if ([[self.dataArray objectAtIndex:i].pitcureURL isEqualToString:@"testImage1"]) {
            item.bgView.backgroundColor = [UIColor greenColor];
        }else if ([[self.dataArray objectAtIndex:i].pitcureURL isEqualToString:@"testImage2"]){
            item.bgView.backgroundColor = [UIColor redColor];
        }else if ([[self.dataArray objectAtIndex:i].pitcureURL isEqualToString:@"testImage3"]){
            item.bgView.backgroundColor = [UIColor cyanColor];
        }else{
            item.bgView.backgroundColor = [UIColor yellowColor];
        }
        item.delegate = self;
        item.model = [self.dataArray objectAtIndex:i];
        [_itemScrollView addSubview:item];
    }
    
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

- (UIScrollView *)itemScrollView{
    if (!_itemScrollView) {
        _itemScrollView = [[UIScrollView alloc] init];
        _itemScrollView.backgroundColor = [UIColor whiteColor];
        _itemScrollView.delegate = self;
        _itemScrollView.contentSize = CGSizeMake(kSCREEN_WIDTH, ((self.dataArray.count/3)+1)*CustomHeight(200));
        _itemScrollView.pagingEnabled = NO;
        _itemScrollView.showsVerticalScrollIndicator = FALSE;
        _itemScrollView.showsHorizontalScrollIndicator = YES;
        
        [self initItemScrollView];
          }
    return _itemScrollView;
}

- (NSMutableArray<Award*> *)dataArray{
   
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
        _dataArray = [[AwardManager sharedInstance] getAllAddedAwardWithUseruuid:[User currentUserUUID]];
    }
    return _dataArray;
}

@end
