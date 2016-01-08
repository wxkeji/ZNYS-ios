//
//  DialogView.h
//  ZNYS
//
//  Created by mac on 15/9/19.
//  Copyright © 2015年 Woodseen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DialogView;

@protocol DialogViewDelegate <NSObject>

- (void)removeDialogView:(DialogView *)dialogView;

@end

@interface DialogView : UIView

@property (assign,nonatomic) id<DialogViewDelegate> delegate;

+(DialogView *)instanceDialogView;
+(DialogView *)instanceDialogViewWithItemName:(NSString *)itemName conditionToGet:(NSString *)conditionToGet descriptionText:(NSString *)descriptionText;

@end
