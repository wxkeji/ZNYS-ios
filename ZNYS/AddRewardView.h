//
//  AddRewardView.h
//  ZNYS
//
//  Created by Ellise on 16/4/29.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "ZNYSBaseView.h"
#import "rewardListModel.h"
#import <AVFoundation/AVFoundation.h>

typedef void(^DismissBlock)();

@interface AddRewardView : ZNYSBaseView<UIPickerViewDelegate,UIPickerViewDataSource,UIScrollViewDelegate,AVAudioRecorderDelegate>

@property (nonatomic,strong) rewardListModel * model;

@property (nonatomic,copy) DismissBlock dismissBlock;

//- (instancetype)initWithRange:(NSInteger)range startFrom:(NSInteger)startNum;

- (instancetype)initWithModel:(rewardListModel *)model;

@end
