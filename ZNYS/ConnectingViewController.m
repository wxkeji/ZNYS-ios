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
#import "ConnectedViewController.h"
@interface ConnectingViewController ()

@property(nonatomic,strong)ConnectingView* connectingView;

@property BOOL isConnected;
@end

@implementation ConnectingViewController
#pragma mark - View life cycle
-(instancetype)init
{
    self = [super init];
    self.isConnected = NO;
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^(void){
        [[BluetoothServer defaultServer] scan];
       // [self didConnect];
    });
    [self.view addSubview:self.connectingView];
    [self.connectingView setProgress:0.1f];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.connectingView setProgress:0.2f];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.connectingView setProgress:0.3f];
        });
    });
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
    ConnectedViewController* cvc = [[ConnectedViewController alloc] init];
    [self.navigationController pushViewController:cvc animated:YES];
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
