//
//  IsParentViewController.m
//  ZNYS
//
//  Created by luolun on 15/10/1.
//  Copyright © 2015年 Woodseen. All rights reserved.
//

#import "IsParentViewController.h"
#import "settingIndexController.h"


@interface IsParentViewController ()

@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;
@property (weak, nonatomic) IBOutlet UIButton *button5;
@property (weak, nonatomic) IBOutlet UIButton *button6;
@property (weak, nonatomic) IBOutlet UIButton *button7;
@property (weak, nonatomic) IBOutlet UIButton *button8;
@property (weak, nonatomic) IBOutlet UIButton *button9;
@property(strong,nonatomic)NSString*key;


- (IBAction)button1:(id)sender;
- (IBAction)button2:(id)sender;
- (IBAction)button3:(id)sender;
- (IBAction)button4:(id)sender;
- (IBAction)button5:(id)sender;
- (IBAction)button6:(id)sender;
- (IBAction)button7:(id)sender;
- (IBAction)button8:(id)sender;
- (IBAction)button9:(id)sender;




@end

@implementation IsParentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.key=[NSString stringWithFormat:@"658"];
    inputCount=1;
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)button1:(id)sender {
    [ self dismissViewControllerAnimated: YES completion: nil ];
}

- (IBAction)button2:(id)sender {
   [ self dismissViewControllerAnimated: YES completion: nil ];
}

- (IBAction)button3:(id)sender {
    [ self dismissViewControllerAnimated: YES completion: nil ];
    
}

- (IBAction)button4:(id)sender {
    [ self dismissViewControllerAnimated: YES completion: nil ];
}

- (IBAction)button5:(id)sender {
    if (inputCount==3) {
         
        [self performSegueWithIdentifier:@"tableViewID" sender:self];
       
    }
   else
       [ self dismissViewControllerAnimated: YES completion: nil ];

}

- (IBAction)button6:(id)sender {
    if(inputCount==1)
    {
        inputCount++;
        
    }
    else{
        [ self dismissViewControllerAnimated: YES completion: nil ];
    }
    
    
}


- (IBAction)button7:(id)sender {
    [ self dismissViewControllerAnimated: YES completion: nil ];
}

- (IBAction)button8:(id)sender {
    
    if (inputCount==2) {
        inputCount++;
    }
    else
    [ self dismissViewControllerAnimated: YES completion: nil ];
}

- (IBAction)button9:(id)sender {
    [ self dismissViewControllerAnimated: YES completion: nil ];
}
@end
