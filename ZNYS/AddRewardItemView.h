//
//  AddRewardItemView.h
//  ZNYS
//
//  Created by Ellise on 16/4/22.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "ZNYSBaseView.h"

@protocol AddRewardItemViewDelegate <NSObject>

- (void)showAddRewardDetailView;

@end

@interface AddRewardItemView : ZNYSBaseView

@property (nonatomic,strong) UILabel * coinLabel;

@property (nonatomic,strong) UIButton * bottomButton;

@property (nonatomic,strong) UIImageView * backgroundView;

@property (nonatomic,assign) BOOL isAdded;

@property (nonatomic,weak) id<AddRewardItemViewDelegate> delegate;

@end
