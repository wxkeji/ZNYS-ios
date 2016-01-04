//
//  CalendarViewController.m
//  ZNYS
//
//  Created by luolun on 15/10/1.
//  Copyright © 2015年 Woodseen. All rights reserved.
//

#import "CalendarViewController.h"

@interface CalendarViewController ()

@property (weak, nonatomic) IBOutlet UIButton *homeButton;

@end

@implementation CalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initPageJumps];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Page Jumps

- (void)initPageJumps
{
    [self.homeButton addTarget:self action:@selector(toHome) forControlEvents:UIControlEventTouchUpInside];
}

- (void)toHome
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
