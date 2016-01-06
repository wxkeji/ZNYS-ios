//
//  User.m
//  ZNYS
//
//  Created by 张恒铭 on 12/19/15.
//  Copyright © 2015 Woodseen. All rights reserved.
//

#import "User.h"
#import "Award.h"
#import "Belongings.h"
#import "CustomerServices.h"
#import "ToothBrush.h"
#import "CoreDataHelper.h"
@implementation User

// Insert code here to add functionality to your managed object subclass
+(User*)currentUser
{
    NSString* uuid =   [[NSUserDefaults standardUserDefaults] objectForKey:@"currentUserUID"];
    if(uuid)
    {
        User* user =   [[CoreDataHelper sharedInstance] retrieveUsers:[NSPredicate predicateWithFormat:@"uuid = %@",uuid]][0];
        return user;
    }
    else return nil;
}
@end
