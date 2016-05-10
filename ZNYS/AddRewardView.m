//
//  AddRewardView.m
//  ZNYS
//
//  Created by Ellise on 16/4/29.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "AddRewardView.h"
#import "ChooseNumberScrollView.h"

typedef NS_ENUM(NSUInteger, IsInRecordingType) {
    HaventRecord    = 0,    //没有录音
    IsRecording      = 1,    //正在录音
    FinishRecord = 2,    //完成录音
};


@interface AddRewardView()

@property (nonatomic,strong) UIImageView * backgroundView;

@property (nonatomic,strong) UIImageView * coinView;

@property (nonatomic,strong) UILabel * multiLabel;

@property (nonatomic,strong) ChooseNumberScrollView * chooseNumberPickerView;

@property (nonatomic,strong) UIButton * deleteButton;

@property (nonatomic,strong) UIButton * bottomButton;

@property (nonatomic,assign) IsInRecordingType isRecording;

@property (nonatomic,strong) UIButton * recordButton;

@property (nonatomic,strong) NSMutableArray<NSNumber *> * numArray;

@property (nonatomic,strong) NSString * coinsNum;

@property (nonatomic,strong) UIView * scrollBackView;

@end

@implementation AddRewardView

#pragma mark life cycle

- (void)dealloc{
    _backgroundView = nil;
    _coinView = nil;
    _multiLabel = nil;
    _chooseNumberPickerView = nil;
    _deleteButton = nil;
    _bottomButton = nil;
    _recordButton = nil;
    _numArray = nil;
    _coinsNum = nil;
    _model = nil;
    _scrollBackView = nil;
    [self removeObserver:self forKeyPath:@"isRecording"];
}

- (instancetype)initWithModel:(rewardListModel *)model{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        self.isRecording = HaventRecord;
        self.model = model;
        [self setNumArrayWithNum:model.range startFrom:model.coins];
        [self setCoinsNumWithMininum:model.coins];
        
         [self addObserver:self forKeyPath:@"isRecording" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        
      //  [self addSubview:self.backgroundView];
        [self addSubview:self.coinView];
        [self addSubview:self.multiLabel];
        [self addSubview:self.scrollBackView];
        [self addSubview:self.chooseNumberPickerView];
        [self addSubview:self.deleteButton];
        [self addSubview:self.bottomButton];
        [self addSubview:self.recordButton];
        
        //[self bringSubviewToFront:self.chooseNumberPickerView];
        //self.chooseNumberPickerView.layer.borderWidth = 1.f;
        WS(weakSelf, self);
//        [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(weakSelf.mas_left).with.offset(0);
//            make.right.equalTo(weakSelf.mas_right).with.offset(0);
//            make.top.equalTo(weakSelf.mas_top).with.offset(0);
//            make.height.mas_equalTo(CustomHeight(350));
//        }];
        
        [self.coinView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left).with.offset(CustomWidth(55));
            make.top.equalTo(weakSelf.mas_top).with.offset(CustomHeight(70));
            make.width.mas_equalTo(CustomWidth(55));
            make.height.mas_equalTo(CustomHeight(55));
        }];
        
        [self.multiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.coinView.mas_right).with.offset(CustomWidth(13));
            make.centerY.mas_equalTo(weakSelf.coinView.mas_centerY);
            make.width.mas_equalTo(CustomWidth(17));
            make.height.mas_equalTo(CustomHeight(35));
        }];
        
//        [self.chooseNumberPickerView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(weakSelf.multiLabel.mas_right).with.offset(CustomWidth(8));
//            make.centerY.mas_equalTo(weakSelf.coinView.mas_centerY);
//            make.width.mas_equalTo(CustomWidth(106));
//            make.height.mas_equalTo(CustomWidth(30*3));
//        }];
        
        [self.recordButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left).with.offset(CustomWidth(35));
            make.bottom.equalTo(weakSelf.bottomButton.mas_top).with.offset(-CustomHeight(38));
            make.width.mas_equalTo(CustomWidth(200));
            make.height.mas_equalTo(CustomHeight(40));
        }];
        
        [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.mas_right).with.offset(-CustomWidth(20));
            make.centerY.mas_equalTo(weakSelf.recordButton.mas_centerY);
            make.width.mas_equalTo(CustomWidth(35));
            make.height.mas_equalTo(CustomHeight(35));
        }];
        
        [self.bottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(weakSelf.mas_bottom).with.offset(0);
            make.left.equalTo(weakSelf.mas_left).with.offset(0);
            make.right.equalTo(weakSelf.mas_right).with.offset(0);
            make.height.mas_equalTo(CustomHeight(55));
        }];
    }
    return self;
}

#pragma mark kvo

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"isRecording"]) {
        if (self.isRecording == HaventRecord) {
            
        }else if(self.isRecording == IsRecording){
        
        }else if (self.isRecording == FinishRecord){
         
        }
    }
}

#pragma mark UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.numArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString * str = [NSString stringWithFormat:@"%ld",(long)[self.numArray[row] integerValue]];
    return str;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return CustomWidth(106);
}

