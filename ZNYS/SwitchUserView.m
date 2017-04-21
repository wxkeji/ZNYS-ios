//
//  SwitchUserView.m
//  ZNYS
//
//  Created by Ellise on 16/1/5.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "SwitchUserView.h"
#import "AddAccountButton.h"
#import "ThumbView.h"
#import "UserManager.h"

@interface SwitchUserView()



@end

@implementation SwitchUserView

#pragma mark life cycle

- (void)dealloc{
    _dataArray = nil;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self refresh];
    }
    return self;
}

- (void)refresh{
    for (UIView * view in self.subviews) {
        [view removeFromSuperview];
    }
    
    NSInteger count = self.dataArray.count+1;
    
    for (NSInteger i = 0; i<count; i++) {
        if (count < 5) {
            CGFloat viewWidth = (0.864*kSCREEN_WIDTH - 3*0.033*kSCREEN_WIDTH)/4;
            if (i<count-1) {
                ThumbView * thumbView = [[ThumbView alloc] init];
                thumbView.frame = CGRectMake(0.068*kSCREEN_WIDTH+i*viewWidth+i*0.033*kSCREEN_WIDTH, 0, viewWidth, 0.15*kSCREEN_HEIGHT);
                thumbView.thumbButton.tag = i;
                thumbView.nameLabel.text = [[self.dataArray objectAtIndex:i] objectForKey:@"name"];
                thumbView.uuid = [[self.dataArray objectAtIndex:i] objectForKey:@"uuid"];
                //temp +++ thumb值已改为返回 gender
                if (![[[self.dataArray objectAtIndex:i] objectForKey:@"thumb"] boolValue]) {
                    [thumbView.thumbButton setImage:[UIImage imageNamed:@"user/boyDefault"] forState:UIControlStateNormal];
                }else{
                    [thumbView.thumbButton setImage:[UIImage imageNamed:@"user/girlDefault"] forState:UIControlStateNormal];
                }
                [self addSubview:thumbView];
            }else if((count-1)<5){
                AddAccountButton * addView = [[AddAccountButton alloc] init];
                addView.frame = CGRectMake(0.068*kSCREEN_WIDTH+i*viewWidth+i*0.033*kSCREEN_WIDTH, 0, viewWidth, 0.15*kSCREEN_HEIGHT);
                [self addSubview:addView];
            }
        }
//        else if(count == 5){
//            CGFloat viewWidth = (0.864*kSCREEN_WIDTH - 3*0.033*kSCREEN_WIDTH)/4;
//            if (i<count-1) {
//                ThumbView * thumbView = [[ThumbView alloc] init];
//                thumbView.frame = CGRectMake(0.068*kSCREEN_WIDTH+i*viewWidth+i*0.033*kSCREEN_WIDTH, 0, viewWidth, 0.15*kSCREEN_HEIGHT);
//                thumbView.thumbButton.tag = i;
//                thumbView.nameLabel.text = [[self.dataArray objectAtIndex:i] objectForKey:@"name"];
//                if ([[[self.dataArray objectAtIndex:i] objectForKey:@"thumb"] integerValue]) {
//                    [thumbView.thumbButton setBackgroundColor:[UIColor blueColor]];
//                }else{
//                    [thumbView.thumbButton setBackgroundColor:[UIColor redColor]];
//                }
//                [self addSubview:thumbView];
//            }else{
//                AddAccountButton * addView = [[AddAccountButton alloc] init];
//                addView.frame = CGRectMake(0.068*kSCREEN_WIDTH, 0.15*kSCREEN_HEIGHT, viewWidth, 0.15*kSCREEN_HEIGHT);
//                [self addSubview:addView];
//            }
//        }
        else{
            CGFloat viewWidth = (0.864*kSCREEN_WIDTH - 3*0.033*kSCREEN_WIDTH)/4;
            if (i<count-1) {
                ThumbView * thumbView = [[ThumbView alloc] init];
                thumbView.frame = CGRectMake(0.068*kSCREEN_WIDTH+i*viewWidth+i*0.033*kSCREEN_WIDTH, 0, viewWidth, 0.15*kSCREEN_HEIGHT);
                thumbView.thumbButton.tag = i;
                thumbView.nameLabel.text = [[self.dataArray objectAtIndex:i] objectForKey:@"name"];
                thumbView.uuid = [[self.dataArray objectAtIndex:i] objectForKey:@"uuid"];
                //todo +++
                if ([[[self.dataArray objectAtIndex:i] objectForKey:@"thumb"] boolValue]) {
                    [thumbView.thumbButton setBackgroundColor:[UIColor redColor]];
                }else{
                    [thumbView.thumbButton setBackgroundColor:[UIColor blueColor]];
                }
                [self addSubview:thumbView];
            }
//            else if(i == (count-2)){
//                ThumbView * thumbView = [[ThumbView alloc] init];
//                thumbView.frame = CGRectMake(0.068*kSCREEN_WIDTH, 0.15*kSCREEN_HEIGHT, viewWidth, 0.15*kSCREEN_HEIGHT);
//                thumbView.thumbButton.tag = i;
//                thumbView.nameLabel.text = [[self.dataArray objectAtIndex:i] objectForKey:@"name"];
//                if ([[[self.dataArray objectAtIndex:i] objectForKey:@"thumb"] integerValue]) {
//                    [thumbView.thumbButton setBackgroundColor:[UIColor blueColor]];
//                }else{
//                    [thumbView.thumbButton setBackgroundColor:[UIColor redColor]];
//                }
//                [self addSubview:thumbView];
//            }
        }
    }

}
#pragma mark getters and setters

- (NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[UserManager sharedInstance] retrieveOtherUsersExcept:nil];
    }
    return _dataArray;
}

@end
