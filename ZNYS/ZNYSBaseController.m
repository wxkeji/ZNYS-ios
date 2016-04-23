//
//  ZNYSBaseController.m
//  ZNYS
//
//  Created by Ellise on 16/1/2.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "ZNYSBaseController.h"
#import "AppDelegate.h"

@implementation ZNYSBaseController

#pragma mark life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.nav];
    self.nav.hidden = YES;
    WS(weakSelf, self);
    [self.nav mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view.mas_top).with.offset(0);
        make.left.equalTo(weakSelf.view.mas_left).with.offset(0);
        make.right.equalTo(weakSelf.view.mas_right).with.offset(0);
        make.height.mas_equalTo(CustomHeight(68));
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [TheAppDelegate setCurrentController:self];
}

- (void)backMenuDidPressed
{
    WS(weakSelf, self);
    dispatch_async(dispatch_get_main_queue(), ^{
        NSArray *nav = [[CurrentController navigationController] viewControllers];
        if(![nav indexOfObject:weakSelf]){
            [weakSelf dismissViewControllerAnimated:YES completion:^{}];
        }else{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    });
}

#pragma mark private method

- (void)setNavBarWithTitle:(NSString *)title Color:(UIColor *)color TextColor:(UIColor *)textColor{
    self.nav.title.text = title;
    self.nav.backgroundColor = color;
    self.nav.title.textColor = textColor;
}

#pragma mark getters and setters

- (ZNYSBaseNavigationBar *)nav{
    if (!_nav) {
        _nav = [[ZNYSBaseNavigationBar alloc] init];
    }
    return _nav;
}
@end
