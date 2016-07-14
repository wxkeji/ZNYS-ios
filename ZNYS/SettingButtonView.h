//
//  SettingButtonView.h
//  ZNYS
//
//  Created by Ellise on 16/1/4.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "ZNYSBaseView.h"

#define baseTag 10086
typedef void(^ButtonClickBlock)(NSInteger tag);

@interface SettingButtonView : ZNYSBaseView

@property (nonatomic,copy) ButtonClickBlock buttonClickBlock;

@end
