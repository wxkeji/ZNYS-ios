//
//  ConnectedResultView.m
//  ZNYS
//
//  Created by yu243e on 16/7/14.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "ConnectedResultView.h"
#import "MAKAFakeRootAlertView.h"
#import "CalendarItemManager.h"
#import "ConnectedResultContentView.h"

@interface ConnectedResultView()

@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) NSMutableArray<ConnectedResultContentView *> * contentViewArray;
@property (nonatomic) NSInteger contentNum;
@property (nonatomic, strong) NSMutableArray<CalendarItem *> * models;

- (void)rightButtonAction;
- (void)leftButtonAction;
- (void)hiddenButton;
- (void)changeReinforcerImageAndLabel;
@end


@implementation ConnectedResultView

#pragma mark life cycle
- (void)dealloc{
    _dismissBlock = nil;
    _scrollView = nil;
    _contentViewArray = nil;
    _models = nil;
    _leftButton = nil;
    _rightButton = nil;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        //蓝色背景
        [self setBackgroundColor:RGBCOLOR(147, 214, 243)];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.backgroundImageView];
        [self addSubview:self.scrollView];
        [self addSubview:self.rightButton];
        [self addSubview:self.leftButton];
        
        WS(weakSelf, self);
        
        [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left).with.offset(CustomWidth(0));
            make.top.equalTo(weakSelf.mas_top).with.offset(CustomHeight(0));
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
        
        
        //scrollView 内容
        
        self.contentNum = [self.models count];
        self.scrollView.contentSize = CGSizeMake ((CustomHeight(200) * self.contentNum), CustomHeight(200));
        
        NSInteger offset = CustomHeight(200);
        for (NSInteger i = 0; i < self.contentNum; i++) {
            [self.contentViewArray[i] setFrame:CGRectMake(i*offset + CustomHeight(15),  CustomHeight(15), CustomHeight(170),  CustomHeight(170))];
            [self.scrollView addSubview:self.contentViewArray[i]];
            //初值
            if (i == 0) {
                self.leftButton.hidden = YES;
            }
        }
        
        [self.scrollView setDelegate:self];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //[self.reinforcerLabel sizeToFit];
}

#pragma mark UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
#ifdef debug
    NSLog(@"scrollViewDidEndDecelerating");
#endif
    [self hiddenButton];
    [self changeReinforcerImageAndLabel];
}


- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
#ifdef debug
    NSLog(@"scrollViewDidEndScrollingAnimation");
#endif
    [self hiddenButton];
    [self changeReinforcerImageAndLabel];
    
}

#pragma mark private method

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
}
#pragma mark event action

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
#pragma mark getters and setters

- (UIImageView *)backgroundImageView {
    if (!_backgroundImageView) {
        //深的蓝色，暂代图片
        _backgroundImageView = [[UIImageView alloc]init];
        [_backgroundImageView setImage:[self imageWithColor:RGBCOLOR(29,168,237)]];
    }
    return _backgroundImageView;
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
        [_rightButton setBackgroundImage:[UIImage imageNamed:@"arrow_head_right"] forState:UIControlStateNormal];
        [_rightButton addTarget:self action:@selector(rightButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}

- (UIButton *)leftButton {
    if (!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftButton setBackgroundImage:[UIImage imageNamed:@"arrow_head_left"] forState:UIControlStateNormal];
        [_leftButton addTarget:self action:@selector(leftButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftButton;
}

- (NSMutableArray<ConnectedResultContentView *> * )contentViewArray {
    if (!_contentViewArray) {
        _contentViewArray = [[NSMutableArray alloc]init];
        for (CalendarItem *calendarItem in self.models) {
            ConnectedResultContentView *view = [[ConnectedResultContentView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
            [view setModel:calendarItem];
            [_contentViewArray addObject:view];
        }
    }
    return _contentViewArray;
}
@end
