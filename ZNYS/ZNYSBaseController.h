//
//  ZNYSBaseController.h
//  ZNYS
//
//  Created by Ellise on 16/1/2.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToolMacroes.h"
#import "CatogoriesImportHelper.h"
#import "ThemeManager.h"
#import <Masonry.h>
#import <SVProgressHUD.h>

#import "ZNYSBaseNavigationBar.h"

@interface ZNYSBaseController : UIViewController

@property (nonatomic,strong) ZNYSBaseNavigationBar * nav;

- (void)backMenuDidPressed;
- (void)setNavBarWithTitle:(NSString *)title Color:(UIColor *)color TextColor:(UIColor *)textColor;

@end
