//
//  ModelManager.m
//  Place Note Book
//
//  Created by framgiavn on 2/12/15.
//  Copyright (c) 2015 framgiavn. All rights reserved.
//

#import "ModelManager.h"

#define TABLE_PLACE @"Place"
#define TABLE_ACCOUNT @"Account"
#define TABLE_LIKE @"Like"
#define TABLE_KNOW @"Know"
#define TABLE_ASSESS @"Assess"
#define TABLE_PATH @"Path"
#define TABLE_SHARE @"Share"
#define TABLE_ABOUT @"About"
#define TABLE_SYNCHRONOUS @"Synchronous"
#define TABLE_SCHEDULE @"Schedule"

@implementation ModelManager

static ModelManager *staticModelManager;

+ (ModelManager *)shareModelManager {
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        staticModelManager = [[ModelManager alloc] init];
    });
    
    return staticModelManager;
}

- (instancetype)init {
    if (self = [super init]) {
        
    }
    
    return self;
}

- (NSManagedObjectContext *)managedObjectContext {
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    return appDelegate.managedObjectContext;
}

- (void)insertPlace:(NSDictionary *)placeInfo {
    Place *place = [NSEntityDescription insertNewObjectForEntityForName:@"Place"
                                                 inManagedObjectContext:[self managedObjectContext]];
    if (place != nil) {
        place.place_id = [placeInfo objectForKey:@"place_id"];
        place.place_name = [placeInfo objectForKey:@"place_name"];
        place.place_address = [placeInfo objectForKey:@"place_address"];
        place.place_phone_local = [placeInfo objectForKey:@"place_phone_local"];
        place.place_phone_international = [placeInfo objectForKey:@"place_phone_international"];
        place.place_location_lat = [placeInfo objectForKey:@"place_location_lat"];
        place.place_location_lng = [placeInfo objectForKey:@"place_location_lng"];
        place.place_icon_path = [placeInfo objectForKey:@"place_icon_path"];
        place.place_type = [placeInfo objectForKey:@"place_type"];
        place.place_website = [placeInfo objectForKey:@"place_website"];
        place.place_map_url = [placeInfo objectForKey:@"place_map_url"];
        place.place_rate = [placeInfo objectForKey:@"place_rate"];
        place.place_status = [placeInfo objectForKey:@"place_status"];
        
        NSError *savingError = nil;
        if ([[self managedObjectContext] save:&savingError]) {
            // Successfully saved the context
        } else {
            // Failed to save the context
        }
    } else {
        // Failed to create the new object
    }
}

- (void)insertAccount:(NSDictionary *)accountInfo {
    Account *account =
    [NSEntityDescription insertNewObjectForEntityForName:@"Account"
                                  inManagedObjectContext:[self managedObjectContext]];
    if (account != nil) {
        account.account_name = [accountInfo objectForKey:@"account_name"];
        account.account_position = [accountInfo objectForKey:@"account_position"];
        account.account_phone = [accountInfo objectForKey:@"account_phone"];
        account.account_user_name = [accountInfo objectForKey:@"account_user_name"];
        account.account_email = [accountInfo objectForKey:@"account_email"];
        account.account_password = [accountInfo objectForKey:@"account_password"];
        account.account_note = [accountInfo objectForKey:@"account_note"];
        account.account_status = [accountInfo objectForKey:@"account_status"];
        
        NSError *savingError = nil;
        if ([[self managedObjectContext] save:&savingError]) {
            NSLog(@"Successfully saved the context Account");
        } else {
            NSLog(@"Failed to save the context Account");
        }
    } else {
        // Failed to create the new object
    }
}

- (Account *)accountWithId:(NSString *)accountId {
    NSError *error = nil;
    NSFetchRequest *checkExist = [[NSFetchRequest alloc] init];
    [checkExist setEntity:[NSEntityDescription entityForName:@"Account"
                                      inManagedObjectContext:[self managedObjectContext]]];
    [checkExist setFetchLimit:1];
    [checkExist setPredicate:[NSPredicate predicateWithFormat:@"id == '%@'", accountId]];
    NSArray *result = [[self managedObjectContext] executeFetchRequest:checkExist error:&error];
    if ([result count] > 0) {
        return (Account *)[result lastObject];
    }
    
    return nil;
}

