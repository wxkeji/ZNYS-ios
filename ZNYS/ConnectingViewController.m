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

@property (nonatomic,assign)float currentProgress;

@property (nonatomic,strong) NSTimer* timer;
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
//        [[BluetoothServer defaultServer] scan];
       // [self didConnect];
    });
    self.currentProgress = 0.0f;
    [self.view addSubview:self.connectingView];
    self.connectingView.delegate = self;
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSDefaultRunLoopMode];
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
    [self.timer invalidate];
    self.timer = nil;
    
    
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
#pragma mark - timer method

- (void)fakeProgressGoing {
    self.currentProgress += 0.002* (arc4random()%10);
    [self.connectingView setProgress:self.currentProgress];
    if (self.currentProgress - 1.0f >= 0.000001) {
        [self didConnect];
    }
}


#pragma getter
- (NSTimer *)timer {
	if(_timer == nil) {
		_timer = [NSTimer timerWithTimeInterval:0.1f target:self selector:@selector(fakeProgressGoing) userInfo:nil repeats:YES];
	}
	return _timer;
}

@end
