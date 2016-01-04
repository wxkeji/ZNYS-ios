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

- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = RGBCOLOR(249, 220, 229);
        
        for (NSInteger i = 0; i < 9; i++) {
            UIButton * numberButton = [[UIButton alloc] initWithCustomFont:20.f];
            numberButton.frame = CGRectMake(24+i*72+i*13, 19+72*i+13*i, 72, 72);
            
            numberButton.tag = i+1;
            [numberButton setTitle:[NSString stringWithFormat:@"%ld",(long)i] forState:UIControlStateNormal];
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
