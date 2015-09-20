//
//  ViewController.m
//  ZNYS
//
//  Created by mac on 15/8/7.
//  Copyright (c) 2015年 Woodseen. All rights reserved.
//

#import "CabinetViewController.h"
#import "Config.h"
#import "GiftStatusManagerFile.h"
#import "NSArray+ForceBound.h"

@interface CabinetViewController ()

@property ItemStatusManager *giftStatusManager;
@property (strong, nonatomic) IBOutlet UIScrollView *gloryScrollView;   //奖品柜上层，存放荣誉奖杯等
@property (strong,nonatomic) IBOutlet UIScrollView *bathItemScrollView; //奖品柜下层，存放浴室关键物件

@property (strong, nonatomic) IBOutlet UILabel *stars;//屏幕上显示的星星数

@property (strong, nonatomic) NSMutableArray *gloryListTag;//保存对应的奖杯奖牌的Tag
@property (strong,nonatomic) NSMutableArray *bathItemListTag;//保存对应浴室关键物品的Tag

- (IBAction)synchronize:(id)sender;

@end

@implementation CabinetViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //从文件中读取数据
    self.gloryListTag = [[NSMutableArray alloc] init];
    
    
    //创建两个列表
    NSMutableArray *gloryList = [[NSMutableArray alloc] init];
    NSMutableArray *bathItemList = [[NSMutableArray alloc] init];
    
    //添加物品品到列表中
    
    ItemWithState *gloryStatusManager = [[ItemWithState alloc] initWithItemName:@"one"  imageName:@"小车_已兑换"];
    
    for(int i = 0;i < 30;i++)
    {
        [gloryList addObject:gloryStatusManager];
    }
    [gloryList addObject:gloryStatusManager];
    
    NSArray *giftList = [gloryList copy];
    ItemStatusManager *gsm = [[ItemStatusManager alloc] initWithCurrentValidNumbersOfStars:22 giftList:(NSArray *)giftList];
    self.giftStatusManager = gsm;
    
    
    
    
    //自动适配与更新布局
    [self.view layoutIfNeeded];
    
        //设置屏幕上的信息
      self.stars.text = [[NSString alloc] initWithFormat:@"%d",self.giftStatusManager.currentValidNumberOfStars];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //获取礼品柜的宽和高
    CGFloat height = self.gloryScrollView.frame.size.height;
    CGFloat width = self.gloryScrollView.frame.size.width;
    
    //根据奖品列表获得礼品柜的页数
    long n = ([self.giftStatusManager.giftList count] - 1) / 8 + 1;
    
    //根据礼品柜的个数设置礼品柜scrollView的滚动页数
    self.gloryScrollView.contentSize = CGSizeMake(width * n, height);
    
    //隐藏cabinetControlView的滚动条
    self.gloryScrollView.showsHorizontalScrollIndicator = NO;
    self.gloryScrollView.showsVerticalScrollIndicator = NO;
    
    //打开scrollView的弹簧效果
    self.gloryScrollView.bounces = YES;
    
    //scrollView额外滚动范围为零
    self.gloryScrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    //开启scrollView的分页
    [self.gloryScrollView setPagingEnabled:YES];
    
    //每个奖品的宽度为奖品柜宽度的四分之一
    CGFloat imgW = width / 4;
    
    //在奖品柜视图里添加礼物的图片,并把对应的Tag保存在giftGridListTag里，然后为每一个奖品添加触摸手势
    for(int i=0;i<[self.giftStatusManager.giftList count];i++)
    {
        //从奖品管理器中获取第i个奖品
        ItemWithState *gws = self.giftStatusManager.giftList[i];
        
        //创建一个button和imageView，用imageView作为button的子View
        UIButton *button = [[UIButton alloc] init];
        UIImageView *imageView = [[UIImageView alloc] init];
        
        imageView.image = [UIImage imageNamed:gws.imageName];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        [button addSubview:imageView];
        
        // nx 和 ny表示在 4 * 2 的奖品方阵中中的位置
        //根据奖品在奖品奖品列表中的位置i算出它在4 * 2方阵中的对应位置
         int nx,ny;
         nx = i % 4 + i / 8 * 4;
         ny = (i % 8) / 4;
        
        //下面根据nx和ny进一步算出每一个奖品精确的位置
        //奖品柜里面高度的比例为  星星：物品：星星：物品 = 1.52：6.88：1.52：6.88 。从而按照比例推算出定位的坐标
        float buttonX,buttonY,buttonWidth,buttonHeight;
        buttonX = imgW * nx;
        buttonY = 1.52 / 15.28 * height + 1.0 / 2 * height * ny;
        buttonWidth = imgW;
        buttonHeight = 6.88 / 15.28 * height;
        button.frame = CGRectMake(buttonX, buttonY, buttonWidth, buttonHeight);
        imageView.frame = CGRectMake(0, 0, buttonWidth, buttonHeight);
        
        //为button添加点击事件
        [button addTarget:self action:@selector(giftWasTouched:) forControlEvents:UIControlEventTouchUpInside];
        
        //把奖品button添加到奖品柜视图
         [self.gloryScrollView addSubview:button];
        
        //设置button的tag，后面可以用tag找到对应的奖品
        button.tag = TAG_CABINET_GIFT + i;
        
        //把奖品的imageView的Tag添加到 gfitGridListTag 数组中
         [self.gloryListTag addObject:[[NSNumber alloc] initWithLong:[button tag]]];
        
    }

    
}

//响应奖品的点击事件
- (void) giftWasTouched:(id)sender
{
    //获取这个奖品的tag
    long tag = [sender tag];
    
    //index表示这个奖品在奖品列表是第几个
    long index=-1;
    
    unsigned long length = [self.gloryListTag count];
    
    //通过Tag与 giftGridListTag 中的 tag 值一一比较从而确定当前被触摸的是第几个奖品
    for(int i=0;i<length;i++)
    {
        NSNumber *currentTag = self.gloryListTag[i];
        if([currentTag longValue] == tag)
        {
            index = i;
            break;
        }
    }
    
    NSLog(@"Gift %ld is touched.Tag is %ld",index,tag);
}

- (IBAction)synchronize:(id)sender
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end//  ViewController