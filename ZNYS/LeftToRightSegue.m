//
//  LeftToRightSegue.m
//  ZNYS
//
//  Created by jerry on 15/10/5.
//  Copyright © 2015年 Woodseen. All rights reserved.
//

#import "LeftToRightSegue.h"

@implementation LeftToRightSegue

- (void)perform {
    UIViewController* source = (UIViewController *)self.sourceViewController;
    UIViewController* destination = (UIViewController *)self.destinationViewController;
    
    CGRect sourceFrame = source.view.frame;
    sourceFrame.origin.x = sourceFrame.size.width;
    
    CGRect destFrame = destination.view.frame;
    destFrame.origin.x = -destination.view.frame.size.width;
    destination.view.frame = destFrame;
    
    destFrame.origin.x = 0;
    [source.view.superview addSubview:destination.view];
    [UIView animateWithDuration:0.5
                     animations:^{
                         source.view.frame = sourceFrame;
                         destination.view.frame = destFrame;
                     }
                     completion:^(BOOL finished) {
                            [source dismissViewControllerAnimated:NO completion:nil];
                     }];
}

@end
