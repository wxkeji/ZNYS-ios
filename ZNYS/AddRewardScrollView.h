//
//  AddRewardScrollView.h
//  ZNYS
//
//  Created by Ellise on 16/4/30.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "ZNYSBaseView.h"
#import "Award+CoreDataClass.h"
#import "CoreDataHelper.h"
#import "AwardManager.h"
#import "RewardItemView.h"

typedef void(^AddRewardBlock)(Award * model);

@interface AddRewardScrollView : ZNYSBaseView<RewardItemViewDelegate>

@property (nonatomic,strong) UIScrollView * scrollView;

@property (nonatomic,strong) NSMutableArray<Award *> * cDataArray;

@property (nonatomic,strong) NSMutableArray<Award *> * pDataArray;

@property (nonatomic,strong) NSMutableArray<Award *> * aDataArray;

@property (nonatomic,strong) UIScrollView * consumeScrollView;

@property (nonatomic,strong) UIScrollView * possessScrollView;

@property (nonatomic,strong) UIScrollView * activityScrollView;

@property (nonatomic,copy) AddRewardBlock addRewardBlock;

- (void)refresh;

@end
