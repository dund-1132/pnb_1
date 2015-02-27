//
//  UserData.m
//  Place Note Book
//
//  Created by framgiavn on 2/27/15.
//  Copyright (c) 2015 framgiavn. All rights reserved.
//

#import "UserData.h"
#import "ModelManager.h"

static UserData *staticUserData;

@implementation UserData

+ (UserData *)shareUserData {
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        staticUserData = [[UserData alloc] init];
    });
    
    return staticUserData;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

- (void)saveAccount:(Account *)account {
    [[NSUserDefaults standardUserDefaults] setURL:[[account objectID] URIRepresentation]
                                           forKey:@"CurrentAccout"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (Account *)accountFromUserData {
    NSURL *uri = [[NSUserDefaults standardUserDefaults] URLForKey:@"CurrentAccout"];
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectID *objectId =
    [appDelegate.persistentStoreCoordinator managedObjectIDForURIRepresentation:uri];
    
    return (Account *)[appDelegate.managedObjectContext objectWithID:objectId];
}

@end
