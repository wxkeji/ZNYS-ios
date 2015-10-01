//
//  CalendarViewController.m
//  ZNYS
//
//  Created by luolun on 15/10/1.
//  Copyright © 2015年 Woodseen. All rights reserved.
//

#import "CalendarViewController.h"

@interface CalendarViewController ()

- (IBAction)homeButtonTouched:(id)sender;

@end

@implementation CalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)homeButtonTouched:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
