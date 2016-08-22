//
//  CalendarDetailView.m
//  ZNYS
//
//  Created by yu243e on 16/6/29.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "CalendarDetailView.h"
#import "CalendarDetailModel.h"

@interface CalendarDetailView()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIImageView *reinforcerImageView;
@property (nonatomic, strong) UILabel *reinforcerLabel;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic) NSInteger calendarItemNum;
@property (nonatomic, strong) NSMutableArray<CalendarDetailModel *> * models;

@end

@implementation CalendarDetailView

#pragma mark - life cycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //蓝色背景
        [self setBackgroundColor:RGBCOLOR(107,212,247)];
        self.layer.cornerRadius = 8.0f;
        self.layer.masksToBounds = YES;
        
        [self addSubview:self.backgroundImageView];
        [self addSubview:self.reinforcerImageView];
        [self addSubview:self.reinforcerLabel];
        [self addSubview:self.scrollView];
        [self addSubview:self.rightButton];
        [self addSubview:self.leftButton];
        
        [self setupConstraintsForSubviews];
        
        [_leftButton addTarget:self action:@selector(leftButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_rightButton addTarget:self action:@selector(rightButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView setDelegate:self];
    }
    return self;
}

- (void)setupConstraintsForSubviews {
    WS(weakSelf, self);
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(0);
        make.top.equalTo(weakSelf.mas_top).with.offset(0);
        make.width.mas_equalTo(weakSelf.mas_width);
        make.height.mas_equalTo(weakSelf.mas_height);
    }];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.top.equalTo(weakSelf.mas_top).with.offset(CustomHeight(40));
        make.width.mas_equalTo(CustomHeight(200));
        make.height.mas_equalTo(CustomHeight(200));
    }];
    
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.scrollView.mas_right).with.offset(CustomWidth(5));
        make.width.mas_equalTo(CustomWidth(20));
        make.height.mas_equalTo(CustomHeight(30));
        make.centerY.equalTo(weakSelf.scrollView.mas_centerY);
    }];
    
    [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.scrollView.mas_left).with.offset(CustomWidth(-5));
        make.width.mas_equalTo(CustomWidth(20));
        make.height.mas_equalTo(CustomHeight(30));
        make.centerY.equalTo(weakSelf.scrollView.mas_centerY);
    }];
    
    [self.reinforcerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_centerX).with.offset(CustomWidth(-50));
        make.top.lessThanOrEqualTo(weakSelf.scrollView.mas_bottom).with.offset(CustomHeight(20));
        make.width.mas_equalTo(CustomWidth(40));
        make.height.mas_equalTo(CustomHeight(40));
    }];
    
    [self.reinforcerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_centerX).with.offset(CustomWidth(10));
        make.width.mas_equalTo(CustomWidth(20));
        make.centerY.equalTo(weakSelf.reinforcerImageView.mas_centerY).offset(CustomWidth(-1));
    }];

}
#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"scrollViewDidEndDecelerating");
    [self hiddenButton];
    [self changeReinforcerImageAndLabel];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    NSLog(@"scrollViewDidEndScrollingAnimation");
    [self hiddenButton];
    [self changeReinforcerImageAndLabel];

}

#pragma mark - public method
- (void)setModels:(NSMutableArray<CalendarDetailModel *> *)models {
    if (!models) {
        return;
    }
    _models = models;
    
    self.calendarItemNum = [_models count];
    
    //scrollView 内容
    self.calendarItemNum = [self.models count];
    self.scrollView.contentSize = CGSizeMake ((CustomHeight(200) * self.calendarItemNum), CustomHeight(200));
    
    NSInteger offset = 0;
    for (CalendarDetailModel *model in self.models) {
        UIImageView * ImageView = [[UIImageView alloc]initWithFrame:CGRectMake(offset + CustomHeight(15),  CustomHeight(15), CustomHeight(170),  CustomHeight(170))];
        
        UIImage * image = [UIImage imageNamed:model.pictureURL];
        [ImageView setImage:image];
        [self.scrollView addSubview:ImageView];
        //初值
        if (offset == 0) {
            [self.reinforcerImageView setImage:[UIImage imageNamed:model.reinforcerPictureURL]];
            self.reinforcerLabel.text = [NSString stringWithFormat:@"%ld",(long)model.reinforcerCount];
            self.leftButton.hidden = YES;
        }
        offset += CustomHeight(200);
    }

}

