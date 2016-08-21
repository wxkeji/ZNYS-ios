//
//  PresentedBaseModalViewController.m
//  ZNYS
//
//  Created by yu243e on 16/8/18.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "PresentedBaseModalViewController.h"

@interface PresentedBaseModalViewController ()
@property (nonatomic, strong) UIButton *backgroundButton;

@end

@implementation PresentedBaseModalViewController
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.backgroundButton];
    [self.backgroundButton addTarget:self action:@selector(backgroundButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self setBackgroundViewAlpha:0.5];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.backgroundButton.frame = self.view.frame;
}

#pragma mark - event response
- (void)backgroundButtonClick {
    [self dismissModalView];
}

#pragma mark - public methods
- (void)dismissModalView {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setBackgroundViewAlpha:(CGFloat)alpha {
    self.view.backgroundColor = [UIColor clearColor];
    self.backgroundButton.backgroundColor = RGBACOLOR(0, 0, 0, alpha);
}

#pragma mark - getters and setters
- (UIView *)backgroundButton {
    if (!_backgroundButton) {
        _backgroundButton = [[UIButton alloc]init];
    }
    return _backgroundButton;
}

@end
