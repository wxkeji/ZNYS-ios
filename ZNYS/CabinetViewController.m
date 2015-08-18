//
//  ViewController.m
//  ZNYS
//
//  Created by mac on 15/8/7.
//  Copyright (c) 2015年 Woodseen. All rights reserved.
//

#import "CabinetViewController.h"
#import "Config.h"
@interface CabinetViewController ()

@property (strong, nonatomic) IBOutlet UIView *cabinetView;
@property (strong,nonatomic) UIPageControl *cabinetPageControl;
- (IBAction)synchronize:(id)sender;

@end

@implementation CabinetViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    //设置PageController
    self.cabinetPageControl = [[UIPageControl alloc] initWithFrame:self.cabinetView.bounds];
    self.cabinetPageControl.numberOfPages = 2;
    [self.cabinetPageControl addTarget:self action:@selector(pageChanged:) forControlEvents:UIControlEventValueChanged];
    [self.cabinetView addSubview:self.cabinetPageControl];
    
    //初始化奖品状态管理器
    self.giftStatusManager = [[GiftStatusManager alloc] init];
    
    //从文件中读取数据
    
    
    NSArray *cabinetSubViews = [self.cabinetPageControl subviews];
    
    int count = 0;
    for(UIView *subView in cabinetSubViews)
    {
#if MYDEBUG == YES
        NSLog(@"Subview's type of pageControl:%@",[subView class]);
        count++;
        
#else
        if([NSStringFromClass([subView class]) isEqualToString:@"ImageView"])
        {
            ;
        }
#endif
    }
    NSLog(@"Total number of subviews is:%d",count);
 

}

- (void)pageChanged:(id)sender
{
    UIPageControl *control = (UIPageControl *)sender;
    NSInteger page = control.currentPage;
    NSArray *giftArray = [self.giftStatusManager giftOfPage:page];
    NSArray *cabinetSubViews = [self.cabinetView subviews];
    for(UIView *subView in cabinetSubViews)
    {
#if MYDEBUG == YES
        NSLog(@"Subview's type of cabinetView:%@",[subView class]);
#else
        if([NSStringFromClass([subView class]) isEqualToString:@"ImageView"])
        {
            ;
        }
#endif
    }
    
}

- (IBAction)synchronize:(id)sender
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end//  ViewController