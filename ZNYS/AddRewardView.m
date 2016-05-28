//
//  AddRewardView.m
//  ZNYS
//
//  Created by Ellise on 16/4/29.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "AddRewardView.h"
#import "ChooseNumberScrollView.h"

#define kRecordAudioFile @"myRecord.caf"

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

@property (nonatomic,strong) UIView * recordingView;

@property (nonatomic,strong) NSMutableArray<NSNumber *> * numArray;

@property (nonatomic,strong) NSString * coinsNum;

@property (nonatomic,strong) UIView * scrollBackView;

@property (nonatomic,strong) UILongPressGestureRecognizer * longPressGesture;
@property (nonatomic,strong) UITapGestureRecognizer * tapGesture;

@property (nonatomic,strong) AVAudioRecorder *audioRecorder;//音频录音机
@property (nonatomic,strong) AVAudioPlayer *audioPlayer;//音频播放器，用于播放录音文件
@property (nonatomic,strong) NSTimer *timer;//录音声波监控（注意这里暂时不对播放进行监控）
@property (nonatomic,strong)  UIProgressView *audioPower;//音频波动

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
    _recordingView = nil;
    _audioPlayer = nil;
    _audioPower = nil;
    _audioRecorder = nil;
    _timer = nil;
    _dismissBlock = nil;
    [self removeObserver:self forKeyPath:@"isRecording"];
}

