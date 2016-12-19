//
//  AddRewardScrollView.m
//  ZNYS
//
//  Created by Ellise on 16/4/30.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "AddRewardScrollView.h"
#import "UserManager.h"

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

- (void)refresh{
    self.pDataArray = nil;
    self.cDataArray = nil;
    self.aDataArray = nil;
    
    for (RewardItemView * item in self.possessScrollView.subviews) {
        [item removeFromSuperview];
    }
    for (RewardItemView * item in self.consumeScrollView.subviews) {
        [item removeFromSuperview];
    }
    for (RewardItemView * item in self.activityScrollView.subviews) {
        [item removeFromSuperview];
    }
    
    [self initConsumeScrollView];
    [self initActivityScrollView];
    [self initPossessScrollView];
}

#pragma mark RewardItemViewDelegate

- (void)addReward:(Award *)model{
    if (self.addRewardBlock) {
        self.addRewardBlock(model);
    }
}

- (void)showNextPage:(Award *)model{

}

#pragma mark private method

- (void)initConsumeScrollView{
    for (NSInteger i = 0; i<self.cDataArray.count; i++) {
        if ([[self.cDataArray objectAtIndex:i].status isEqualToString:@"added"]){
            RewardItemView * item = [[RewardItemView alloc] initWithFrame:CGRectMake(13+(i%3)*CustomWidth(120),(i/3)*CustomHeight(175),CustomWidth(106),CustomHeight(160)) type:CheckType model:[self.cDataArray objectAtIndex:i]];
            item.tag = i;
            item.delegate = self;
            item.model = [self.cDataArray objectAtIndex:i];
            item.selectButton.hidden = YES;
            item.coinLabel.text = [NSString stringWithFormat:@"x %ld",(long)[self.cDataArray objectAtIndex:i].price];
            if ([[self.cDataArray objectAtIndex:i].pitcureURL isEqualToString:@"testImage1"]) {
                item.bgView.backgroundColor = [UIColor greenColor];
            }else if ([[self.cDataArray objectAtIndex:i].pitcureURL isEqualToString:@"testImage2"]){
                item.bgView.backgroundColor = [UIColor redColor];
            }else if ([[self.cDataArray objectAtIndex:i].pitcureURL isEqualToString:@"testImage3"]){
                item.bgView.backgroundColor = [UIColor cyanColor];
            }else{
                item.bgView.backgroundColor = [UIColor yellowColor];
            }
            [_consumeScrollView addSubview:item];
        }else{
            RewardItemView * item = [[RewardItemView alloc] initWithFrame:CGRectMake(13+(i%3)*CustomWidth(120),(i/3)*CustomHeight(175),CustomWidth(106),CustomHeight(160)) type:AddType model:[self.cDataArray objectAtIndex:i]];
            item.tag = i;
            item.delegate = self;
            item.model = [self.cDataArray objectAtIndex:i];
            item.selectButton.hidden = YES;
            item.coinLabel.text = [NSString stringWithFormat:@"x %ld",(long)[self.cDataArray objectAtIndex:i].price];
            if ([[self.cDataArray objectAtIndex:i].pitcureURL isEqualToString:@"testImage1"]) {
                item.bgView.backgroundColor = [UIColor greenColor];
            }else if ([[self.cDataArray objectAtIndex:i].pitcureURL isEqualToString:@"testImage2"]){
                item.bgView.backgroundColor = [UIColor redColor];
            }else if ([[self.cDataArray objectAtIndex:i].pitcureURL isEqualToString:@"testImage3"]){
                item.bgView.backgroundColor = [UIColor cyanColor];
            }else{
                item.bgView.backgroundColor = [UIColor yellowColor];
            }
            [_consumeScrollView addSubview:item];
        }
    }
}

