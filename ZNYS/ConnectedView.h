//
//  ConnectedView.h
//  ZNYS
//
//  Created by 张恒铭 on 12/18/15.
//  Copyright © 2015 Woodseen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ConnectedViewDelegate<NSObject>

-(void)returnToHome;

//-(void)scrollToNextPage;
-(void)setBrushingTiems:(NSUInteger)brusingTimes;
-(void)setBrushingDuration:(NSUInteger)brushingDuration;//暂定以秒作为单位吧
-(void)setNumbesOfStarsGot:(NSUInteger)starsGot;

@end

@interface ConnectedView : UIView

@property(nonatomic,strong)id<ConnectedViewDelegate>delegate;

@end