#pragma mark - private method

//颜色→UIimage 暂时代替背景使用
- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)hiddenButton {
    self.leftButton.userInteractionEnabled = YES;
    self.rightButton.userInteractionEnabled = YES;
    
    NSInteger offset =  (self.scrollView.contentOffset.x) / (self.scrollView.frame.size.width);
    NSInteger maxOffset = (self.scrollView.contentSize.width) / (self.scrollView.frame.size.width) - 1;
    if (offset == 0) {
        self.leftButton.hidden = YES;
    } else {
        self.leftButton.hidden = NO;
    }
    
    if (offset == maxOffset) {
        self.rightButton.hidden = YES;
    } else {
        self.rightButton.hidden = NO;
    }
}

- (void)changeReinforcerImageAndLabel {
    NSInteger offset =  (self.scrollView.contentOffset.x) / (self.scrollView.frame.size.width);
    [self.reinforcerImageView setImage:[UIImage imageNamed:self.models[offset].reinforcerPictureURL]];
    self.reinforcerLabel.text = [NSString stringWithFormat:@"%ld",(long)self.models[offset].reinforcerCount];
}
#pragma mark - event action
- (void)leftButtonAction {
    CGPoint contentOffset = CGPointMake(self.scrollView.contentOffset.x - self.scrollView.frame.size.width,  0.0);
    [self.scrollView setContentOffset:contentOffset animated:YES];
    self.leftButton.userInteractionEnabled = NO;
}

- (void)rightButtonAction {
    CGPoint contentOffset = CGPointMake(self.scrollView.contentOffset.x + self.scrollView.frame.size.width,  0.0);
    [self.scrollView setContentOffset:contentOffset animated:YES];
    self.rightButton.userInteractionEnabled = NO;
}

#pragma mark - getters and setters
- (UIImageView *)backgroundImageView {
    if (!_backgroundImageView) {
        //深的蓝色，暂代图片
        _backgroundImageView = [[UIImageView alloc]init];
        [_backgroundImageView setImage:[self imageWithColor:RGBCOLOR(29,168,237)]];
        
        
    }
    return _backgroundImageView;
}

- (UIImageView *)reinforcerImageView {
    if (!_reinforcerImageView) {
        _reinforcerImageView = [[UIImageView alloc]init];
        [_reinforcerImageView setImage:[UIImage imageNamed:@"calendar_star"]];
    }
    return _reinforcerImageView;
}

- (UILabel *)reinforcerLabel {
    if (!_reinforcerLabel) {
        _reinforcerLabel = [[UILabel alloc]init];
        _reinforcerLabel.text = [[NSString alloc]initWithFormat:@"0"];
        _reinforcerLabel.font = [UIFont systemFontOfSize:50];
        _reinforcerLabel.textColor = RGBCOLOR(147, 214, 243);
        
        _reinforcerLabel.adjustsFontSizeToFitWidth = YES;
        _reinforcerLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        //[_reinforcerLabel setBackgroundColor:[UIColor whiteColor]];
    }
    return _reinforcerLabel;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        self.scrollView.directionalLockEnabled = YES;
        self.scrollView.pagingEnabled = YES;
        [_scrollView setBackgroundColor:[UIColor clearColor]];
    }
    return _scrollView;
}

- (UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightButton setBackgroundImage:[UIImage imageNamed:@"calendar_arrowRight_boy"] forState:UIControlStateNormal];
    }
    return _rightButton;
}

- (UIButton *)leftButton {
    if (!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftButton setBackgroundImage:[UIImage imageNamed:@"calendar_arrowLeft_boy"] forState:UIControlStateNormal];
    }
    return _leftButton;
}
@end
