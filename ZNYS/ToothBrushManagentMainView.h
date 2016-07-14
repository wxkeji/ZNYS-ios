//
//  ToothBrushManagentMainView.h
//  ZNYS
//
//  Created by 张恒铭 on 6/12/16.
//  Copyright © 2016 Woodseen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingBaseView.h"

@protocol ToothBrushMangementViewControllerProtocol <NSObject>

- (void)onBrushButtonClicked:(UIButton*)brushButton;

@end

@interface ToothBrushManagentMainView : SettingBaseView

- (instancetype)initWithFrame:(CGRect)frame;

- (void)setToothBrushNumber:(NSInteger)number;

- (void)setUserNickname:(NSString*)nickname;

@property(nonatomic,weak) id<ToothBrushMangementViewControllerProtocol> viewController;

@end
