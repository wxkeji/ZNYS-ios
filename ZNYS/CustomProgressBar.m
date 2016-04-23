//
//  CustomProgressBar.m
//  ProgressBar
//
//  Created by 张恒铭 on 3/25/16.
//  Copyright © 2016 张恒铭. All rights reserved.
//

#import "CustomProgressBar.h"
@interface CustomProgressBar()
@property(nonatomic,strong) CALayer* progressLayer;
@property(nonatomic,strong) UIImageView* indicatorView;
@property(nonatomic,strong) UILabel*    indicatorLabel;
@property(nonatomic,assign) float currentProgress;
@end

@implementation CustomProgressBar
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    self.layer.cornerRadius = 15;
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = 9;
   // self.layer.backgroundColor = [UIColor colorWithRed:43.0/255 green:176.0/255 blue:252.0/255 alpha:1.0].CGColor;
    
    
    _progressLayer = [CALayer layer];
    self.progressLayer.masksToBounds = YES;
    self.progressLayer.cornerRadius = 6;
    self.progressLayer.backgroundColor = [UIColor colorWithRed:245.0/255 green:114.0/255 blue:12.0/255 alpha:1.0].CGColor;
    [self.progressLayer setFrame:CGRectMake(9, 9,CGRectGetWidth(self.layer.frame)-18 , CGRectGetHeight(self.layer.frame)-18)];
    [self.layer addSublayer:self.progressLayer];
    
    
    return self;
}
-(void)setProgress:(float)progress
{
    if(!(progress>=0.01&&progress<=1.01))
        progress = progress - (int)progress;
    self.progressLayer.anchorPoint = CGPointMake(1.5-progress, 0.5);
}

-(UIImageView*)indicatorView
{
    if (!_indicatorView) {
        _indicatorView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ProgressRectangle"]];
        _indicatorView.frame = CGRectMake(100, 100, 102, 95);
        [_indicatorView addSubview:self.indicatorLabel];
    }
    return _indicatorView;
}
- (UILabel *)indicatorLabel {
	if(_indicatorLabel == nil) {
		_indicatorLabel = [[UILabel alloc] init];
        [_indicatorLabel setText:@"0%"];
        
	}
	return _indicatorLabel;
}

@end
