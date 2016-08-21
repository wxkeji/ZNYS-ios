//
//  PresentedBaseModalViewController.h
//  ZNYS
//
//  Created by yu243e on 16/8/18.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "ZNYSBaseController.h"

@interface PresentedBaseModalViewController : ZNYSBaseController



//自定义 View 的 getter方法
@property (nonatomic, strong) UIView *customView;
//实现layoutPageSubviews方法加入约束
//Override viewWillAppear 方法设置 frame

- (void)dismissModalView;
- (void)setBackgroundViewAlpha:(CGFloat)alpha;


@end