- (void)initPossessScrollView{
    
    for (NSInteger i = 0; i<self.pDataArray.count; i++) {
        if ([[self.pDataArray objectAtIndex:i].status isEqualToString:@"added"]){
            RewardItemView * item = [[RewardItemView alloc] initWithFrame:CGRectMake(13+(i%3)*CustomWidth(120),(i/3)*CustomHeight(175),CustomWidth(106),CustomHeight(160)) type:CheckType model:[self.pDataArray objectAtIndex:i]];
            item.tag = i;
            item.delegate = self;
            item.model = [self.pDataArray objectAtIndex:i];
            item.selectButton.hidden = YES;
            item.coinLabel.text = [NSString stringWithFormat:@"x %ld",(long)[self.pDataArray objectAtIndex:i].price];
            if ([[self.pDataArray objectAtIndex:i].pitcureURL isEqualToString:@"testImage1"]) {
                item.bgView.backgroundColor = [UIColor greenColor];
            }else if ([[self.pDataArray objectAtIndex:i].pitcureURL isEqualToString:@"testImage2"]){
                item.bgView.backgroundColor = [UIColor redColor];
            }else if ([[self.pDataArray objectAtIndex:i].pitcureURL isEqualToString:@"testImage3"]){
                item.bgView.backgroundColor = [UIColor cyanColor];
            }else{
                item.bgView.backgroundColor = [UIColor yellowColor];
            }
            [_possessScrollView addSubview:item];
        }else{
            RewardItemView * item = [[RewardItemView alloc] initWithFrame:CGRectMake(13+(i%3)*CustomWidth(120),(i/3)*CustomHeight(175),CustomWidth(106),CustomHeight(160)) type:AddType model:[self.pDataArray objectAtIndex:i]];
            item.tag = i;
            item.delegate = self;
            item.model = [self.pDataArray objectAtIndex:i];
            item.selectButton.hidden = YES;
            item.coinLabel.text = [NSString stringWithFormat:@"x %ld",(long)[self.pDataArray objectAtIndex:i].price];
            if ([[self.pDataArray objectAtIndex:i].pitcureURL isEqualToString:@"testImage1"]) {
                item.bgView.backgroundColor = [UIColor greenColor];
            }else if ([[self.pDataArray objectAtIndex:i].pitcureURL isEqualToString:@"testImage2"]){
                item.bgView.backgroundColor = [UIColor redColor];
            }else if ([[self.pDataArray objectAtIndex:i].pitcureURL isEqualToString:@"testImage3"]){
                item.bgView.backgroundColor = [UIColor cyanColor];
            }else{
                item.bgView.backgroundColor = [UIColor yellowColor];
            }
            [_possessScrollView addSubview:item];
            
        }
    }
}

- (void)initActivityScrollView{
    for (NSInteger i = 0; i<self.aDataArray.count; i++) {
        if ([[self.aDataArray objectAtIndex:i].status isEqualToString:@"added"]){
            RewardItemView * item = [[RewardItemView alloc] initWithFrame:CGRectMake(13+(i%3)*CustomWidth(120),(i/3)*CustomHeight(175),CustomWidth(106),CustomHeight(160)) type:CheckType model:[self.aDataArray objectAtIndex:i]];
            item.tag = i;
            item.delegate = self;
            item.model = [self.aDataArray objectAtIndex:i];
            item.selectButton.hidden = YES;
            item.coinLabel.text = [NSString stringWithFormat:@"x %ld",(long)[self.aDataArray objectAtIndex:i].price];
            if ([[self.aDataArray objectAtIndex:i].pitcureURL isEqualToString:@"testImage1"]) {
                item.bgView.backgroundColor = [UIColor greenColor];
            }else if ([[self.aDataArray objectAtIndex:i].pitcureURL isEqualToString:@"testImage2"]){
                item.bgView.backgroundColor = [UIColor redColor];
            }else if ([[self.aDataArray objectAtIndex:i].pitcureURL isEqualToString:@"testImage3"]){
                item.bgView.backgroundColor = [UIColor cyanColor];
            }else{
                item.bgView.backgroundColor = [UIColor yellowColor];
            }
            
            [_activityScrollView addSubview:item];
        }else{
            RewardItemView * item = [[RewardItemView alloc] initWithFrame:CGRectMake(13+(i%3)*CustomWidth(120),(i/3)*CustomHeight(175),CustomWidth(106),CustomHeight(160)) type:AddType model:[self.aDataArray objectAtIndex:i]];
            item.tag = i;
            item.delegate = self;
            item.model = [self.aDataArray objectAtIndex:i];
            item.selectButton.hidden = YES;
            item.coinLabel.text = [NSString stringWithFormat:@"x %ld",(long)[self.aDataArray objectAtIndex:i].price];
            if ([[self.aDataArray objectAtIndex:i].pitcureURL isEqualToString:@"testImage1"]) {
                item.bgView.backgroundColor = [UIColor greenColor];
            }else if ([[self.aDataArray objectAtIndex:i].pitcureURL isEqualToString:@"testImage2"]){
                item.bgView.backgroundColor = [UIColor redColor];
            }else if ([[self.aDataArray objectAtIndex:i].pitcureURL isEqualToString:@"testImage3"]){
                item.bgView.backgroundColor = [UIColor cyanColor];
            }else{
                item.bgView.backgroundColor = [UIColor yellowColor];
            }
            
            [_activityScrollView addSubview:item];
        }
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
        [self initConsumeScrollView];
    }
    return _consumeScrollView;
}

