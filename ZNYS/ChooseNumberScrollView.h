//
//  ChooseNumberScrollView.h
//  ZNYS
//
//  Created by Ellise on 16/4/29.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToolMacroes.h"
#import <Masonry.h>
#import "rewardListModel.h"

@interface ChooseNumberScrollView : UIScrollView

- (instancetype)initWithModel:(rewardListModel *)model andFrame:(CGRect)frame;

@end
