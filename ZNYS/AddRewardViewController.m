//
//  AddRewardViewController.m
//  ZNYS
//
//  Created by Ellise on 16/4/29.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "AddRewardViewController.h"
#import "AddRewardView.h"
#import "AddRewardScrollView.h"
#import "MAKAFakeRootAlertView.h"

@interface AddRewardViewController ()

@property (nonatomic,strong) UIButton * consumeButton;

@property (nonatomic,strong) UIButton * possessButton;

@property (nonatomic,strong) UIButton * activityButton;

@property (nonatomic,strong) AddRewardScrollView * scrollView;

@end

@implementation AddRewardViewController

#pragma mark life cycle

- (void)dealloc{
    _consumeButton = nil;
    _possessButton = nil;
    _activityButton = nil;
    _scrollView = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nav.hidden = NO;
    self.nav.delegate = self;
    UIColor * backColor = [UIColor redColor];
    UIColor * titleColor = [UIColor whiteColor];
    [self setNavBarWithTitle:@"添加奖励" Color:backColor TextColor:titleColor];

    [self.view addSubview:self.consumeButton];
    [self.view addSubview:self.possessButton];
    [self.view addSubview:self.activityButton];
    [self.view addSubview:self.scrollView];
    
    self.consumeButton.selected = YES;
    self.consumeButton.backgroundColor = [UIColor blueColor];
    
    WS(weakSelf, self);
    [self.consumeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).with.offset(CustomWidth(13));
        make.top.equalTo(weakSelf.nav.mas_bottom).with.offset(CustomHeight(14));
        make.width.mas_equalTo(CustomWidth(105));
        make.height.mas_equalTo(CustomHeight(33));
    }];
    
    [self.possessButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
        make.centerY.mas_equalTo(weakSelf.consumeButton.mas_centerY);
        make.width.mas_equalTo(CustomWidth(105));
        make.height.mas_equalTo(CustomHeight(33));
    }];
    
    [self.activityButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.view.mas_right).with.offset(-CustomWidth(13));
        make.centerY.mas_equalTo(weakSelf.consumeButton.mas_centerY);
        make.width.mas_equalTo(CustomWidth(105));
        make.height.mas_equalTo(CustomHeight(33));
    }];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).with.offset(0);
        make.top.equalTo(weakSelf.consumeButton.mas_bottom).with.offset(24);
        make.right.equalTo(weakSelf.view.mas_right).with.offset(0);
        make.bottom.equalTo(weakSelf.view.mas_bottom).with.offset(0);
    }];
}

#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x<kSCREEN_WIDTH) {
        self.consumeButton.selected = YES;
        self.possessButton.selected = NO;
        self.activityButton.selected = NO;
        self.consumeButton.backgroundColor = [UIColor blueColor];
        self.possessButton.backgroundColor = [UIColor whiteColor];
        self.activityButton.backgroundColor = [UIColor whiteColor];
    }else if(scrollView.contentOffset.x>=kSCREEN_WIDTH && scrollView.contentOffset.x<kSCREEN_WIDTH*2){
        self.possessButton.selected = YES;
        self.consumeButton.selected = NO;
        self.activityButton.selected = NO;
        self.possessButton.backgroundColor = [UIColor blueColor];
        self.consumeButton.backgroundColor = [UIColor whiteColor];
        self.activityButton.backgroundColor = [UIColor whiteColor];
    }else if (scrollView.contentOffset.x>=kSCREEN_WIDTH*2){
        self.activityButton.selected = YES;
        self.consumeButton.selected = NO;
        self.possessButton.selected = NO;
        self.activityButton.backgroundColor = [UIColor blueColor];
        self.possessButton.backgroundColor = [UIColor whiteColor];
        self.consumeButton.backgroundColor = [UIColor whiteColor];
    }
}

#pragma mark RewardItemViewDelegate

