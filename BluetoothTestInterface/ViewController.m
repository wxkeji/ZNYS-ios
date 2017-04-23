//
//  ViewController.m
//  bluetoothUnitTest
//
//  Created by 张恒铭 on 15/7/30.
//  Copyright © 2015年 张恒铭. All rights reserved.
//

#import "ViewController.h"
#import "SensorDataHandler.h"
#import "AnalysisResultSet.h"
@interface ViewController ()
@property(nonatomic)  BluetoothServer* BLEtest;
@property (weak, nonatomic) IBOutlet UILabel *RTCLabel;
@property (weak, nonatomic) IBOutlet UILabel *BatteryLabel;
@property (weak, nonatomic) IBOutlet UILabel *PressureLabel;
@property (weak, nonatomic) IBOutlet UILabel *quaternionLabel;
@property (weak, nonatomic) IBOutlet UILabel *accelerationLabel;
@property (weak, nonatomic) IBOutlet UIButton *writeRTCLabel;
@property (weak, nonatomic) IBOutlet UITextField *RTCTextField;
@property (weak, nonatomic) IBOutlet UITextField *preesureTextField;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextView *quaternionTextView;
@property (weak, nonatomic) IBOutlet UITextView *accelerationTextView;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.BLEtest = [BluetoothServer defaultServer];
    //接收来自实体类BluetoothServer的通知以改变UI
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateRTC:) name:@"updateRTC" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateBattery:) name:@"updateBattery" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updatePressure:) name:@"updatePressure" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateQuaternion:) name:@"updateQuaternion" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateAcceleration:) name:@"updateAcceleration" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateOnlineQuaternion:) name:@"updateOnlineQuaternion" object:nil];
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateOnlineAcceleration:) name:@"updateOnlineAcceleration" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clearStatisticFininshed:) name:@"clearStatistic" object:nil];
    self.quaternionTextView.delegate = self;
    self.accelerationTextView.delegate = self;

       }
-(void)viewDidLayoutSubviews
{
    [self.scrollView setContentSize:CGSizeMake([[UIScreen mainScreen] bounds].size.width, 700)];
}
#pragma mark - UITextView delegate method

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
#pragma mark - Button Events
- (IBAction)start:(id)sender
{
   // [[BluetoothServer defaultServer] scan];

//    [[BluetoothServer defaultServer] connectDeviceWithFinishBlock:^(BOOL result){
//        NSLog(@"result %i",result);
//    }];
    
//    [[BluetoothServer defaultServer] scan];
    [[BluetoothServer defaultServer] scanWithCompletionBlock:^(NSArray *peripheralsArray ) {
        
        
        NSLog(@"breakPoint");
        
    }];
    
}
- (IBAction)readRTC:(id)sender
{
    [[BluetoothServer defaultServer] readRTC];
}
- (IBAction)writeRTC:(id)sender
{
    if (self.RTCTextField.text == nil)
    {
        NSLog(@"Input the RTC value first");
    }
    else
    {
        [[BluetoothServer defaultServer]correctRTC:self.RTCTextField.text];
    }
}

- (IBAction)readBattery:(id)sender
{
    [[BluetoothServer defaultServer] readBattery];
}
- (IBAction)readPressure:(id)sender
{
    [[BluetoothServer defaultServer] readPressure];
}
- (IBAction)buzzer:(id)sender
{
    [[BluetoothServer defaultServer] buzzer];
}

- (IBAction)receiveOnlineData:(id)sender
{
    [[BluetoothServer defaultServer]turnOnOnlineDataNotify];
}
-(void)stopReceiveOnlineData
{
    [[BluetoothServer defaultServer]TurnOffOnlineDataNotify];
}
-(void)receiveOfflineData
{
    [[BluetoothServer defaultServer]turnOnOfflineDataNotify];
}
-(void)stopReceiveOfflineData
{
    [[BluetoothServer defaultServer]turnOffOfflineDataNotify];
}
- (IBAction)clearStatistic:(id)sender
{
    [[BluetoothServer defaultServer] light];
}

- (IBAction)writePressure:(id)sender
{
    [[BluetoothServer defaultServer]setBrushingAndAlarmBarrier:self.preesureTextField.text];
}