#pragma mark UIPickerViewDelegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 0) {
        self.coinsNum = [NSString stringWithFormat:@"%@",[self.numArray objectAtIndex:[pickerView selectedRowInComponent:0]]];
    }
}

#pragma mark private method

#pragma mark event action

- (void)deleteRecord{
    self.isRecording = HaventRecord;
}

- (void)startRecord:(UILongPressGestureRecognizer *)sender{
    if(sender.state == UIGestureRecognizerStateBegan){
       self.isRecording = IsRecording;
    }else if(sender.state == UIGestureRecognizerStateCancelled){
        self.isRecording = FinishRecord;
    }
}

- (void)playRecord{
    NSLog(@"ssss");
}

#pragma mark getters and setters

- (UIImageView *)backgroundView{
    if (!_backgroundView) {
        _backgroundView = [[UIImageView alloc] init];
        _backgroundView.backgroundColor = [UIColor greenColor];
        _backgroundView.alpha = 0.5;
    }
    return _backgroundView;
}

- (UIImageView *)coinView{
    if (!_coinView) {
        _coinView = [[UIImageView alloc] init];
        _coinView.backgroundColor = [UIColor purpleColor];
    }
    return _coinView;
}

- (UILabel *)multiLabel{
    if (!_multiLabel) {
        _multiLabel = [[UILabel alloc] initWithCustomFont:20.f];
        _multiLabel.textColor = [UIColor blackColor];
        _multiLabel.text = @"X";
        _multiLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _multiLabel;
}

- (ChooseNumberScrollView *)chooseNumberPickerView{
    if (!_chooseNumberPickerView) {
        _chooseNumberPickerView = [[ChooseNumberScrollView alloc] initWithModel:self.model andFrame:CGRectMake(CustomWidth(150), CustomHeight(50), CustomWidth(106), CustomHeight(90))];
        _chooseNumberPickerView.backgroundColor = [UIColor clearColor];
        _chooseNumberPickerView.delegate = self;
//        _chooseNumberPickerView.delegate = self;
//        _chooseNumberPickerView.dataSource = self;
    }
    return _chooseNumberPickerView;
}

- (UIButton *)deleteButton{
    if (!_deleteButton) {
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteButton.backgroundColor = [UIColor redColor];
        [_deleteButton addTarget:self action:@selector(deleteRecord) forControlEvents:UIControlEventTouchUpInside];
        
    //    _deleteButton.hidden = YES;
    }
    return _deleteButton;
}

- (UIButton *)bottomButton{
    if (!_bottomButton) {
        _bottomButton = [[UIButton alloc] initWithCustomFont:20.f];
        _bottomButton.titleLabel.textColor = [UIColor whiteColor];
        [_bottomButton setTitle:@"按住 说话" forState:UIControlStateNormal];
        [_bottomButton setBackgroundColor:[UIColor blueColor]];
        
        UILongPressGestureRecognizer * longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(startRecord:)];
        /*最大100像素的运动是手势识别所允许的*/
        longPressGesture.allowableMovement = 100.0f;
        /*这个参数表示,两次点击之间间隔的时间长度。*/
        longPressGesture.minimumPressDuration = 0.1;
        [_bottomButton addGestureRecognizer:longPressGesture];
    }
    return _bottomButton;
}

- (UIButton *)recordButton{
    if (!_recordButton) {
        _recordButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _recordButton.backgroundColor = [UIColor purpleColor];
        [_recordButton addTarget:self action:@selector(playRecord) forControlEvents:UIControlEventTouchUpInside];
        
        //_recordButton.hidden = YES;
    }
    return _recordButton;
}

- (UIView *)scrollBackView{
    if (!_scrollBackView) {
        _scrollBackView = [[UIView alloc] initWithFrame:CGRectMake(CustomWidth(150), CustomHeight(50), CustomWidth(106), CustomHeight(90))];
        _scrollBackView.backgroundColor = [UIColor colorWithRed:255 green:255 blue:255 alpha:0.4];
        
        UIView * line1 = [[UIView alloc] initWithFrame:CGRectMake(0, CustomHeight(30), CustomWidth(106), CustomHeight(2))];
        line1.backgroundColor = [UIColor blueColor];
        
        UIView * line2 = [[UIView alloc] initWithFrame:CGRectMake(0, CustomHeight(60), CustomWidth(106), CustomHeight(2))];
        line2.backgroundColor = [UIColor blueColor];
        
        [_scrollBackView addSubview:line1];
        [_scrollBackView addSubview:line2];
    }
    return _scrollBackView;
}

- (void)setNumArrayWithNum:(NSInteger)range startFrom:(NSInteger)start{
    self.numArray = [[NSMutableArray alloc] init];
    for (NSInteger i = start; i<(range-start+1); i++) {
        [self.numArray addObject:@(i)];
    }
}

- (void)setCoinsNumWithMininum:(NSInteger)num{
    self.coinsNum = [NSString stringWithFormat:@"%ld",(long)num];
}

@end
