//
//  ViewController.m
//  ZNYS
//
//  Created by mac on 15/8/7.
//  Copyright (c) 2015年 Woodseen. All rights reserved.
//

#import "CabinetViewController.h"
#import "CalendarViewController.h"
#import "IsParentViewController.h"
#import "Config.h"
#import "ItemStatusManagerFile.h"
#import "NSArray+ForceBound.h"
#import "DialogView.h"

@interface CabinetViewController ()

@property UserData *giftStatusManager;
@property (strong, nonatomic) IBOutlet UIScrollView *gloryScrollView;   //奖品柜上层，存放荣誉奖杯等
@property (strong,nonatomic) IBOutlet UIScrollView *bathItemScrollView; //奖品柜下层，存放浴室关键物件

@property (strong, nonatomic) IBOutlet UILabel *stars;//屏幕上显示的星星数

@property (strong,nonatomic) NSMutableDictionary *tagDict;   //保存tag的列表的词典

@property (strong,nonatomic) NSMutableArray *bathItemList;  //保存浴室标志性物品

- (IBAction)calendarButtonTouched:(id)sender;

- (IBAction)synchronize:(id)sender;

//- (IBAction)settingButtonTouched:(id)sender;

@end

@implementation CabinetViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //从文件中读取数据
    
    //初始化tag字典
    self.tagDict = [[NSMutableDictionary alloc] init];
    
    //创建两个列表
    NSMutableArray *gloryList = [[NSMutableArray alloc] init];
    
    //添加物品品到列表中
    
    NSString *littleCar = @"小车_已兑换";
    
    for(int i = 1;i <= 30;i++)
    {
        ItemWithState *gloryItem = [[ItemWithState alloc] initWithItemName:@"littleCar"  imageName:littleCar];
        [gloryList addObject:gloryItem];
    }
    
    
    NSArray *giftList = [gloryList copy];
    
    
    NSString *littleBasketball = @"小篮球_已兑换";
    
    self.bathItemList = [[NSMutableArray alloc] init];
    for(int i = 1;i <= 30;i++)
    {
        ItemWithState *bathItem = [[ItemWithState alloc] initWithItemName:@"littleBasketball"  imageName:littleBasketball];
        [self.bathItemList addObject:bathItem];
    }
    
    UserData *userData = [[UserData alloc] initWithCurrentValidNumbersOfStars:22 gloryItemList:(NSArray *)giftList bathItemList:self.bathItemList];
    
    self.giftStatusManager = userData;

    
    //自动适配与更新布局
    [self.view layoutIfNeeded];
    
        //设置屏幕上的信息
      self.stars.text = [[NSString alloc] initWithFormat:@"%d",self.giftStatusManager.currentValidNumberOfStars];
}

