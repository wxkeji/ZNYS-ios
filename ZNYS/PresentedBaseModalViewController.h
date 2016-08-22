//
//  PresentedBaseModalViewController.h
//  ZNYS
//
//  Created by yu243e on 16/8/18.
//  Copyright © 2016年 Woodseen. All rights reserved.
//
//  继承不是很好的方法，但是能节省一些复制粘贴，暂时这样。
#import "ZNYSBaseController.h"

@interface PresentedBaseModalViewController : ZNYSBaseController

- (void)dismissModalView;
- (void)setBackgroundViewAlpha:(CGFloat)alpha;
@end