- (IBAction)stop:(id)sender
{
    [[BluetoothServer defaultServer] shutDown];
}
- (IBAction)logOnlineData
{
  //  NSLog(@"The Online Data stored: %@",[SensorData DataStore].onlineDataArray);
//The function of this button is no used anymore
}
- (IBAction)logOfflineData
{
//    NSLog(@"The Offline data stored:%@",[SensorData DataStore].offlineDataArray);
    //This button can be removed,too
}
- (IBAction)onlineDataSwitch:(id)sender
{
    if ([sender isOn])
    {
        [self receiveOnlineData:nil];
    }
    else
    {
        [self stopReceiveOnlineData];
    }
}
- (IBAction)offlineDataSwitch:(id)sender
{
    if ([sender isOn])
    {
        [self receiveOfflineData];
    }
    else
    {
        [self stopReceiveOfflineData];
    }

}
- (IBAction)analysis
{
    NSMutableString* resultAlertString = [[NSMutableString alloc] init];

    NSMutableArray *senserDataHandlersArray = [BluetoothServer defaultServer].sensorDataHandlersArray;
    
    if (senserDataHandlersArray)
    {
        for (SensorDataHandler* sensorDataHandler in [[BluetoothServer defaultServer] sensorDataHandlersArray] )
        {
            [sensorDataHandler statisticalAnalyseAll];
            [sensorDataHandler classifyAreas];
            AnalysisResultSet* result = [ [AnalysisResultSet alloc] init];
            result = [sensorDataHandler getFinalResult];
            for (NSString* key in result.dataDictionary)
            {
                NSString* type = [[NSString alloc] init];
                switch ([key intValue])
                {
                    case 0:
                        type = @"front_outer";
                        break;
                    case 1:
                        type = @"left_outer";
                        break;
                    case 2:
                        type = @"right_outer";
                        break;
                    case 3:
                        type = @"left_inner_up";
                        break;
                    case 4:
                        type = @"left_inner_down";
                        break;
                    case 5:
                        type = @"right_inner_up";
                        break;
                    case 6:
                        type = @"right_inner_down";
                        break;
                    case 7:
                        type = @"front_inner_up";
                        break;
                    case 8:
                        type = @"front_inner_down";
                        break;
                    case 9:
                        type = @"left_middle_up";
                        break;
                    case 10:
                        type = @"left_middle_down";
                        break;
                    case 11:
                        type = @"right_middle_up";
                        break;
                    case 12:
                        type = @"right_middle_down";
                        break;
                    case 13:
                        type = @"unknown";
                        break;
                        
                    default:
                        type = @"ERROR_TYPE";
                        break;
                }
                AnalysisResultItem* resultItem =[result.dataDictionary objectForKey:key];
                [resultAlertString appendString:[NSString stringWithFormat:@"区域:%@(Correct:%d)\r\n刷牙时长：%ld\r\n刷牙次数%i\r\n",type,resultItem.isCorrect,resultItem.duration,resultItem.brushTime]];
            }
            [resultAlertString appendString:@"---------\r\n新的一次刷牙数据\r\n---------\r\n"];
        }
    }
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0)
    {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"分析结果"
        message:resultAlertString
        preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK"
        style:UIAlertActionStyleDefault
        handler:^(UIAlertAction * action) {}];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]
                            initWithTitle:@"分析结果"
                            message:resultAlertString
                            delegate:self
                            cancelButtonTitle:@"确定"
                            otherButtonTitles:@"取消",nil
                            ];
        alert.alertViewStyle=UIAlertViewStyleDefault;
        [alert show];
    }
}

- (IBAction)readHardwareVersion:(id)sender
{
}



#pragma mark - update UI
-(void)updateRTC:(NSNotification*)notification
{
    NSString* string = [notification object];
    [self.RTCLabel setText:string];
}
-(void)updateBattery:(NSNotification*)notification
{
    NSString* string = [notification object];
    [self.BatteryLabel setText:string ];
}
-(void)updatePressure:(NSNotification*)notification
{
    NSString* string = [notification object];
    [self.PressureLabel setText:string];
}
-(void)updateQuaternion:(NSNotification*)notification
{
    NSString* string = [notification object];
    [self.quaternionLabel setText:string];
}
-(void)updateAcceleration:(NSNotification*)notification
{
    NSString* string = [notification object];
    [self.accelerationLabel setText:string];
}
-(void)updateOnlineQuaternion:(NSNotification*)notification
{
    NSString* string = [notification object];
    [self.quaternionTextView setText:string];
}
-(void)updateOnlineAcceleration:(NSNotification*)notification
{
    NSString* string = [notification object];
    [self.accelerationTextView setText:string];
}
-(void)clearStatisticFininshed
{
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
