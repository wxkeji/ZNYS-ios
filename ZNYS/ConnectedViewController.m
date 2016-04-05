//
//  ConnectedViewController.m
//  ZNYS
//
//  Created by 张恒铭 on 12/18/15.
//  Copyright © 2015 Woodseen. All rights reserved.
//

#import "ConnectedViewController.h"
#import "ConnectedView.h"
#import "CabinetViewController.h"
@interface ConnectedViewController ()
@property(nonatomic,strong) ConnectedView* connectedView;
@end

@implementation ConnectedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.connectedView = [[ConnectedView alloc] init];
    [self.view addSubview:self.connectedView];
    self.connectedView.delegate = self;
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
#pragma mark - delegate implementation
-(void)returnToHome
{
    for (UIViewController * viewController in self.navigationController.viewControllers) {
        if ([viewController isKindOfClass:[CabinetViewController class]]) {
            [self.navigationController popToViewController:viewController animated:YES];
          }
    }
    }
@end
