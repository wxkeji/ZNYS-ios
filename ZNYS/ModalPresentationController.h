//
//  ModalPresentationController.h
//  TestModalViewController
//
//  Created by yu243e on 16/12/22.
//  Copyright © 2016年 yu243e. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, ZNYSModalPresentationStyle) {
    ZNYSModalPresentationStyleFromTop,
    ZNYSModalPresentationStyleFromBottom
};

@interface ModalPresentationController : UIPresentationController <UIViewControllerTransitioningDelegate>

@property (nonatomic, assign) ZNYSModalPresentationStyle modalStyle;
@end
