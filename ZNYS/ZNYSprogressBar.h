//
//  ZNYSprogressBar.h
//  ZNYS
//
//  Created by 张恒铭 on 3/13/16.
//  Copyright © 2016 Woodseen. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol progressDelegate <NSObject>

-(void)updateProgress:(CGFloat)progress;
-(void)endTime;

@end


@interface ZNYSprogressBar : UIView
 
@end