- (instancetype)initWithModel:(rewardListModel *)model{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        self.isRecording = HaventRecord;
        self.model = model;
        self.model.recordUrl = [NSString string];
        [self setNumArrayWithNum:model.range startFrom:model.coins];
        [self setCoinsNumWithMininum:model.coins];
        
         [self addObserver:self forKeyPath:@"isRecording" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        
        [self addSubview:self.coinView];
        [self addSubview:self.multiLabel];
        [self addSubview:self.scrollBackView];
        [self addSubview:self.chooseNumberPickerView];
        [self addSubview:self.deleteButton];
        [self addSubview:self.bottomButton];
        [self addSubview:self.recordButton];
        [self addSubview:self.recordingView];
        [self addSubview:self.audioPower];
        
        WS(weakSelf, self);
        
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
        
        [self.recordingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(weakSelf.bottomButton.mas_top).with.offset(-CustomHeight(30));
            make.centerX.mas_equalTo(weakSelf.mas_centerX);
            make.width.mas_equalTo(CustomWidth(100));
            make.height.mas_equalTo(CustomHeight(100));
        }];
        
        [self.audioPower mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(weakSelf.bottomButton.mas_top).with.offset(-CustomHeight(20));
            make.centerX.mas_equalTo(weakSelf.mas_centerX);
            make.width.mas_equalTo(CustomWidth(100));
            make.height.mas_equalTo(CustomHeight(5));
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
            self.recordButton.hidden = YES;
            self.deleteButton.hidden = YES;
            self.audioPower.hidden = NO;
            self.recordingView.hidden = NO;
            
            [_bottomButton removeGestureRecognizer:self.tapGesture];
            [_bottomButton addGestureRecognizer:self.longPressGesture];
            [_bottomButton setTitle:@"按住 说话" forState:UIControlStateNormal];
        }else if(self.isRecording == IsRecording){
            if (![self.audioRecorder isRecording]) {
                [self.audioRecorder record];//首次使用应用时如果调用record方法会询问用户是否允许使用麦克风
                self.timer.fireDate=[NSDate distantPast];
            }
             [_bottomButton setTitle:@"正在 录音" forState:UIControlStateNormal];
        }else if (self.isRecording == FinishRecord){
            [self.audioRecorder stop];
            self.timer.fireDate=[NSDate distantFuture];
            self.audioPower.progress=0.0;
            
            self.audioPower.hidden = YES;
            self.recordingView.hidden = YES;
            self.recordButton.hidden = NO;
            self.deleteButton.hidden = NO;
            
            [_bottomButton setTitle:@"确定 添加" forState:UIControlStateNormal];
            [_bottomButton removeGestureRecognizer:self.longPressGesture];
            [_bottomButton addGestureRecognizer:self.tapGesture];
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

/**
 *  设置音频会话
 */
-(void)setAudioSession{
    AVAudioSession *audioSession=[AVAudioSession sharedInstance];
    //设置为播放和录音状态，以便可以在录制完之后播放录音
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    [audioSession setActive:YES error:nil];
}

/**
 *  取得录音文件保存路径
 *
 *  @return 录音文件路径
 */
-(NSURL *)getSavePath{
    NSString *urlStr=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    urlStr=[urlStr stringByAppendingPathComponent:kRecordAudioFile];
    NSLog(@"file path:%@",urlStr);
    NSURL *url=[NSURL fileURLWithPath:urlStr];
    self.model.recordUrl = urlStr;
    return url;
}

/**
 *  取得录音文件设置
 *
 *  @return 录音设置
 */
-(NSDictionary *)getAudioSetting{
    NSMutableDictionary *dicM=[NSMutableDictionary dictionary];
    //设置录音格式
    [dicM setObject:@(kAudioFormatLinearPCM) forKey:AVFormatIDKey];
    //设置录音采样率，8000是电话采样率，对于一般录音已经够了
    [dicM setObject:@(8000) forKey:AVSampleRateKey];
    //设置通道,这里采用单声道
    [dicM setObject:@(1) forKey:AVNumberOfChannelsKey];
    //每个采样点位数,分为8、16、24、32
    [dicM setObject:@(8) forKey:AVLinearPCMBitDepthKey];
    //是否使用浮点数采样
    [dicM setObject:@(YES) forKey:AVLinearPCMIsFloatKey];
    //....其他设置等
    return dicM;
}

-(void)audioPowerChange{
    [self.audioRecorder updateMeters];//更新测量值
    float power= [self.audioRecorder averagePowerForChannel:0];//取得第一个通道的音频，注意音频强度范围时-160到0
    CGFloat progress=(1.0/160.0)*(power+160.0);
    [self.audioPower setProgress:progress];
}

#pragma mark event action

- (void)deleteRecord{
    NSString *documentsDirectory= [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSFileManager * fileManager = [NSFileManager defaultManager];
    NSError * error;
    if ([fileManager removeItemAtPath:self.model.recordUrl error:&error] != YES)
        NSLog(@"Unable to delete file: %@", [error localizedDescription]);
    //显示文件目录的内容
    NSLog(@"Documentsdirectory: %@",
          [fileManager contentsOfDirectoryAtPath:documentsDirectory error:&error]);
    
    self.isRecording = HaventRecord;
}

- (void)startRecord:(UILongPressGestureRecognizer *)sender{
    if(sender.state == UIGestureRecognizerStateBegan){
       self.isRecording = IsRecording;
    }else if(sender.state == UIGestureRecognizerStateEnded){
        self.isRecording = FinishRecord;
    }
}

- (void)tapGesture:(UITapGestureRecognizer *)sender{
    NSLog(@"addReward");
    if (self.dismissBlock) {
        self.dismissBlock();
    }
}

- (void)playRecord{
    NSLog(@"ssss");
    if (![self.audioPlayer isPlaying]) {
        [self.audioPlayer play];
    }
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
        _deleteButton.backgroundColor = [UIColor yellowColor];
        [_deleteButton addTarget:self action:@selector(deleteRecord) forControlEvents:UIControlEventTouchUpInside];
        
        _deleteButton.hidden = YES;
    }
    return _deleteButton;
}

- (UIButton *)bottomButton{
    if (!_bottomButton) {
        _bottomButton = [[UIButton alloc] initWithCustomFont:20.f];
        _bottomButton.titleLabel.textColor = [UIColor whiteColor];
        [_bottomButton setTitle:@"按住 说话" forState:UIControlStateNormal];
        [_bottomButton setBackgroundColor:[UIColor blueColor]];
        
        self.longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(startRecord:)];
        /*最大100像素的运动是手势识别所允许的*/
        self.longPressGesture.allowableMovement = 100.0f;
        /*这个参数表示,两次点击之间间隔的时间长度。*/
        self.longPressGesture.minimumPressDuration = 0.1;
        [_bottomButton addGestureRecognizer:self.longPressGesture];
        
        self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
        self.tapGesture.numberOfTapsRequired = 1; //点击次数
        self.tapGesture.numberOfTouchesRequired = 1; //点击手指数
    }
    return _bottomButton;
}

- (UIButton *)recordButton{
    if (!_recordButton) {
        _recordButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _recordButton.backgroundColor = [UIColor purpleColor];
        [_recordButton addTarget:self action:@selector(playRecord) forControlEvents:UIControlEventTouchUpInside];
        
        _recordButton.hidden = YES;
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

- (UIView *)recordingView{
    if (!_recordingView) {
        _recordingView = [[UIView alloc] init];
        _recordingView.backgroundColor = [UIColor purpleColor];
    }
    return _recordingView;
}

-(AVAudioRecorder *)audioRecorder{
    if (!_audioRecorder) {
        //创建录音文件保存路径
        NSURL *url=[self getSavePath];
        //创建录音格式设置
        NSDictionary *setting=[self getAudioSetting];
        //创建录音机
        NSError *error=nil;
        _audioRecorder=[[AVAudioRecorder alloc]initWithURL:url settings:setting error:&error];
        _audioRecorder.delegate=self;
        _audioRecorder.meteringEnabled=YES;//如果要监控声波则必须设置为YES
        if (error) {
            NSLog(@"创建录音机对象时发生错误，错误信息：%@",error.localizedDescription);
            return nil;
        }
    }
    return _audioRecorder;
}

-(AVAudioPlayer *)audioPlayer{
    if (!_audioPlayer) {
        NSURL *url=[self getSavePath];
        NSError *error=nil;
        _audioPlayer=[[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
        _audioPlayer.numberOfLoops=0;
        [_audioPlayer prepareToPlay];
        if (error) {
            NSLog(@"创建播放器过程中发生错误，错误信息：%@",error.localizedDescription);
            return nil;
        }
    }
    return _audioPlayer;
}

- (UIProgressView *)audioPower{
    if (!_audioPower) {
        _audioPower = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        _audioPower.progressTintColor = [UIColor blackColor];
        _audioPower.trackTintColor = [UIColor grayColor];
    }
    return _audioPower;
}

-(NSTimer *)timer{
    if (!_timer) {
        _timer=[NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(audioPowerChange) userInfo:nil repeats:YES];
    }
    return _timer;
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
