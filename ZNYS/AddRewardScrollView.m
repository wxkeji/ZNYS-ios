//
//  AddRewardScrollView.m
//  ZNYS
//
//  Created by Ellise on 16/4/30.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "AddRewardScrollView.h"

@interface AddRewardScrollView()

@end

@implementation AddRewardScrollView

#pragma mark life cycle

- (void)dealloc{
    _scrollView = nil;
    _consumeScrollView = nil;
    _possessScrollView = nil;
    _activityScrollView = nil;
    _cDataArray = nil;
    _pDataArray = nil;
    _aDataArray = nil;
    _addRewardBlock = nil;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.scrollView];
    }
    return self;
}

#pragma mark RewardItemViewDelegate

- (void)addReward:(rewardListModel *)model{
    if (self.addRewardBlock) {
        self.addRewardBlock(model);
    }
}

#pragma mark getters and setters

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
        _scrollView.backgroundColor = [UIColor yellowColor];
        _scrollView.contentSize = CGSizeMake(kSCREEN_WIDTH*3, 0);
        _scrollView.pagingEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = FALSE;
        _scrollView.showsHorizontalScrollIndicator = FALSE;
        [_scrollView addSubview:self.consumeScrollView];
        [_scrollView addSubview:self.possessScrollView];
        [_scrollView addSubview:self.activityScrollView];
    }
    return _scrollView;
}

- (UIScrollView *)consumeScrollView{
    if (!_consumeScrollView) {
        _consumeScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
        _consumeScrollView.backgroundColor = [UIColor whiteColor];
        _consumeScrollView.contentSize = CGSizeMake(kSCREEN_WIDTH, ((self.cDataArray.count/3)+1)*CustomHeight(200));
        
        for (NSInteger i = 0; i<self.cDataArray.count; i++) {
            RewardItemView * item = [[RewardItemView alloc] initWithFrame:CGRectMake(13+(i%3)*CustomWidth(120),(i/3)*CustomHeight(175),CustomWidth(106),CustomHeight(160)) type:AddType model:[self.cDataArray objectAtIndex:i]];
            item.tag = i;
            item.delegate = self;
            item.selectButton.hidden = YES;
            item.coinLabel.text = [NSString stringWithFormat:@"x %ld",(long)[self.cDataArray objectAtIndex:i].coins];
            [_consumeScrollView addSubview:item];
        }
    }
    return _consumeScrollView;
}

- (UIScrollView *)possessScrollView{
    if (!_possessScrollView) {
        _possessScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(kSCREEN_WIDTH, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
        _possessScrollView.backgroundColor = [UIColor whiteColor];
        _possessScrollView.contentSize = CGSizeMake(kSCREEN_WIDTH, ((self.pDataArray.count/3)+1)*CustomHeight(200));
        
        for (NSInteger i = 0; i<self.pDataArray.count; i++) {
            RewardItemView * item = [[RewardItemView alloc] initWithFrame:CGRectMake(13+(i%3)*CustomWidth(120),(i/3)*CustomHeight(175),CustomWidth(106),CustomHeight(160)) type:AddType model:[self.pDataArray objectAtIndex:i]];
            item.tag = i;
            item.delegate = self;
            item.selectButton.hidden = YES;
            item.coinLabel.text = [NSString stringWithFormat:@"x %ld",(long)[self.pDataArray objectAtIndex:i].coins];
            [_possessScrollView addSubview:item];
        }
    }
    return _possessScrollView;
}

- (UIScrollView *)activityScrollView{
    if (!_activityScrollView) {
        _activityScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(kSCREEN_WIDTH*2, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
        _activityScrollView.backgroundColor = [UIColor whiteColor];
        _activityScrollView.contentSize = CGSizeMake(kSCREEN_WIDTH, ((self.aDataArray.count/3)+1)*CustomHeight(200));
        
        for (NSInteger i = 0; i<self.aDataArray.count; i++) {
            RewardItemView * item = [[RewardItemView alloc] initWithFrame:CGRectMake(13+(i%3)*CustomWidth(120),(i/3)*CustomHeight(175),CustomWidth(106),CustomHeight(160)) type:AddType model:[self.aDataArray objectAtIndex:i]];
            item.tag = i;
            item.delegate = self;
            item.selectButton.hidden = YES;
            item.coinLabel.text = [NSString stringWithFormat:@"x %ld",(long)[self.aDataArray objectAtIndex:i].coins];
            [_activityScrollView addSubview:item];
        }
    }
    return _activityScrollView;
}

- (NSMutableArray<rewardListModel *> *)cDataArray{
    if (!_cDataArray) {
        _cDataArray = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i<15; i++) {
            rewardListModel * model = [[rewardListModel alloc] init];
            model.coins = i;
            model.range = i+5;
            [_cDataArray addObject:model];
        }
    }
    return _cDataArray;
}

- (NSMutableArray<rewardListModel *> *)pDataArray{
    if (!_pDataArray) {
        _pDataArray = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i<5; i++) {
            rewardListModel * model = [[rewardListModel alloc] init];
            model.coins = i;
            model.range = i+5;
            [_pDataArray addObject:model];
        }
    }
    return _pDataArray;
}

- (NSMutableArray<rewardListModel *> *)aDataArray{
    if (!_aDataArray) {
        _aDataArray = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i<20; i++) {
            rewardListModel * model = [[rewardListModel alloc] init];
            model.coins = i;
            model.range = i+9;
            [_aDataArray addObject:model];
        }
    }
    return _aDataArray;
}

@end
