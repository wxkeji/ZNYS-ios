//
//  CoreDataHelper.m
//  ZNYS
//
//  Created by 张恒铭 on 12/16/15.
//  Copyright © 2015 Woodseen. All rights reserved.
//

#import "CoreDataHelper.h"
#import "User.h"
@implementation CoreDataHelper

#pragma mark - Initilization methods
+(instancetype)sharedInstance
{
    static dispatch_once_t pred = 0;
    static CoreDataHelper *instance = nil;
    dispatch_once(&pred, ^{
        instance = [[CoreDataHelper alloc] initPrivate];
        [instance loadStore];
    });
    return instance;
}
-(instancetype)init
{
    NSLog(@"Singleton object, user sharedInstance method to get instance");
    NSAssert(1, nil);
    return nil;
}
#pragma mark - FILES

NSString* storeFilename = @"database.sqlite";

#pragma mark - PATHS
-(NSString*)applicationDocumentsDirectory
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}
-(NSURL*)applicationStoresDirectory
{
    NSURL *storesDirectory =
    [[NSURL fileURLWithPath:[self applicationDocumentsDirectory]]
     URLByAppendingPathComponent:@"Stores"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:[storesDirectory path]]) {
        NSError *error = nil;
        if ([fileManager createDirectoryAtURL:storesDirectory
                  withIntermediateDirectories:YES attributes:nil
                                        error:&error]) {
            if (debug==1) {
                NSLog(@"Successfully created Stores directory");}
        }
        else {NSLog(@"FAILED to create Stores directory: %@", error);} }
    return storesDirectory;
}
-(NSURL*)storeURL
{
    return[[self applicationStoresDirectory] URLByAppendingPathComponent:storeFilename];
}
#pragma mark - setup
- (id)initPrivate {
    if (debug==1)
    {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    self = [super init];
    if (!self)
    {
        return nil;
    }
    _model       = [NSManagedObjectModel mergedModelFromBundles:nil];
    _coordinator = [[NSPersistentStoreCoordinator alloc]
                    initWithManagedObjectModel:_model];
    _context     = [[NSManagedObjectContext alloc]
                    initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_context setPersistentStoreCoordinator:_coordinator];
    return self;
}
- (void)loadStore
{
    if (debug==1)
    {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }
    if (_store)
    {
        return;
    } // Don't load store if it's already loaded
    NSError *error = nil;
    
    
    //use this option if you want to see contents inside sqlite database
    
    
    NSDictionary* options = nil;
    if (checkDatabase == 1)
    {
    options =
  @{NSSQLitePragmasOption: @{@"journal_mode": @"DELETE"}};
    }
    
    _store = [_coordinator addPersistentStoreWithType:NSSQLiteStoreType
                           configuration:nil
                           URL:[self storeURL]
                           options:options error:&error];
    if (!_store)
    {
        NSLog(@"Failed to add store. Error: %@", error);
        abort();
        //要是在这里崩溃了，可以到输出的日志里面找到类似 //Users/EricCheung/Library/Developer/CoreSimulator/Devices/FB072C5D-BACF-4CBD-B9C2-5F6A964244AD/data/Containers/Data/Application/023B8309-ED5A-4F83-A2B6-5A1123CF21A6/Documents/Stores/database.sqlite) 的一个URL，然后把这个url对应的那个database.sqlite文件删除就好了   by张恒铭
    }
    else
    {
        if (debug==1)
        {
            NSLog(@"Successfully added store: %@", _store);
        }
    }
}
#pragma mark - SAVING
-(void)save
{
    if([_context hasChanges])
    {
        NSError* error = nil;
        if([_context save:&error])
        {
            if (debug == 1) {
                NSLog(@"save changes to persistent store") ;
            }
        }
        else
        {
            if (debug == 1)
            NSLog(@"save changes to persistent store failed");
        }
    }
    else
    {
        if (debug == 1)
        NSLog(@"There's no changes to be saved");
    }
}


#pragma mark - test methods,can be deleted anytime


-(NSString*)createUserWithBirthday:(NSString*)birthday
                            gender:(NSString*)gender
                          nickName:(NSString*)nickName
{
    User* user =  [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:self.context];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd"];
    NSDate *birthDate= [dateFormatter dateFromString:birthday];
    NSDate *now = [NSDate date];
    NSTimeInterval timeInterval = [now timeIntervalSinceDate:birthDate];
    double age = timeInterval/(60*60*24*365);//当前多少岁（年）
    
    user.age = [NSString stringWithFormat:@"%f",age];
    user.birthday = birthday;
    user.cycleCountOfHighestLevel = @0;
    user.gender = gender;
    user.level = @1;
    user.nickName = nickName;
    user.photoNumber = @0;
    user.starsOwned = @0;
    user.tokenOwned = @0;
    user.uuid = [[NSUUID UUID] UUIDString];
    [self save];
    [[NSUserDefaults standardUserDefaults]setObject:user.uuid forKey:@"currentUserUID"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"userDidCreate" object:nil];
    return user.uuid;
}
-(NSArray*)retrieveUsers:(NSPredicate*)predicate
{
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    [request setPredicate:predicate];
    return [self.context executeFetchRequest:request error:nil];
}
-(NSArray*)retrieveOtherUsersExcept:(NSString*)uuid
{
    NSArray* tempResult = [self retrieveUsers:[NSPredicate predicateWithFormat:@"uuid != %@",uuid]];
    NSMutableArray* arrayReturned = [[NSMutableArray alloc] init];
    if (tempResult.count>0)
    {
        for (User* user in tempResult)
        {
            [arrayReturned addObject:@{@"name":user.nickName,@"thumb":user.photoNumber,@"uuid":user.uuid}];
        }
        return arrayReturned;

    }
    else return nil;
}
-(BOOL)modifyUserInfoWithUUID:(NSString*)UUID
                     birthday:(NSString*)Birthday
                       gender:(NSString*)gender
                     nickname:(NSString*)nickname
{
   User* userToBeModified  =  [self retrieveUsers:[NSPredicate predicateWithFormat:@"uuid = %@",UUID]][0];
    userToBeModified.birthday = Birthday;
    userToBeModified.gender = gender;
    userToBeModified.nickName = nickname;
    [self save];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"userDetailDidChange" object:nil];
    return YES;
}
-(BOOL)whetherThereIsUser
{
   if([self retrieveUsers:nil].count)
   {
       return YES;
   }
    else
    return NO;
}
@end
