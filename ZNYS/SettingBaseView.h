//
//  SettingBaseView.h
//  ZNYS
//
//  Created by 张恒铭 on 7/11/16.
//  Copyright © 2016 Woodseen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingBaseView : UIView

/**
 *  返回按钮
 */
@property(nonatomic,strong) UIButton* returnButton;
/**
 *  上部分视图
 */
@property(nonatomic,strong) UIView* headerView;

/**
 *  下部分视图
 */
@property(nonatomic,strong) UIView* bottomView;



@end
