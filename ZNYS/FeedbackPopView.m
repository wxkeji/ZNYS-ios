//
//  FeedbackPopView.m
//  ZNYS
//
//  Created by jerry on 15/10/7.
//  Copyright © 2015年 Woodseen. All rights reserved.
//

#import "FeedbackPopView.h"

@implementation FeedbackPopView


#define popViewW  [UIScreen mainScreen].bounds.size.width*0.66666
#define popViewH popViewW*0.66666





+ (instancetype)shared
{
    static dispatch_once_t once = 0;
    static FeedbackPopView *popView;
    dispatch_once(&once, ^{
         popView = [[FeedbackPopView alloc] init];
    });
    
    return popView;
}


-(void)setPopView
{  //设置label
    UILabel *label=[[UILabel alloc] init];
    NSString*labelText=[NSString stringWithFormat:@"提交成功，谢谢您的反馈!"];
    label.font=[UIFont boldSystemFontOfSize:16.0];
    CGSize labelSize=[labelText  sizeWithAttributes:@{NSFontAttributeName:label.font}];
    label.text=@"提交成功，谢谢您的反馈!";
    label.frame=(CGRect){ {0,0},labelSize};
    CGPoint center=CGPointMake( popViewW/2 ,popViewH/4);
    label.center=center;
    label.textAlignment =  NSTextAlignmentCenter;;
    NSLog(@"%@",NSStringFromCGPoint(label.center));
    [self addSubview:label];
    
    
    //设置图片
    UIImage*image=[UIImage imageNamed:@"u224"];
    UIImageView*imageView=[[UIImageView alloc] initWithImage:image];
    CGRect frame=CGRectMake(0, label.frame.origin.y+20, 50, 50);
    CGPoint imageCenter=CGPointMake(popViewW/2, popViewH/2+20);
    imageView.frame=frame;
    imageView.center=imageCenter;
    [self addSubview:imageView];
    
}
- (CGSize)getMainScreenSize
{
    return [[UIScreen mainScreen] bounds].size;
}

- (CGSize)getSelfSize
{
    return self.frame.size;
}

- (instancetype)init
{
    self = [[FeedbackPopView alloc] initWithFrame:CGRectMake(([self getMainScreenSize].width-popViewW)/2, ([self getMainScreenSize].height-popViewH)/1, popViewW, popViewH)];
    self.alpha = 1;
    
    [self setBackgroundColor:[UIColor whiteColor]];
    [self setPopView];
    return self;
}
+ (void)showPopViewInView:(UIView*)view InController:(UIViewController*)vc  WithFormerVc:(UIViewController*)formerVc
{
    
    
    //[[self shared] drawTick];
    [view addSubview:[self shared]];
    [[self shared] showInController:vc WithFormerVc:formerVc];
    
    
}
- (void)showInController:(UIViewController*)vc WithFormerVc:(UIViewController*)formerVc
{
    [UIView animateWithDuration:1.0 animations:^{
        self.alpha=1;
        self.layer.cornerRadius = 25;
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(0, 5);
        self.layer.shadowOpacity = 0.3f;
        self.layer.shadowRadius = 10.0f;
        self.frame=CGRectMake(([self getMainScreenSize].width-popViewW)/2, ([self getMainScreenSize].height-popViewH)/2, popViewW,popViewH);
    } completion:^(BOOL finished) {
        [self distoryInController:vc WithFormerVc:formerVc];
        
        
    }];
    
}
- (void)distoryInController:(UIViewController*)vc WithFormerVc:(UIViewController*)formerVc
{
    
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha=0;
        self.layer.cornerRadius =25;
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(0, 5);
        self.layer.shadowOpacity = 0.3f;
        self.layer.shadowRadius = 10.0f;
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview ];
        CGRect sourceFrame=vc.view.frame;
        sourceFrame.origin.x=sourceFrame.size.width;
        
        CGRect destFrame=formerVc.view.frame;
        destFrame.origin.x=-destFrame.size.width;
        formerVc.view.frame=destFrame;
        
        
        destFrame.origin.x=0;
        [vc.view.superview addSubview:formerVc.view];
        //控制器窗口消失动画
        [UIView animateWithDuration:0.5 animations:^{
            vc.view.frame=sourceFrame;
            formerVc.view.frame=destFrame;
            
            
        } completion:^(BOOL finished){
        [vc dismissViewControllerAnimated:NO completion:nil];
         self.frame=CGRectMake(([self getMainScreenSize].width-popViewW)/2, ([self getMainScreenSize].height-popViewH)/1, popViewW, popViewH);
        
                         }
       
        
    ];
}
     ];}
////
//+ (void)Hide
//{
//    [[self shared] distory];
//}



@end
