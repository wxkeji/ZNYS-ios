

//
//  AwardManager.m
//  ZNYS
//
//  Created by 张恒铭 on 4/27/16.
//  Copyright © 2016 Woodseen. All rights reserved.
//

#import "AwardManager.h"

@implementation AwardManager
+(instancetype)sharedInstance
{
    static AwardManager* sharedManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[AwardManager alloc] init];
    });
    return sharedManager;
}

-(void)createWithAward:(Award *)award
{
    [[CoreDataHelper sharedInstance] createNewAwardWithAward:award];
}

- (Award*)retrieveWithAwardUUID:(NSString *)UUID
{
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"%@ like %@",@"uuid",UUID];
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:@"Award"];
    [request setPredicate:predicate];
  return  (Award*)[[CoreDataHelper sharedInstance].context executeRequest:request error:nil];
}
- (void)deleteAward:(Award*)award
{
    [[CoreDataHelper sharedInstance].context deleteObject:award];
}
@end
