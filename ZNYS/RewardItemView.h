//
//  RewardItemView.h
//  ZNYS
//
//  Created by Ellise on 16/1/14.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "ZNYSBaseView.h"
#import "Award.h"

@protocol RewardItemViewDelegate <NSObject>

@optional
- (void)startDelete;
- (void)playRecord:(Award *)model;
- (void)addReward:(Award *)model;
- (void)showNextPage:(Award *)model;

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

@property (nonatomic,strong) Award * model;

@property (nonatomic,weak) id<RewardItemViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame type:(ItemType)type model:(Award *)model;

@end
