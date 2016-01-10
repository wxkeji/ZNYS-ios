//
//  ConnectingViewController.m
//  ZNYS
//
//  Created by 张恒铭 on 12/18/15.
//  Copyright © 2015 Woodseen. All rights reserved.
//

#import "ConnectingViewController.h"
#import "ConnectingView.h"
#import "BluetoothServer.h"
@interface ConnectingViewController ()
@property(nonatomic,strong)ConnectingView* connectingView;
@end

@implementation ConnectingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.connectingView];
    self.connectingView.delegate = self;
   
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
-(void)didConnect
{
    
}
#pragma mark - getter and setters
-(ConnectingView*)connectingView
{
    if(!_connectingView)
    {
        _connectingView = [[ConnectingView alloc] init];
    }
    return _connectingView;
}
#pragma mark - Delegate methods
-(void)returnToHome
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
