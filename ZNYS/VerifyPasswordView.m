//
//  VerifyPasswordView.m
//  ZNYS
//
//  Created by Ellise on 16/1/2.
//  Copyright © 2016年 Woodseen. All rights reserved.
//

#import "VerifyPasswordView.h"

@implementation VerifyPasswordView

#pragma mark life cycle

- (void)dealloc{
    _buttonClickBlock = nil;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGBCOLOR(249, 220, 229);
       // NSLog([NSString stringWithFormat:@"%@%@"],self.frame.size.width,self.frame.size.height);
        
        for (NSInteger i = 0; i < 9; i++) {
            UIButton * numberButton = [[UIButton alloc] initWithCustomFont:50.f];
            
            if (i<3) {
                numberButton.frame = CGRectMake(0.082*self.frame.size.width+(i%3)*0.25*self.frame.size.width+(i%3)*0.043*self.frame.size.width, 0.078*self.frame.size.height, 0.25*self.frame.size.width, 0.25*self.frame.size.width);
            }else if(i>=3&&i<6){
            numberButton.frame = CGRectMake(0.082*self.frame.size.width+(i%3)*0.25*self.frame.size.width+(i%3)*0.043*self.frame.size.width, 0.078*self.frame.size.height+0.25*self.frame.size.width+0.04*self.frame.size.height, 0.25*self.frame.size.width, 0.25*self.frame.size.width);
            }else{
              numberButton.frame = CGRectMake(0.082*self.frame.size.width+(i%3)*0.25*self.frame.size.width+(i%3)*0.043*self.frame.size.width, 0.675*self.frame.size.height, 0.25*self.frame.size.width, 0.25*self.frame.size.width);
            }
            
            
            //numberButton.layer.cornerRadius = 8.0f;
            numberButton.tag = i+1;
            [numberButton setTitle:[NSString stringWithFormat:@"%ld",(long)(i+1)] forState:UIControlStateNormal];
            [numberButton addTarget:self action:@selector(numberButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            
            if ((i%2)) {
                //numberButton.backgroundColor = RGBCOLOR(251, 144, 58);
                [numberButton setBackgroundImage:[UIImage imageWithColor:RGBCOLOR(251, 144, 58)] forState:UIControlStateNormal];
            }else{
                //numberButton.backgroundColor = RGBCOLOR(250, 166, 44);
                [numberButton setBackgroundImage:[UIImage imageWithColor:RGBCOLOR(250, 166, 44)] forState:UIControlStateNormal];
            }
            
            numberButton.layer.masksToBounds = YES;
            numberButton.layer.cornerRadius = 8.0f;
            [self addSubview:numberButton];
        }
    }
    return self;
}

#pragma mark private method

#pragma mark event action

- (void)numberButtonAction:(UIButton *)button{
    if (self.buttonClickBlock) {
        self.buttonClickBlock(button.tag);
    }
}

@end
