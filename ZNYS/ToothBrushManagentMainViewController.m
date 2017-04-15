//
//  ToothBrushManagentMainViewController.m
//  ZNYS
//
//  Created by 张恒铭 on 6/12/16.
//  Copyright © 2016 Woodseen. All rights reserved.
//

#import "ToothBrushManagentMainViewController.h"
#import "ToothBrushManagentMainView.h"
#import "BluetoothServer.h"
@interface ToothBrushManagentMainViewController ()

@property(nonatomic,strong)ToothBrushManagentMainView* mainView;

@end

@implementation ToothBrushManagentMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.mainView];
    BluetoothServer *server = [BluetoothServer defaultServer];
    // Do any additional setup after loading the view.
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

- (ToothBrushManagentMainView *)mainView {
	if(_mainView == nil) {
		_mainView = [[ToothBrushManagentMainView alloc] initWithFrame:self.view.bounds];
	}
	return _mainView;
}

@end