- (UIScrollView *)possessScrollView{
    if (!_possessScrollView) {
        _possessScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(kSCREEN_WIDTH, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
        _possessScrollView.backgroundColor = [UIColor whiteColor];
        _possessScrollView.contentSize = CGSizeMake(kSCREEN_WIDTH, ((self.pDataArray.count/3)+1)*CustomHeight(200));
        [self initPossessScrollView];
    }
    return _possessScrollView;
}

- (UIScrollView *)activityScrollView{
    if (!_activityScrollView) {
        _activityScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(kSCREEN_WIDTH*2, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
        _activityScrollView.backgroundColor = [UIColor whiteColor];
        _activityScrollView.contentSize = CGSizeMake(kSCREEN_WIDTH, ((self.aDataArray.count/3)+1)*CustomHeight(200));
        [self initActivityScrollView];
    }
    return _activityScrollView;
}

- (NSMutableArray<Award *> *)cDataArray{
    if (!_cDataArray) {
        _cDataArray = [[NSMutableArray alloc] init];
        NSMutableArray<Award *> *cNotAddedArray = [[[AwardManager sharedInstance] getNotAddedAwardWithUseruuid:[[UserManager sharedInstance] currentUserUUID]] objectAtIndex:0];
        NSMutableArray<Award *> *cAddedArray = [[[AwardManager sharedInstance] getAddedAwardWithUseruuid:[[UserManager sharedInstance] currentUserUUID]] objectAtIndex:0];
        for (Award * award in cAddedArray) {
            [_cDataArray addObject:award];
        }
        for (Award * award in cNotAddedArray) {
            [_cDataArray addObject:award];
        }
    }
    return _cDataArray;
}

- (NSMutableArray<Award *> *)pDataArray{
    if (!_pDataArray) {
        _pDataArray = [[NSMutableArray alloc] init];
        NSMutableArray<Award *> *pNotAddedArray = [[[AwardManager sharedInstance] getNotAddedAwardWithUseruuid:[[UserManager sharedInstance] currentUserUUID]] objectAtIndex:1];
        NSMutableArray<Award *> *pAddedArray = [[[AwardManager sharedInstance] getAddedAwardWithUseruuid:[[UserManager sharedInstance] currentUserUUID]] objectAtIndex:1];
        for (Award * award in pAddedArray) {
            [_pDataArray addObject:award];
        }
        for (Award * award in pNotAddedArray) {
            [_pDataArray addObject:award];
        }
    }
    return _pDataArray;
}

- (NSMutableArray<Award *> *)aDataArray{
    if (!_aDataArray) {
        _aDataArray = [[NSMutableArray alloc] init];
        NSMutableArray<Award *> *aNotAddedArray = [[[AwardManager sharedInstance] getNotAddedAwardWithUseruuid:[[UserManager sharedInstance] currentUserUUID]] objectAtIndex:2];
        NSMutableArray<Award *> *aAddedArray = [[[AwardManager sharedInstance] getAddedAwardWithUseruuid:[[UserManager sharedInstance] currentUserUUID]] objectAtIndex:2];
        for (Award * award in aAddedArray) {
            [_aDataArray addObject:award];
        }
        for (Award * award in aNotAddedArray) {
            [_aDataArray addObject:award];
        }
    }
    return _aDataArray;
}

@end
