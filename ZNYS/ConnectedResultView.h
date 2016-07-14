//
//  ConnectedResultView.h
//  ZNYS
//
//  Created by yu243e on 16/7/14.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "ZNYSBaseView.h"

typedef void(^DismissBlock)();

@interface ConnectedResultView : ZNYSBaseView<UIScrollViewDelegate>


@property (nonatomic, copy) DismissBlock dismissBlock;

@end
