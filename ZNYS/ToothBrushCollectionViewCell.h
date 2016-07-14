//
//  ToothBrushCollectionViewCell.h
//  ZNYS
//
//  Created by 张恒铭 on 7/13/16.
//  Copyright © 2016 Woodseen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToothBrush+CoreDataProperties.h"
#define cellOriginalColor RGBCOLOR(0, 161, 255)
#define cellSelectedColor RGBCOLOR(241, 117, 0)
@interface ToothBrushCollectionViewCell : UICollectionViewCell


-(void)setToothBrush:(ToothBrush*)brush;

@end
