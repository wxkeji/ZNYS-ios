

//
//  AwardManager.m
//  ZNYS
//
//  Created by 张恒铭 on 4/27/16.
//  Copyright © 2016 Woodseen. All rights reserved.
//

#import "AwardManager.h"
#import "UserManager.h"

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



- (NSMutableArray <NSMutableArray<Award *> *>*)getNotAddedAwardWithUseruuid:(NSString*)uuid
{
    NSMutableArray<NSMutableArray<Award *> *>* resultArray = [NSMutableArray array];
    NSMutableArray<Award *>* consumeArray = [NSMutableArray array];
    NSMutableArray<Award *>* possessArray = [NSMutableArray array];
    NSMutableArray<Award *>* activityArray = [NSMutableArray array];
    
    NSPredicate* consumePredicate = [NSPredicate predicateWithFormat:@"type == %@ && status == %@ && userID == %@",@"consume",@"notAdded",uuid];
    consumeArray = (NSMutableArray<Award *>*)[[CoreDataHelper sharedInstance] retrieveAwardsWithPredicate:consumePredicate];
    
    NSPredicate* possessPredicate = [NSPredicate predicateWithFormat:@"type == %@ && status == %@ && userID == %@",@"possess",@"notAdded",uuid];
    possessArray = (NSMutableArray<Award *>*)[[CoreDataHelper sharedInstance] retrieveAwardsWithPredicate:possessPredicate];
    
    NSPredicate* activityPredicate = [NSPredicate predicateWithFormat:@"type == %@ && status == %@ &&userID = %@",@"activity",@"notAdded",uuid];
    activityArray = (NSMutableArray<Award *>*)[[CoreDataHelper sharedInstance] retrieveAwardsWithPredicate:activityPredicate];
    
    [resultArray addObject:consumeArray];
    [resultArray addObject:possessArray];
    [resultArray addObject:activityArray];
    
    return [resultArray copy];

}



- (NSMutableArray <NSMutableArray<Award *> *>*)getAddedAwardWithUseruuid:(NSString*)uuid
{
    NSMutableArray<NSMutableArray<Award *> *>* resultArray = [NSMutableArray array];
    NSMutableArray<Award *>* consumeArray = [NSMutableArray array];
    NSMutableArray<Award *>* possessArray = [NSMutableArray array];
    NSMutableArray<Award *>* activityArray = [NSMutableArray array];
    
    NSPredicate* consumePredicate = [NSPredicate predicateWithFormat:@"type == %@ && status == %@ && userID == %@",@"consume",@"added",uuid];
    consumeArray = (NSMutableArray<Award *>*)[[CoreDataHelper sharedInstance] retrieveAwardsWithPredicate:consumePredicate];
    
    NSPredicate* possessPredicate = [NSPredicate predicateWithFormat:@"type == %@ && status == %@ && userID == %@",@"possess",@"added",uuid];
    possessArray = (NSMutableArray<Award *>*)[[CoreDataHelper sharedInstance] retrieveAwardsWithPredicate:possessPredicate];
    
    NSPredicate* activityPredicate = [NSPredicate predicateWithFormat:@"type == %@ && status == %@ &&userID = %@",@"activity",@"added",uuid];
    activityArray = (NSMutableArray<Award *>*)[[CoreDataHelper sharedInstance] retrieveAwardsWithPredicate:activityPredicate];
    
    
    
    [resultArray addObject:consumeArray];
    [resultArray addObject:possessArray];
    [resultArray addObject:activityArray];
    
    return [resultArray copy];
    
}


- (BOOL)addAwardWithAwarduuid:(NSString*)uuid voicePath:(NSString*)voicePath coin:(int32_t)coin
{
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"uuid = %@",uuid];
    
    //理论上不存在两个uuid相等的奖品，可以直接取结果数组的第一项作为找到的奖品
    Award* matchedAward = [[CoreDataHelper sharedInstance] retrieveAwardsWithPredicate:predicate][0];
    if (matchedAward) {
        //从数据库里取出来的对象的修改可以直接反映在数据库中
        matchedAward.voice = voicePath;
        matchedAward.price = coin;
        matchedAward.status = @"added";
        [[CoreDataHelper sharedInstance] save];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"AddAwardSuccess" object:nil];
        return YES;
    }
    return NO;
}

- (BOOL)exchangeAwardWithAwarduuid:(NSString*)awarduuid
{
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"uuid = %@",awarduuid];
    //理论上不存在两个uuid相等的奖品，可以直接取结果数组的第一项作为找到的奖品
    
    NSArray* result ;
    result =  [[CoreDataHelper sharedInstance] retrieveAwardsWithPredicate:predicate];
    Award* matchedAward;
    if ([result count]) {
        matchedAward = result[0];
    } else {
        matchedAward = nil;
    }
    if (!matchedAward) {
        return NO;
    }
    [[UserManager sharedInstance] changeCurrentTokensByAdding:-matchedAward.price];
    
    matchedAward.price = matchedAward.minPrice;
    matchedAward.status = @"notAdded";
    [[CoreDataHelper sharedInstance] save];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"exchangeAwardSuccess" object:nil];
    return YES;
}

- (BOOL)deleteAwardWithAwardUUID:(NSString *)awarduuid{
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"uuid = %@",awarduuid];
    //理论上不存在两个uuid相等的奖品，可以直接取结果数组的第一项作为找到的奖品
    
    NSArray* result ;
    result =  [[CoreDataHelper sharedInstance] retrieveAwardsWithPredicate:predicate];
    Award* matchedAward;
    if ([result count]) {
        matchedAward = result[0];
    } else {
        matchedAward = nil;
    }
    if (!matchedAward) {
        return NO;
    }
    matchedAward.price = matchedAward.minPrice;
    matchedAward.status = @"notAdded";
    [[CoreDataHelper sharedInstance] save];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"deleteAwardSuccess" object:nil];
    return YES;
}

- (NSMutableArray<Award *>*)getAllAddedAwardWithUseruuid:(NSString*)userUUID
{
    NSMutableArray * resultArray;
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"status == %@ && userID == %@",@"added",userUUID];
    
    resultArray = (NSMutableArray <Award *>*)[[CoreDataHelper sharedInstance] retrieveAwardsWithPredicate:predicate];
    
    return resultArray;
}


@end
