//
//  ExchangeRewardDetailViewController.h
//  ZNYS
//
//  Created by Ellise on 16/5/3.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "ZNYSBaseController.h"
#import "rewardListModel.h"
#import "RewardItemView.h"

@interface ExchangeRewardDetailViewController : ZNYSBaseController<RewardItemViewDelegate>

@property (nonatomic,strong) rewardListModel * model;

- (instancetype)initWithModel:(rewardListModel *)model;

@end
