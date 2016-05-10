//
//  MAKAFakeRootAlertView.h
//  OnceAlbum
//
//  Created by Ellise on 15/10/20.
//  Copyright © 2015年 &#23609;&#40527;&#39134;. All rights reserved.
//

#import "ZNYSBaseView.h"

@interface MAKAFakeRootAlertView : ZNYSBaseView

/**
 *  需要显示的view
 */
@property (nonatomic, weak) UIView * mainView;

- (void)setUpView:(UIView *)mainView;

- (void)show;

- (void)dismiss;

@end
