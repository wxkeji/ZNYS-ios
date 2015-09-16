//
//  TouchableImageView.h
//  ZNYS
//
//  Created by mac on 15/9/16.
//  Copyright (c) 2015年 Woodseen. All rights reserved.
//------------------------------
//      说明：
//          能够把响应时间委托给其他类的ImageView，
//          用以解决在UIScrollView中不能响应ImageView的点击事件。
//
//      用法：
//          在Controller中，添加imageView.delegate = self

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@protocol ImageViewDelegate
@required

-(void) imageTouchesBegin:(NSUInteger)imageTag;

@end//  ImageViewDelegate

@interface TouchableImageView : UIImageView

@property (nonatomic,assign) id<ImageViewDelegate> delegate;

@end