- (Account *)account:(NSString *)format {
    NSError *error = nil;
    NSFetchRequest *checkExist = [[NSFetchRequest alloc] init];
    [checkExist setEntity:[NSEntityDescription entityForName:@"Account"
                                      inManagedObjectContext:[self managedObjectContext]]];
    [checkExist setFetchLimit:1];
    [checkExist setPredicate:[NSPredicate predicateWithFormat:format]];
    NSArray *result = [[self managedObjectContext] executeFetchRequest:checkExist error:&error];
    if ([result count] > 0) {
        return (Account *)[result lastObject];
    }
    
    return nil;
}

- (void)insertLike:(NSDictionary *)likeInfo {
    Like *like =
    [NSEntityDescription insertNewObjectForEntityForName:@"Like"
                                  inManagedObjectContext:[self managedObjectContext]];
    if (like != nil) {
        like.like_count = [likeInfo objectForKey:@"like_count"];
        [like.place addLikesObject:like];
        [like.account addLikesObject:like];
        
        NSError *savingError = nil;
        if ([[self managedObjectContext] save:&savingError]) {
            // Successfully saved the context
        } else {
            // Failed to save the context
        }
    } else {
        // Failed to create the new object
    }
}

- (void)insertKnow:(NSDictionary *)knowInfo {
    Know *know =
    [NSEntityDescription insertNewObjectForEntityForName:@"Know"
                                  inManagedObjectContext:[self managedObjectContext]];
    if (know != nil) {
        know.know_status = [knowInfo objectForKey:@"know_status"];
        [know.place addKnowsObject:know];
        [know.account addKnowsObject:know];
        
        NSError *savingError = nil;
        if ([[self managedObjectContext] save:&savingError]) {
            // Successfully saved the context
        } else {
            // Failed to save the context
        }
    } else {
        // Failed to create the new object
    }
}

- (void)insertAssess:(NSDictionary *)assessInfo {
    Assess *assess =
    [NSEntityDescription insertNewObjectForEntityForName:@"Assess"
                                  inManagedObjectContext:[self managedObjectContext]];
    if (assess != nil) {
        assess.assess_point = [assessInfo objectForKey:@"assess_point"];
        assess.assess_status = [assessInfo objectForKey:@"assess_status"];
        [assess.place addAssessesObject:assess];
        [assess.account addAssessesObject:assess];
        
        NSError *savingError = nil;
        if ([[self managedObjectContext] save:&savingError]) {
            // Successfully saved the context
        } else {
            // Failed to save the context
        }
    } else {
        // Failed to create the new object
    }
}

- (void)insertPath:(NSDictionary *)pathInfo {
    Path *path =
    [NSEntityDescription insertNewObjectForEntityForName:@"Path"
                                  inManagedObjectContext:[self managedObjectContext]];
    if (path != nil) {
        path.path_list = [pathInfo objectForKey:@"path_list"];
        path.path_note = [pathInfo objectForKey:@"path_note"];
        path.path_status = [pathInfo objectForKey:@"path_status"];
        [path.place addPathsObject:path];
        [path.account addPathsObject:path];
        
        NSError *savingError = nil;
        if ([[self managedObjectContext] save:&savingError]) {
            // Successfully saved the context
        } else {
            // Failed to save the context
        }
    } else {
        // Failed to create the new object
    }
}

- (void)insertShare:(NSDictionary *)shareInfo {
    Share *share =
    [NSEntityDescription insertNewObjectForEntityForName:@"Share"
                                  inManagedObjectContext:[self managedObjectContext]];
    if (share != nil) {
        share.share_content = [shareInfo objectForKey:@"share_content"];
        share.share_status = [shareInfo objectForKey:@"share_status"];
        [share.place addSharesObject:share];
        [share.account addSharesObject:share];
        
        NSError *savingError = nil;
        if ([[self managedObjectContext] save:&savingError]) {
            // Successfully saved the context
        } else {
            // Failed to save the context
        }
    } else {
        // Failed to create the new object
    }
}

