//
//  SettingHeaderView.h
//  ZNYS
//
//  Created by Ellise on 16/1/4.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "ZNYSBaseView.h"

typedef void(^DismissButtonBlock)();

typedef void(^ThumbButtonBlock)();

@interface SettingHeaderView : ZNYSBaseView

@property (nonatomic,copy) DismissButtonBlock dismissButtonBlock;

@property (nonatomic,copy) ThumbButtonBlock thumbButtonBlock;

@end
