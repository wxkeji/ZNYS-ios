//
//  DIYGoalController.m
//  ZNYS
//
//  Created by jerry on 15/10/3.
//  Copyright © 2015年 Woodseen. All rights reserved.
//

#import "DIYGoalController.h"

@interface DIYGoalController ()

@end
#define iph4 ([UIScreen mainScreen].bounds.size.height == 480)
#define iph5 ([UIScreen mainScreen].bounds.size.height == 568)
#define iph6 ([UIScreen mainScreen].bounds.size.height == 667)
#define iph6p ([UIScreen mainScreen].bounds.size.height == 736)
@implementation DIYGoalController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *headerView = self.tableView.tableHeaderView;
   // CGFloat deviceH=self.view.frame.size.height;
    
//    
//    640  i5 128.000000!!!
//    i6  150.5
//    6p 163.3333
//    i4 113
    
    CGRect newFrame=self.tableView.tableHeaderView.frame;
    //newFrame.size.height=headerH/5;
    if (iph4) {
        newFrame.size.height=113;
    }
    if (iph5) {
        newFrame.size.height=130;
    }
    if (iph6) {
        newFrame.size.height=150.5;
    }
    if (iph6p) {
        newFrame.size.height=163.333;
    }
    
    
    
    
    headerView.frame=newFrame;
    self.tableView.tableHeaderView = headerView;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)unwindSegue:(UIStoryboardSegue *)sender{
    
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
//    return 0;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
