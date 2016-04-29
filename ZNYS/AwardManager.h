//
//  AwardManager.h
//  ZNYS
//
//  Created by 张恒铭 on 4/27/16.
//  Copyright © 2016 Woodseen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Award.h"
#import "CoreDataHelper.h"

@interface AwardManager : NSObject
+ (instancetype)sharedInstance;
- (void)createWithAward:(Award*)award;
- (void)retrieveWithUUID:(NSString*)award;
- (void)updateAward:(Award*)award;
- (void)deleteAward:(Award*)award;
@end
