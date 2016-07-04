//
//  ZNYSBaseController.h
//  ZNYS
//
//  Created by Ellise on 16/1/2.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZNYSBaseNavigationBar.h"
#import "ToolMacroes.h"
#import <Masonry.h>
#import <SVProgressHUD.h>
#import "UILabel+Font.h"
#import "UITextField+Font.h"
#import "UIButton+Font.h"
#import "NSDate+Helper.h"


@interface ZNYSBaseController : UIViewController

@property (nonatomic,strong) ZNYSBaseNavigationBar * nav;

- (void)backMenuDidPressed;
- (void)setNavBarWithTitle:(NSString *)title Color:(UIColor *)color TextColor:(UIColor *)textColor;

@end