- (void)insertAbout:(NSDictionary *)aboutInfo {
    About *about =
    [NSEntityDescription insertNewObjectForEntityForName:@"About"
                                  inManagedObjectContext:[self managedObjectContext]];
    if (about != nil) {
        about.about_language = [aboutInfo objectForKey:@"about_language"];
        about.about_status = [aboutInfo objectForKey:@"about_status"];
        [about.account addAboutsObject:about];
        
        NSError *savingError = nil;
        if ([[self managedObjectContext] save:&savingError]) {
            // Successfully saved the context
        } else {
            // Failed to save the context
        }
    } else {
        // Failed to create the new object
    }
}

- (void)insertSynchronous:(NSDictionary *)synchronousInfo {
    Synchronous *synchronous =
    [NSEntityDescription insertNewObjectForEntityForName:@"Synchronous"
                                  inManagedObjectContext:[self managedObjectContext]];
    if (synchronous != nil) {
        synchronous.synchronous_time = [synchronousInfo objectForKey:@"synchronous_time"];
        synchronous.synchronous_table = [synchronousInfo objectForKey:@"synchronous_table"];
        synchronous.synchronous_content = [synchronousInfo objectForKey:@"synchronous_table"];
        synchronous.synchronous_status = [synchronousInfo objectForKey:@"synchronous_status"];
        [synchronous.account addSynchronousObject:synchronous];
        
        NSError *savingError = nil;
        if ([[self managedObjectContext] save:&savingError]) {
            // Successfully saved the context
        } else {
            // Failed to save the context
        }
    } else {
        // Failed to create the new object
    }
}

- (void)insertSchedule:(NSDictionary *)scheduleInfo {
    Schedule *schedule =
    [NSEntityDescription insertNewObjectForEntityForName:@"Schedule"
                                  inManagedObjectContext:[self managedObjectContext]];
    if (schedule != nil) {
        schedule.schedule_time = [scheduleInfo objectForKey:@""];
        schedule.schedule_content = [scheduleInfo objectForKey:@""];
        schedule.schedule_status = [scheduleInfo objectForKey:@""];
        [schedule.place addSchedulesObject:schedule];
        [schedule.account addSchedulesObject:schedule];
        
        NSError *savingError = nil;
        if ([[self managedObjectContext] save:&savingError]) {
            // Successfully saved the context
        } else {
            // Failed to save the context
        }
    } else {
        // Failed to create the new object
    }
}

- (BOOL)isExistRecordIn:(DatabaseTableName)tableName andPredicateFormat:(NSString *)format {
    NSString *table = nil;
    switch (tableName) {
        case TablePlace:
            table = TABLE_PLACE;
            break;
        case TableAccount:
            table = TABLE_ACCOUNT;
            break;
        case TableLike:
            table = TABLE_LIKE;
            break;
        case TableKnow:
            table = TABLE_KNOW;
            break;
        case TableAssess:
            table = TABLE_ASSESS;
            break;
        case TablePath:
            table = TABLE_PATH;
            break;
        case TableShare:
            table = TABLE_SHARE;
            break;
        case TableAbout:
            table = TABLE_ABOUT;
            break;
        case TableSynchronous:
            table = TABLE_SYNCHRONOUS;
            break;
        case TableSchedule:
            table = TABLE_SCHEDULE;
            break;
        default:
            break;
    }

    NSError *error = nil;
    NSFetchRequest *checkExist = [[NSFetchRequest alloc] init];
    [checkExist setEntity:[NSEntityDescription entityForName:table
                                      inManagedObjectContext:[self managedObjectContext]]];
    [checkExist setFetchLimit:1];
    [checkExist setPredicate:[NSPredicate predicateWithFormat:format]];
    NSArray *result = [[self managedObjectContext] executeFetchRequest:checkExist error:&error];
    if ([result lastObject]) {
        
        return TRUE;
    }
    
    return FALSE;
}

@end
