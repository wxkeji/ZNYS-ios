//
//  MAKAFakeRootAlertView.m
//  OnceAlbum
//
//  Created by Ellise on 15/10/20.
//  Copyright © 2015年 &#23609;&#40527;&#39134;. All rights reserved.
//

#import "MAKAFakeRootAlertView.h"

@class FakeAlertViewBackground;

static FakeAlertViewBackground * fakeAlertViewBackground;

@interface FakeAlertViewBackground : UIWindow
@end

@implementation FakeAlertViewBackground

#pragma mark life cycle

- (void)dealloc{
    self.rootViewController = nil;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.opaque = NO;
        self.windowLevel = UIWindowLevelAlert;
        
        UIViewController * controller = [[UIViewController alloc]init];
        controller.view.backgroundColor = [UIColor clearColor];
        self.rootViewController = controller;
        
        [self makeKeyAndVisible];
    }
    return self;
}

#pragma mark private method

+ (void)showBackground{
    if (!fakeAlertViewBackground) {
        fakeAlertViewBackground = [[FakeAlertViewBackground alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
        fakeAlertViewBackground.alpha = 0;
        [UIView animateWithDuration:0.3 animations:^{
            fakeAlertViewBackground.alpha = 1;
        }];
    }
}

+ (void)hideBackgroundAnimated:(BOOL)animated{
    if (!animated) {
        fakeAlertViewBackground.rootViewController = nil;
        [fakeAlertViewBackground removeFromSuperview];
        fakeAlertViewBackground = nil;
        return;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        fakeAlertViewBackground.alpha = 0;
    } completion:^(BOOL finished) {
        fakeAlertViewBackground.rootViewController = nil;
        [fakeAlertViewBackground removeFromSuperview];
        fakeAlertViewBackground = nil;
    }];
}

@end



@interface FakeAlertViewController : UIViewController

@property (nonatomic, weak) MAKAFakeRootAlertView * alertView;
@property (nonatomic, strong) UIButton * backgroundButton;

@end

@implementation FakeAlertViewController

#pragma mark life cycle

- (void)dealloc{
    _alertView = nil;
    self.view = nil;
    _backgroundButton = nil;
}

- (void)loadView{
    [super loadView];
    self.view = _alertView;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    
    self.backgroundButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backgroundButton.frame = CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT);
    self.backgroundButton.backgroundColor = [UIColor colorWithRed:255 green:255 blue:255 alpha:0.5];
    [self.backgroundButton addTarget:self action:@selector(backgroundButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backgroundButton];
    
    [_alertView setUpView:_alertView.mainView];
}

- (void)backgroundButtonClicked{
    [_alertView dismiss];
}

@end

@interface MAKAFakeRootAlertView()
{
    UIWindow * _backgroundWindow;
}

@end

@implementation MAKAFakeRootAlertView

#pragma mark life cycle

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    _mainView = nil;
    _backgroundWindow = nil;
}

- (id)init{
    self = [super initWithFrame:[[UIScreen mainScreen] bounds]];
    if(self){
    }
    return self;
}

- (void)viewWillDisappear{
    [self autoDismiss];
}

#pragma mark private method

- (void)setUpView:(UIView *)mainView{
    
    FakeAlertViewController * viewController = [[FakeAlertViewController alloc]init];
    viewController.alertView = self;
    
    if (!_backgroundWindow) {
        UIWindow * window = [[UIWindow alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
        window.opaque = NO;
        window.windowLevel = UIWindowLevelAlert;
        window.rootViewController = viewController;
        _backgroundWindow = window;
        [_backgroundWindow  addSubview:self];
    }
    [_backgroundWindow makeKeyAndVisible];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(viewWillDisappear) name:@"ViewWillDisappear" object:nil];
    
    if (!_mainView) {
        _mainView = mainView;
       // DLog(@"%@",NSStringFromCGRect(self.frame));
        _mainView.center = self.center;
        [self addSubview:_mainView];
    }
}

- (void)show{
    [FakeAlertViewBackground showBackground];
    
    FakeAlertViewController * viewController = [[FakeAlertViewController alloc]init];
    viewController.alertView = self;
    
    if (!_backgroundWindow) {
        UIWindow * window = [[UIWindow alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
        window.opaque = NO;
        window.windowLevel = UIWindowLevelAlert;
        window.rootViewController = viewController;
        _backgroundWindow = window;
    }
    [_backgroundWindow makeKeyAndVisible];
    
    [self transitionIn];
}

- (void)dismiss{
  //  [[NSNotificationCenter defaultCenter] postNotificationName:@"PageControlWillDismiss" object:nil];
    
    [self autoDismiss];
}

- (void)autoDismiss{
    [FakeAlertViewBackground hideBackgroundAnimated:YES];
    [self transitionOut];
}

- (void)clearAll{
    [_mainView removeFromSuperview];
    _mainView = nil;
    [_backgroundWindow removeFromSuperview];
    _backgroundWindow = nil;
    
    if([self.superview isKindOfClass:[UIWindow class]]){
        UIWindow *window = (UIWindow *)self.superview;
        window.frame = CGRectZero;
        [window removeFromSuperview];
        window = nil;
    }
}

#pragma mark animation method

- (CAKeyframeAnimation *)setUpBasicAnimation{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    animation.duration = 0.2;
    return animation;
}

- (void)transitionIn{
    CAKeyframeAnimation * mainViewAni = [self setUpBasicAnimation];
    mainViewAni.values = @[@(0.7),@(1)];
    mainViewAni.keyTimes = @[@(0),@(1)];
    
    [_mainView.layer addAnimation:mainViewAni forKey:@"mainViewAni"];
}

- (void)transitionOut{
    CAKeyframeAnimation * mainViewAni = [self setUpBasicAnimation];
    mainViewAni.values = @[@(1),@(0.2)];
    mainViewAni.keyTimes = @[@(0),@(1)];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.opacity"];
    animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    animation.duration = 0.15;
    animation.values = @[@(1),@(1),@(0)];
    animation.keyTimes = @[@(0),@(0.3),@(1)];
    animation.delegate = self;
    
    [_mainView.layer addAnimation:mainViewAni forKey:@"mainViewAni"];
    [_mainView.layer addAnimation:animation forKey:@"mainViewOpacityAni"];
    _mainView.transform = CGAffineTransformMakeScale(0, 0);
    //_mainView.alpha = 0;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [self clearAll];
}

@end
