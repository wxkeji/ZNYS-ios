//
//  VerifyPasswordView.h
//  ZNYS
//
//  Created by Ellise on 16/1/2.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "ZNYSBaseView.h"

typedef void(^ButtonClickBlock)(NSInteger number);

@interface VerifyPasswordView : ZNYSBaseView

@property (nonatomic,copy) ButtonClickBlock buttonClickBlock;

@end
