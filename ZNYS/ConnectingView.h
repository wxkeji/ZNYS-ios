//
//  ConnectingView.h
//  ZNYS
//
//  Created by 张恒铭 on 12/18/15.
//  Copyright © 2015 Woodseen. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ConnectingViewDelegate<NSObject>
-(void)returnToHome;
@end
@interface ConnectingView : UIView
@property(nonatomic,strong)id<ConnectingViewDelegate>delegate;
//-(void)updateConnectingProgressFrom:(float)previewProgress
//                                 to:(float)updatedProgress;
@end
