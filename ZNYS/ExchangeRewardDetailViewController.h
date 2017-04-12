//
//  ExchangeRewardDetailViewController.h
//  ZNYS
//
//  Created by Ellise on 16/5/3.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "ZNYSBaseController.h"
#import "Award+CoreDataClass.h"
#import "RewardItemView.h"

@interface ExchangeRewardDetailViewController : ZNYSBaseController<RewardItemViewDelegate>

@property (nonatomic,strong) Award * model;

- (instancetype)initWithModel:(Award *)model;

@end
