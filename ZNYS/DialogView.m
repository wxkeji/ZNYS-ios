//
//  DialogView.m
//  ZNYS
//
//  Created by mac on 15/9/19.
//  Copyright © 2015年 Woodseen. All rights reserved.
//

#import "DialogView.h"

@interface DialogView ()

@property (strong, nonatomic) IBOutlet UILabel *itemName;

@property (strong, nonatomic) IBOutlet UILabel *conditionToGet;

@property (strong, nonatomic) IBOutlet UIView *dialog;

@end

@implementation DialogView

+(DialogView *)instanceDialogView
{
    NSArray *nibView =  [[NSBundle mainBundle] loadNibNamed:@"DialogView" owner:nil options:nil];
    
    return [nibView objectAtIndex:0];
}

+(DialogView *)instanceDialogViewWithItemName:(NSString *)itemName conditionToGet:(NSString *)conditionToGet
{
    DialogView *dialogView = [DialogView instanceDialogView];
    dialogView.itemName.text = itemName;
    dialogView.conditionToGet.text = conditionToGet;
    
    //设置为可交互
    dialogView.userInteractionEnabled = YES;
    
    //添加点击响应
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:dialogView action:@selector(clicked:)];
    [dialogView addGestureRecognizer:tapGestureRecognizer];
    [tapGestureRecognizer setNumberOfTapsRequired:1];
    
    return dialogView;
}

- (void)clicked:(id)sender
{
    NSLog(@"DialogView clicked");
    [self removeFromSuperview];
}

@end
