//
//  AddRewardView.h
//  ZNYS
//
//  Created by Ellise on 16/4/29.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "ZNYSBaseView.h"
#import "rewardListModel.h"

@interface AddRewardView : ZNYSBaseView<UIPickerViewDelegate,UIPickerViewDataSource,UIScrollViewDelegate>

@property (nonatomic,strong) rewardListModel * model;

//- (instancetype)initWithRange:(NSInteger)range startFrom:(NSInteger)startNum;

- (instancetype)initWithModel:(rewardListModel *)model;

@end
