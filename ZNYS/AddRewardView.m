//
//  AddRewardView.m
//  ZNYS
//
//  Created by Ellise on 16/4/29.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "AddRewardView.h"

typedef NS_ENUM(NSUInteger, IsInRecordingType) {
    HaventRecord    = 0,    //没有录音
    IsRecording      = 1,    //正在录音
    FinishRecord = 2,    //完成录音
};


@interface AddRewardView()

@property (nonatomic,strong) UIImageView * backgroundView;

@property (nonatomic,strong) UIImageView * coinView;

@property (nonatomic,strong) UILabel * multiLabel;

@property (nonatomic,strong) UIView * line1;

@property (nonatomic,strong) UIView * line2;

@property (nonatomic,strong) UIScrollView * scrollView;

@property (nonatomic,strong) UIButton * recordButton;

@property (nonatomic,strong) UIButton * deleteButton;

@property (nonatomic,strong) UIButton * bottomButton;

@property (nonatomic,assign) IsInRecordingType isRecording;

@end

@implementation AddRewardView

@end
