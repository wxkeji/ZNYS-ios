//
//  AddRewardScrollView.h
//  ZNYS
//
//  Created by Ellise on 16/4/30.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "ZNYSBaseView.h"
#import "rewardListModel.h"
#import "RewardItemView.h"

typedef void(^AddRewardBlock)(rewardListModel * model);

@interface AddRewardScrollView : ZNYSBaseView<RewardItemViewDelegate>

@property (nonatomic,strong) UIScrollView * scrollView;

@property (nonatomic,strong) NSMutableArray<rewardListModel *> * cDataArray;

@property (nonatomic,strong) NSMutableArray<rewardListModel *> * pDataArray;

@property (nonatomic,strong) NSMutableArray<rewardListModel *> * aDataArray;

@property (nonatomic,strong) UIScrollView * consumeScrollView;

@property (nonatomic,strong) UIScrollView * possessScrollView;

@property (nonatomic,strong) UIScrollView * activityScrollView;

@property (nonatomic,copy) AddRewardBlock addRewardBlock;

@end
