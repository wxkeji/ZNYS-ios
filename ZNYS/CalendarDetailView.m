//
//  CalendarDetailView.m
//  ZNYS
//
//  Created by yu243e on 16/6/29.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "CalendarDetailView.h"

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
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).with.offset(CustomHeight(30));
        make.width.mas_equalTo(CustomHeight(200));
        make.height.mas_equalTo(CustomHeight(200));
    }];
    
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scrollView.mas_right).with.offset(CustomWidth(2));
        make.width.mas_equalTo(CustomWidth(30));
        make.height.mas_equalTo(44);
        make.centerY.equalTo(self.scrollView.mas_centerY);
    }]; //30X44 (应替换为带有透明区域的图片 满足点按大小要求
    
    [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.scrollView.mas_left).with.offset(CustomWidth(-2));
        make.width.mas_equalTo(CustomWidth(30));
        make.height.mas_equalTo(44);
        make.centerY.equalTo(self.scrollView.mas_centerY);
    }]; //30X44
    
    CGFloat reinforceImageViewToBottom = 15;
    [self.reinforcerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_centerX).with.offset(CustomWidth(-50));
        make.bottom.equalTo(self.mas_bottom).with.offset(CustomHeight(-reinforceImageViewToBottom));
        make.width.mas_equalTo(CustomWidth(40));
        make.height.mas_equalTo(CustomHeight(40));
    }];
    
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(0);
        make.bottom.equalTo(self.mas_bottom).with.offset(0);
        make.width.mas_equalTo(self.mas_width);
        make.top.equalTo(self.reinforcerImageView.mas_top).with.offset(CustomHeight(-reinforceImageViewToBottom));
    }];
    
    [self.reinforcerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_centerX).with.offset(CustomWidth(10));
        make.width.mas_equalTo(CustomWidth(20));
        make.centerY.equalTo(self.reinforcerImageView.mas_centerY).offset(CustomWidth(-1));
    }];

}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"scrollViewDidEndDecelerating");
    [self hiddenButton];
    [self changeReinforceLabel];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    NSLog(@"scrollViewDidEndScrollingAnimation");
    [self hiddenButton];
    [self changeReinforceLabel];
}

#pragma mark - public method
- (void)setDataSource:(id<CalendarDetailViewDataSource>)dataSource {
    if (_dataSource == dataSource && dataSource != NULL) {
        return;
    }
    _dataSource = dataSource;
    
    self.calendarItemNum = [dataSource numberOfItemsInView];
    self.scrollView.contentSize = CGSizeMake ((CustomHeight(200) * self.calendarItemNum), CustomHeight(200));
    
    //为scrollView设置图片
    NSInteger offset = 0;
    for (int i = 0; i < self.calendarItemNum; i++) {
        UIImageView * ImageView = [[UIImageView alloc]initWithFrame:CGRectMake(offset + CustomHeight(15),  CustomHeight(15), CustomHeight(170),  CustomHeight(170))];
        UIImage * image = [dataSource itemImageAtIndex:i];
        [ImageView setImage:image];
        [self.scrollView addSubview:ImageView];
        
        offset += CustomHeight(200);
    }
    
    //初始化弹出窗的数字和左右按钮
    self.reinforcerLabel.text = [NSString stringWithFormat:@"%ld",(unsigned long)[dataSource numberOfCoinsAtIndex:0]];
    if ([self.dataSource numberOfItemsInView] <= 1) {
        self.leftButton.hidden = YES;
        self.rightButton.hidden = YES;
    } else {
        self.leftButton.hidden = YES;
        self.rightButton.hidden = NO;
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
    
    if ([self.dataSource numberOfItemsInView] <= 1) {
        self.leftButton.hidden = YES;
        self.rightButton.hidden = YES;
        return;
    }
    //注意 仅在已经有 frame（已经显示时可以使用该方法计算）
    //+10 防止转换误差 CGFloat → NSInteger
    NSInteger offset =  (self.scrollView.contentOffset.x + 10) / (self.scrollView.frame.size.width);
    NSInteger maxOffset = (self.scrollView.contentSize.width + 10) / (self.scrollView.frame.size.width) - 1;
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

- (void)changeReinforceLabel {
    NSInteger offset =  (self.scrollView.contentOffset.x) / (self.scrollView.frame.size.width);
    self.reinforcerLabel.text = [NSString stringWithFormat:@"%ld",(unsigned long)[self.dataSource numberOfCoinsAtIndex:offset]];
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
        [_reinforcerImageView setImage:[UIImage imageNamed:@"calendar/calendarDetail_star"]];
    }
    return _reinforcerImageView;
}

- (UILabel *)reinforcerLabel {
    if (!_reinforcerLabel) {
        _reinforcerLabel = [[UILabel alloc]init];
        _reinforcerLabel.font = [UIFont systemFontOfSize:24];
        
//        _reinforcerLabel.adjustsFontSizeToFitWidth = YES;
        _reinforcerLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
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
