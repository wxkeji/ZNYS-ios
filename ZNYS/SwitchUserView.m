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

@interface SwitchUserView()

@property (nonatomic,strong) NSMutableArray * dataArray;

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
        
        NSInteger count = self.dataArray.count+1;
       
        for (NSInteger i = 0; i<count; i++) {
//            if (i<count-1) {
//                ThumbView * thumbView = [[ThumbView alloc] init];
//                thumbView.frame = CGRectMake(0.068*kSCREEN_WIDTH+i*viewWidth+i*0.033*kSCREEN_WIDTH, 0, viewWidth, 0.15*kSCREEN_HEIGHT);
//                thumbView.nameLabel.text = [[self.dataArray objectAtIndex:i] objectForKey:@"name"];
//                if ([[[self.dataArray objectAtIndex:i] objectForKey:@"thumb"] isEqualToString:@"boy"]) {
//                    [thumbView.thumbButton setBackgroundColor:[UIColor blueColor]];
//                }else{
//                    [thumbView.thumbButton setBackgroundColor:[UIColor redColor]];
//                }
//                [self addSubview:thumbView];
//            }else if((count-1)<5){
//                AddAccountButton * addView = [[AddAccountButton alloc] init];
//                addView.frame = CGRectMake(0.068*kSCREEN_WIDTH+i*viewWidth+i*0.033*kSCREEN_WIDTH, 0, viewWidth, 0.15*kSCREEN_HEIGHT);
//                [self addSubview:addView];
//            }
            if (count < 5) {
                 CGFloat viewWidth = (0.864*kSCREEN_WIDTH - 3*0.033*kSCREEN_WIDTH)/4;
                if (i<count-1) {
                    ThumbView * thumbView = [[ThumbView alloc] init];
                    thumbView.frame = CGRectMake(0.068*kSCREEN_WIDTH+i*viewWidth+i*0.033*kSCREEN_WIDTH, 0, viewWidth, 0.15*kSCREEN_HEIGHT);
                    thumbView.thumbButton.tag = i;
                    thumbView.nameLabel.text = [[self.dataArray objectAtIndex:i] objectForKey:@"name"];
                    if ([[[self.dataArray objectAtIndex:i] objectForKey:@"thumb"] isEqualToString:@"boy"]) {
                        [thumbView.thumbButton setBackgroundColor:[UIColor blueColor]];
                    }else{
                        [thumbView.thumbButton setBackgroundColor:[UIColor redColor]];
                    }
                    [self addSubview:thumbView];
                }else if((count-1)<5){
                    AddAccountButton * addView = [[AddAccountButton alloc] init];
                    addView.frame = CGRectMake(0.068*kSCREEN_WIDTH+i*viewWidth+i*0.033*kSCREEN_WIDTH, 0, viewWidth, 0.15*kSCREEN_HEIGHT);
                    [self addSubview:addView];
                }
            }else if(count == 5){
                CGFloat viewWidth = (0.864*kSCREEN_WIDTH - 3*0.033*kSCREEN_WIDTH)/4;
                if (i<count-1) {
                    ThumbView * thumbView = [[ThumbView alloc] init];
                    thumbView.frame = CGRectMake(0.068*kSCREEN_WIDTH+i*viewWidth+i*0.033*kSCREEN_WIDTH, 0, viewWidth, 0.15*kSCREEN_HEIGHT);
                    thumbView.thumbButton.tag = i;
                    thumbView.nameLabel.text = [[self.dataArray objectAtIndex:i] objectForKey:@"name"];
                    if ([[[self.dataArray objectAtIndex:i] objectForKey:@"thumb"] isEqualToString:@"boy"]) {
                        [thumbView.thumbButton setBackgroundColor:[UIColor blueColor]];
                    }else{
                        [thumbView.thumbButton setBackgroundColor:[UIColor redColor]];
                    }
                    [self addSubview:thumbView];
                }else{
                    AddAccountButton * addView = [[AddAccountButton alloc] init];
                    addView.frame = CGRectMake(0.068*kSCREEN_WIDTH, 0.15*kSCREEN_HEIGHT, viewWidth, 0.15*kSCREEN_HEIGHT);
                    [self addSubview:addView];
                }
            }else{
                CGFloat viewWidth = (0.864*kSCREEN_WIDTH - 3*0.033*kSCREEN_WIDTH)/4;
                if (i<count-2) {
                    ThumbView * thumbView = [[ThumbView alloc] init];
                    thumbView.frame = CGRectMake(0.068*kSCREEN_WIDTH+i*viewWidth+i*0.033*kSCREEN_WIDTH, 0, viewWidth, 0.15*kSCREEN_HEIGHT);
                    thumbView.thumbButton.tag = i;
                    thumbView.nameLabel.text = [[self.dataArray objectAtIndex:i] objectForKey:@"name"];
                    if ([[[self.dataArray objectAtIndex:i] objectForKey:@"thumb"] isEqualToString:@"boy"]) {
                        [thumbView.thumbButton setBackgroundColor:[UIColor blueColor]];
                    }else{
                        [thumbView.thumbButton setBackgroundColor:[UIColor redColor]];
                    }
                    [self addSubview:thumbView];
                }else if(i == (count-2)){
                    ThumbView * thumbView = [[ThumbView alloc] init];
                    thumbView.frame = CGRectMake(0.068*kSCREEN_WIDTH, 0.15*kSCREEN_HEIGHT, viewWidth, 0.15*kSCREEN_HEIGHT);
                    thumbView.thumbButton.tag = i;
                    thumbView.nameLabel.text = [[self.dataArray objectAtIndex:i] objectForKey:@"name"];
                    if ([[[self.dataArray objectAtIndex:i] objectForKey:@"thumb"] isEqualToString:@"boy"]) {
                        [thumbView.thumbButton setBackgroundColor:[UIColor blueColor]];
                    }else{
                        [thumbView.thumbButton setBackgroundColor:[UIColor redColor]];
                    }
                    [self addSubview:thumbView];
                }
            }
        }
    }
    return self;
}

#pragma mark getters and setters

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
        [_dataArray addObject:@{@"name":@"阿花",@"thumb":@"boy"}];
        [_dataArray addObject:@{@"name":@"阿花",@"thumb":@"girl"}];
        [_dataArray addObject:@{@"name":@"阿花",@"thumb":@"boy"}];
        [_dataArray addObject:@{@"name":@"阿花",@"thumb":@"boy"}];
       // [_dataArray addObject:@{@"name":@"阿花",@"thumb":@"boy"}];
    }
    return _dataArray;
}

@end
