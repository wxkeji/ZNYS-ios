//
//  ZNYSBaseNavigationBar.h
//  ZNYS
//
//  Created by Ellise on 16/4/5.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZNYSBaseNavigationBarDelegate <NSObject>

@optional
- (void)rightButtonClicked;

@end

@interface ZNYSBaseNavigationBar : UIView

@property (nonatomic,strong) UIButton * dismissButton;

@property (nonatomic,strong) UILabel * title;

@property (nonatomic,strong) UIButton * rightButton;

@property (nonatomic,weak) id<ZNYSBaseNavigationBarDelegate> delegate;

@end
