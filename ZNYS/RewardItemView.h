//
//  RewardItemView.h
//  ZNYS
//
//  Created by Ellise on 16/1/14.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "ZNYSBaseView.h"
#import "rewardListModel.h"

@protocol RewardItemViewDelegate <NSObject>

@optional
- (void)startDelete;
- (void)playRecord:(rewardListModel *)model;
- (void)addReward:(rewardListModel *)model;
- (void)showNextPage:(rewardListModel *)model;

@end

typedef enum : NSUInteger {
    RecordType = 0,
    AddType = 1,
    CheckType = 2,
} ItemType;

@interface RewardItemView : ZNYSBaseView

@property (nonatomic,strong) UIImageView * bgView;

@property (nonatomic,strong) UILabel * coinLabel;

@property (nonatomic,strong) UIButton * selectButton;

@property (nonatomic,assign) BOOL isSelected;

@property (nonatomic,strong) UIButton * bottomButton;

@property (nonatomic,assign) ItemType itemType;

@property (nonatomic,strong) rewardListModel * model;

@property (nonatomic,weak) id<RewardItemViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame type:(ItemType)type model:(rewardListModel *)model;

@end
