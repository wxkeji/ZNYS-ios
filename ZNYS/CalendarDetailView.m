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
        self.layer.cornerRadius = kDefaultCornerRadius;
        self.layer.masksToBounds = YES;
        
        [self addSubview:self.backgroundImageView];
        [self addSubview:self.reinforcerImageView];
        [self addSubview:self.reinforcerLabel];
        [self addSubview:self.scrollView];
        [self addSubview:self.rightButton];
        [self addSubview:self.leftButton];
        
        [self setupConstraintsForSubviews];
        
        [self.leftButton addTarget:self action:@selector(leftButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self.rightButton addTarget:self action:@selector(rightButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView setDelegate:self];
    }
    return self;
}

- (void)setupConstraintsForSubviews {
    WS(weakSelf, self);
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.top.equalTo(weakSelf.mas_top).with.offset(CustomHeight(30));
        make.width.mas_equalTo(CustomHeight(200));
        make.height.mas_equalTo(CustomHeight(200));
    }];
    
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.scrollView.mas_right).with.offset(CustomWidth(2));
        make.width.mas_equalTo(CustomWidth(30));
        make.height.mas_equalTo(CustomHeight(30));
        make.centerY.equalTo(weakSelf.scrollView.mas_centerY);
    }]; //30X30
    
    [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.scrollView.mas_left).with.offset(CustomWidth(-2));
        make.width.mas_equalTo(CustomWidth(30));
        make.height.mas_equalTo(CustomHeight(30));
        make.centerY.equalTo(weakSelf.scrollView.mas_centerY);
    }]; //30X30
    
    CGFloat reinforceImageViewToBottom = 15;
    [self.reinforcerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_centerX).with.offset(CustomWidth(-50));
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(CustomHeight(-reinforceImageViewToBottom));
        make.width.mas_equalTo(CustomWidth(40));
        make.height.mas_equalTo(CustomHeight(40));
    }];
    
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(0);
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(0);
        make.width.mas_equalTo(weakSelf.mas_width);
        make.top.equalTo(weakSelf.reinforcerImageView.mas_top).with.offset(CustomHeight(-reinforceImageViewToBottom));
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

- (void)configureTheme {
    [self setBackgroundColor:[UIColor colorWithThemedImageNamed:@"color/primary"]];
    [self.backgroundImageView setImage:[UIImage themedImageWithNamed:@"color/primary_dark"]];
    self.reinforcerLabel.textColor = [UIColor colorWithThemedImageNamed:@"color/primary_light"];
    
    self.rightButton.tintColor = [UIColor colorWithThemedImageNamed:@"color/primary_dark"];
    self.leftButton.tintColor = [UIColor colorWithThemedImageNamed:@"color/primary_dark"];
}

#pragma mark - private method
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
        _backgroundImageView = [[UIImageView alloc]init];
        
    }
    return _backgroundImageView;
}

- (UIImageView *)reinforcerImageView {
    if (!_reinforcerImageView) {
        _reinforcerImageView = [[UIImageView alloc]init];
        [_reinforcerImageView setImage:[UIImage imageNamed:@"calendar/calendardetail_star"]];
    }
    return _reinforcerImageView;
}

- (UILabel *)reinforcerLabel {
    if (!_reinforcerLabel) {
        _reinforcerLabel = [[UILabel alloc]init];
        _reinforcerLabel.text = [[NSString alloc]initWithFormat:@"0"];
        _reinforcerLabel.font = [UIFont systemFontOfSize:kAutoFontSize];
        
        
        _reinforcerLabel.adjustsFontSizeToFitWidth = YES;
        _reinforcerLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        //[_reinforcerLabel setBackgroundColor:[UIColor whiteColor]];
    }
    return _reinforcerLabel;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.directionalLockEnabled = YES;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        [_scrollView setBackgroundColor:[UIColor clearColor]];
    }
    return _scrollView;
}

- (UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightButton setBackgroundImage:[UIImage themedImageWithNamed:@"calendar/arrowRight"] forState:UIControlStateNormal];
    }
    return _rightButton;
}

- (UIButton *)leftButton {
    if (!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftButton setBackgroundImage:[UIImage themedImageWithNamed:@"calendar/arrowLeft"] forState:UIControlStateNormal];
    }
    return _leftButton;
}
@end
