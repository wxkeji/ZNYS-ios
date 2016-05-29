

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



- (NSArray*)getNotAddedAwardWithUseruuid:(NSString*)uuid
{
    NSMutableArray* resultArray = [NSMutableArray array];
    NSArray* consumeArray = [NSMutableArray array];
    NSArray* possessArray = [NSMutableArray array];
    NSArray* activityArray = [NSMutableArray array];
    
    NSPredicate* consumePredicate = [NSPredicate predicateWithFormat:@"type == %@ && status == %@ && userID == %@",@"consume",@"notAdded",uuid];
    consumeArray = [[CoreDataHelper sharedInstance] retrieveAwardsWithPredicate:consumePredicate];
    
    NSPredicate* possessPredicate = [NSPredicate predicateWithFormat:@"type == %@ && status == %@ && userID == %@",@"possess",@"notAdded",uuid];
    possessArray = [[CoreDataHelper sharedInstance] retrieveAwardsWithPredicate:possessPredicate];
    
    NSPredicate* activityPredicate = [NSPredicate predicateWithFormat:@"type == %@ && status == %@ &&userID = %@",@"activity",@"notAdded",uuid];
    activityArray = [[CoreDataHelper sharedInstance] retrieveAwardsWithPredicate:activityPredicate];
    
    
    
    [resultArray addObject:consumeArray];
    [resultArray addObject:possessArray];
    [resultArray addObject:activityArray];
    
    return [resultArray copy];

}



- (NSArray*)getAddedAwardWithUseruuid:(NSString*)uuid
{
    NSMutableArray* resultArray = [NSMutableArray array];
    NSArray* consumeArray = [NSMutableArray array];
    NSArray* possessArray = [NSMutableArray array];
    NSArray* activityArray = [NSMutableArray array];
    
    NSPredicate* consumePredicate = [NSPredicate predicateWithFormat:@"type == %@ && status == %@ && userID == %@",@"consume",@"added",uuid];
    consumeArray = [[CoreDataHelper sharedInstance] retrieveAwardsWithPredicate:consumePredicate];
    
    NSPredicate* possessPredicate = [NSPredicate predicateWithFormat:@"type == %@ && status == %@ && userID == %@",@"possess",@"added",uuid];
    possessArray = [[CoreDataHelper sharedInstance] retrieveAwardsWithPredicate:possessPredicate];
    
    NSPredicate* activityPredicate = [NSPredicate predicateWithFormat:@"type == %@ && status == %@ &&userID = %@",@"activity",@"added",uuid];
    activityArray = [[CoreDataHelper sharedInstance] retrieveAwardsWithPredicate:activityPredicate];
    
    
    
    [resultArray addObject:consumeArray];
    [resultArray addObject:possessArray];
    [resultArray addObject:activityArray];
    
    return [resultArray copy];
    
}


- (BOOL)addAwardWithAwarduuid:(NSString*)uuid voicePath:(NSString*)voicePath coin:(NSUInteger*)coin
{
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"uuid = %@",uuid];
    
    //理论上不存在两个uuid相等的奖品，可以直接取结果数组的第一项作为找到的奖品
    Award* matchedAward = [[CoreDataHelper sharedInstance] retrieveAwardsWithPredicate:predicate][0];
    if (matchedAward) {
        //从数据库里取出来的对象的修改可以直接反映在数据库中
        matchedAward.voice = voicePath;
        matchedAward.price = coin;
        [[CoreDataHelper sharedInstance] save];
        return YES;
    }
    return NO;
}

- (BOOL)exchangeAwardWithAwarduuid:(NSString*)awarduuid
{
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"uuid = %@",awarduuid];
    //理论上不存在两个uuid相等的奖品，可以直接取结果数组的第一项作为找到的奖品
    Award* matchedAward = [[CoreDataHelper sharedInstance] retrieveAwardsWithPredicate:predicate][0];
    if (!matchedAward) {
        return NO;
    }
    matchedAward.price = matchedAward.minPrice;
    matchedAward.status = @"notAdded";
    return YES;
}

- (NSArray*)getAllAddedAwardWithUseruuid:(NSString*)userUUID
{
    NSArray* resultArray;
     NSPredicate* predicate = [NSPredicate predicateWithFormat:@"status == %@ && userID == %@",@"added",userUUID];
    
    resultArray = [[CoreDataHelper sharedInstance] retrieveAwardsWithPredicate:predicate];
    
    return resultArray;
}


@end
