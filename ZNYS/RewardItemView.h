//
//  RewardItemView.h
//  ZNYS
//
//  Created by Ellise on 16/1/14.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "ZNYSBaseView.h"

@protocol RewardItemViewDelegate <NSObject>

- (void)startDelete;

@end

@interface RewardItemView : ZNYSBaseView

@property (nonatomic,strong) UIImageView * bgView;

@property (nonatomic,strong) UILabel * coinLabel;

@property (nonatomic,strong) UIButton * selectButton;

@property (nonatomic,assign) BOOL isSelected;

@property (nonatomic,weak) id<RewardItemViewDelegate> delegate;

@end
