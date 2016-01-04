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

- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = RGBCOLOR(249, 220, 229);
        
        for (NSInteger i = 0; i < 9; i++) {
            UIButton * numberButton = [[UIButton alloc] initWithCustomFont:50.f];
            
            if (i<3) {
                numberButton.frame = CGRectMake(0.064*kSCREEN_WIDTH+(i%3)*0.192*kSCREEN_WIDTH+(i%3)*0.035*kSCREEN_WIDTH, 0.028*kSCREEN_HEIGHT, 0.192*kSCREEN_WIDTH, 0.192*kSCREEN_WIDTH);
            }else if(i>=3&&i<6){
            numberButton.frame = CGRectMake(0.064*kSCREEN_WIDTH+(i%3)*0.192*kSCREEN_WIDTH+(i%3)*0.035*kSCREEN_WIDTH, 0.028*kSCREEN_HEIGHT+0.108*kSCREEN_HEIGHT+0.019*kSCREEN_HEIGHT, 0.192*kSCREEN_WIDTH, 0.192*kSCREEN_WIDTH);
            }else{
              numberButton.frame = CGRectMake(0.064*kSCREEN_WIDTH+(i%3)*0.192*kSCREEN_WIDTH+(i%3)*0.035*kSCREEN_WIDTH, 0.028*kSCREEN_HEIGHT+0.108*kSCREEN_HEIGHT*2+0.019*kSCREEN_HEIGHT*2, 0.192*kSCREEN_WIDTH, 0.192*kSCREEN_WIDTH);
            }
            
            
            numberButton.layer.cornerRadius = 8.0f;
            numberButton.tag = i+1;
            [numberButton setTitle:[NSString stringWithFormat:@"%ld",(long)(i+1)] forState:UIControlStateNormal];
            [numberButton addTarget:self action:@selector(numberButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            
            if ((i%2)) {
                numberButton.backgroundColor = RGBCOLOR(251, 144, 58);
            }else{
                numberButton.backgroundColor = RGBCOLOR(250, 166, 44);
            }
            
            [self addSubview:numberButton];
        }
    }
    return self;
}

#pragma mark event action

- (void)numberButtonAction:(UIButton *)button{
    if (self.buttonClickBlock) {
        self.buttonClickBlock(button.tag);
    }
}

@end