- (void)setItemScrollView:(UIScrollView *)scrollView itemList:(NSMutableArray *)giftList height:(float)height width:(float)width itemEachPage:(long)itemEachPage target:(UIViewController *)target selector:(SEL)selecor tagListName:(NSString *)tagListName startTag:(long)startTag
{
    //根据奖品列表获得礼品柜的个数
    long n = ([giftList count] - 1) / itemEachPage + 1;
    
    //根据礼品柜的个数设置礼品柜scrollView的滚动页数
    scrollView.contentSize = CGSizeMake(width * n, height);
    
    //隐藏cabinetControlView的滚动条
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    
    //打开scrollView的弹簧效果
    scrollView.bounces = YES;
    
    //scrollView额外滚动范围为零
    scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    //开启scrollView的分页
    [scrollView setPagingEnabled:YES];
    
    //每个奖品的宽度为奖品柜宽度的itemEachPage分之一
    CGFloat imgW = width / itemEachPage;
    
    NSMutableArray *tagList = [[NSMutableArray alloc] init];
    
    //在奖品柜视图里添加礼物的图片,并把对应的Tag保存在giftGridListTag里，然后为每一个奖品添加触摸手势
    for(int i=0;i<[giftList count];i++)
    {
        //从奖品管理器中获取第i个奖品
        ItemWithState *gws = giftList[i];
        
        //创建一个button和imageView，用imageView作为button的子View
        UIButton *button = [[UIButton alloc] init];
        UIImageView *imageView = [[UIImageView alloc] init];
        
        imageView.image = [UIImage imageNamed:gws.imageName];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        [button addSubview:imageView];
        
        // nx 和 ny表示在 4 * 2 的奖品方阵中中的位置
        //根据奖品在奖品奖品列表中的位置i算出它在4 * 2方阵中的对应位置
        int nx,ny;
        nx = i;
        ny = 0;
        
        //下面根据nx和ny进一步算出每一个奖品精确的位置
        //奖品柜里面高度的比例为  星星：物品：星星：物品 = 1.52：6.88：1.52：6.88 。从而按照比例推算出定位的坐标
        float buttonX,buttonY,buttonWidth,buttonHeight;
        buttonX = imgW * nx;
        //buttonY = 1.52 / 15.28 * height + 1.0 / 2 * height * ny;
        buttonY = 0;
        buttonWidth = imgW;
        buttonHeight = 6.88 / (15.28 / 2) * height;
        button.frame = CGRectMake(buttonX, buttonY, buttonWidth, buttonHeight);
        imageView.frame = CGRectMake(0, 0, buttonWidth, buttonHeight);
        
        //为button添加点击事件
        [button addTarget:target action:selecor forControlEvents:UIControlEventTouchUpInside];
        
        //把奖品button添加到奖品柜视图
        [scrollView addSubview:button];
        
        //设置button的tag，后面可以用tag找到对应的奖品
        button.tag = startTag + i;
        
        //把奖品的imageView的Tag添加到 gfitGridListTag 数组中
        [tagList addObject:[[NSNumber alloc] initWithLong:[button tag]]];
        
    }
    
     [self.tagDict setObject:tagList forKey:tagListName];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self setItemScrollView:self.gloryScrollView itemList:self.giftStatusManager.gloryItemList height:self.gloryScrollView.frame.size.height width:self.gloryScrollView.frame.size.width itemEachPage:4 target:self selector:@selector(itemWasTouched:) tagListName:@"gloryItemTagList" startTag:TAG_GLORY_ITEM];
    
    [self setItemScrollView:self.bathItemScrollView itemList:self.bathItemList height:self.bathItemScrollView.frame.size.height width:self.bathItemScrollView.frame.size.width itemEachPage:4 target:self selector:@selector(itemWasTouched:) tagListName:@"bathItemTagList" startTag:TAG_BATH_ITEM ];
}


//响应item的点击事件
- (void) itemWasTouched:(id)sender
{
    //获取这个item的tag
    long tag = [sender tag];
    
    //index表示这个item在item列表是第几个
    long index=-1;
    
    NSArray *keys = [self.tagDict allKeys];
    
    for(NSString *key in keys)
    {
        NSMutableArray * tagList = [self.tagDict objectForKey:key];
        unsigned long length = [tagList count];
        
        //通过Tag与 itemTagList 中的 tag 值一一比较从而确定当前被触摸的是第几个奖品
        for(int i=0;i<length;i++)
        {
            NSNumber *currentTag = tagList[i];
            if([currentTag longValue] == tag)
            {
                index = i;
                long indexOfScrollView = tag / 1000 - 1;
                //NSLog(@"Item %ld is touched.Tag is %ld.In scrollView %ld",index,tag,indexOfScrollView);
                
                NSString *itemName,*conditionToGet;
                ItemWithState *item;
                if(indexOfScrollView == 0)
                {
                     item= self.giftStatusManager.gloryItemList[index];
                }
                else
                {
                    item= self.bathItemList[index];
                }
                itemName = item.itemName;
                conditionToGet = [NSString stringWithFormat:@"得到%d颗星星",5];
                
                DialogView *dialogView = [DialogView instanceDialogViewWithItemName:itemName conditionToGet:conditionToGet];
                dialogView.alpha = 1.0;
                dialogView.frame = self.view.bounds;
                [self.view addSubview:dialogView];
                [self.view bringSubviewToFront:dialogView];
                NSLog(@"Subview added.");
                
                return;
            }
        }
    }
        
    NSLog(@"Tag not found");
}

- (IBAction)calendarButtonTouched:(id)sender {
    CalendarViewController *cvc = [[CalendarViewController alloc] init];
    [self.view.window addSubview:cvc.view];
    [self.view.window sendSubviewToBack:self.view];
}

- (IBAction)synchronize:(id)sender
{
    
}
//
//- (IBAction)settingButtonTouched:(id)sender {
//    IsParentViewController *ipvc = [[IsParentViewController alloc] init];
//    [self.view.window addSubview:ipvc.view];
//    [self.view.window sendSubviewToBack:self.view];
//}
- (IBAction)unwindSegue:(UIStoryboardSegue *)sender{
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end//  ViewController