- (void)addReward:(NSInteger)start range:(NSInteger)range{
    AddRewardView * addRewardView = [[AddRewardView alloc] init];
    
    MAKAFakeRootAlertView * alertView = [[MAKAFakeRootAlertView alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    [alertView setUpView:addRewardView];
    alertView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [alertView show];
}

#pragma mark event action

- (void)consumeButtonClicked{
    self.consumeButton.selected = YES;
    self.possessButton.selected = NO;
    self.activityButton.selected = NO;
    self.consumeButton.backgroundColor = [UIColor blueColor];
    self.possessButton.backgroundColor = [UIColor whiteColor];
    self.activityButton.backgroundColor = [UIColor whiteColor];
    
    [UIView animateWithDuration:0.2f animations:^{
        self.scrollView.scrollView.contentOffset = CGPointMake(0, 0);
    }];
}

- (void)possessButtonClicked{
    self.possessButton.selected = YES;
    self.consumeButton.selected = NO;
    self.activityButton.selected = NO;
    self.possessButton.backgroundColor = [UIColor blueColor];
    self.consumeButton.backgroundColor = [UIColor whiteColor];
    self.activityButton.backgroundColor = [UIColor whiteColor];
    
    [UIView animateWithDuration:0.2f animations:^{
       self.scrollView.scrollView.contentOffset = CGPointMake(kSCREEN_WIDTH, 0);
    }];
}

- (void)activityButtonClicked{
    self.activityButton.selected = YES;
    self.consumeButton.selected = NO;
    self.possessButton.selected = NO;
    self.activityButton.backgroundColor = [UIColor blueColor];
    self.possessButton.backgroundColor = [UIColor whiteColor];
    self.consumeButton.backgroundColor = [UIColor whiteColor];
    
    [UIView animateWithDuration:0.2f animations:^{
        self.scrollView.scrollView.contentOffset = CGPointMake(kSCREEN_WIDTH*2, 0);
    }];
}

#pragma mark getters and setters

- (UIButton *)consumeButton{
    if (!_consumeButton) {
        _consumeButton = [[UIButton alloc] initWithCustomFont:20.f];
        _consumeButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_consumeButton.layer setBorderWidth:2.f];
        [_consumeButton.layer setCornerRadius:5.f];
        [_consumeButton setTitle:@"消费类" forState:UIControlStateNormal];
        [_consumeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_consumeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_consumeButton addTarget:self action:@selector(consumeButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _consumeButton;
}

- (UIButton *)possessButton{
    if (!_possessButton) {
        _possessButton = [[UIButton alloc] initWithCustomFont:20.f];
        _possessButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_possessButton.layer setBorderWidth:2.f];
        [_possessButton.layer setCornerRadius:5.f];
        [_possessButton setTitle:@"拥有类" forState:UIControlStateNormal];
        [_possessButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_possessButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_possessButton addTarget:self action:@selector(possessButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _possessButton;
}

- (UIButton *)activityButton{
    if (!_activityButton) {
        _activityButton = [[UIButton alloc] initWithCustomFont:20.f];
        _activityButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_activityButton.layer setBorderWidth:2.f];
        [_activityButton.layer setCornerRadius:5.f];
        [_activityButton setTitle:@"活动类" forState:UIControlStateNormal];
        [_activityButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_activityButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_activityButton addTarget:self action:@selector(activityButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _activityButton;
}

- (AddRewardScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[AddRewardScrollView alloc] init];
        _scrollView.scrollView.delegate = self;
        
        _scrollView.addRewardBlock = ^(rewardListModel * model){
            AddRewardView * addRewardView = [[AddRewardView alloc] initWithModel:model];
            addRewardView.frame = CGRectMake(0, 0, CustomWidth(300), CustomHeight(350));
            
            MAKAFakeRootAlertView * alertView = [[MAKAFakeRootAlertView alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
            [alertView setUpView:addRewardView];
            alertView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
            [alertView show];
        };
    }
    return _scrollView;
}

@end
