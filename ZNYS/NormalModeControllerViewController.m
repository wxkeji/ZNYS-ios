//
//  NormalModeControllerViewController.m
//  ZNYS
//
//  Created by jerry on 15/10/5.
//  Copyright © 2015年 Woodseen. All rights reserved.
//

#import "NormalModeControllerViewController.h"
#define i4InNormal ([UIScreen mainScreen].bounds.size.height == 480||[UIScreen mainScreen].bounds.size.height == 568)
#import "DIYGoalController.h"
@interface NormalModeControllerViewController ()
@property (weak, nonatomic) IBOutlet UIView *headView;


@property (weak, nonatomic) IBOutlet UILabel *wordLabel;
- (IBAction)chooseMode:(id)sender;





@end

@implementation NormalModeControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (i4InNormal) {
        
        self.wordLabel.font=[UIFont systemFontOfSize:12];
        self.wordLabel.numberOfLines=4;
            }
    

    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
   
   
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

- (IBAction)chooseMode:(id)sender {
   
    DIYGoalController*goalVc=[self.storyboard instantiateViewControllerWithIdentifier:@"DIY"];
   // [self presentViewController:goalVc animated:NO completion:nil];
    [FeedbackPopView showPopViewInView:self.view InController:self WithFormerVc:goalVc];
    
}
@end
