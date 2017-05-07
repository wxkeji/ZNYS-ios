//
//  FindNewToothBrushCollectionviewDatasource.h
//  ZNYS
//
//  Created by 张恒铭 on 7/14/16.
//  Copyright © 2016 Woodseen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ToothBrushManagentFindView.h"
#import "ToothBrush+CoreDataClass.h"
@interface FindNewToothBrushCollectionviewDatasource : NSObject<UICollectionViewDataSource>

@property(nonatomic,weak) ToothBrushManagentFindView* findView;

@property(nonatomic, strong) NSArray *foundToothBrushes;

+(instancetype)sharedInstance;    

@end
