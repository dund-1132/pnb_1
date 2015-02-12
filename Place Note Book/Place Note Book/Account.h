//
//  Account.h
//  Place Note Book
//
//  Created by framgiavn on 2/12/15.
//  Copyright (c) 2015 framgiavn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class About, Schedule, Synchronous;

@interface Account : NSManagedObject

@property (nonatomic, retain) NSString * account_name;
@property (nonatomic, retain) NSString * account_position;
@property (nonatomic, retain) NSString * account_phone;
@property (nonatomic, retain) NSString * account_user_name;
@property (nonatomic, retain) NSString * account_password;
@property (nonatomic, retain) NSString * account_note;
@property (nonatomic, retain) NSString * account_status;
@property (nonatomic, retain) NSSet *paths;
@property (nonatomic, retain) NSSet *abouts;
@property (nonatomic, retain) NSSet *assesses;
@property (nonatomic, retain) NSSet *knows;
@property (nonatomic, retain) NSSet *likes;
@property (nonatomic, retain) NSSet *schedules;
@property (nonatomic, retain) NSSet *shares;
@property (nonatomic, retain) NSSet *synchronous;
@end

@interface Account (CoreDataGeneratedAccessors)

- (void)addPathsObject:(NSManagedObject *)value;
- (void)removePathsObject:(NSManagedObject *)value;
- (void)addPaths:(NSSet *)values;
- (void)removePaths:(NSSet *)values;

- (void)addAboutsObject:(NSManagedObject *)value;
- (void)removeAboutsObject:(NSManagedObject *)value;
- (void)addAbouts:(NSSet *)values;
- (void)removeAbouts:(NSSet *)values;

- (void)addAssessesObject:(NSManagedObject *)value;
- (void)removeAssessesObject:(NSManagedObject *)value;
- (void)addAssesses:(NSSet *)values;
- (void)removeAssesses:(NSSet *)values;

- (void)addKnowsObject:(NSManagedObject *)value;
- (void)removeKnowsObject:(NSManagedObject *)value;
- (void)addKnows:(NSSet *)values;
- (void)removeKnows:(NSSet *)values;

- (void)addLikesObject:(NSManagedObject *)value;
- (void)removeLikesObject:(NSManagedObject *)value;
- (void)addLikes:(NSSet *)values;
- (void)removeLikes:(NSSet *)values;

- (void)addSchedulesObject:(NSManagedObject *)value;
- (void)removeSchedulesObject:(NSManagedObject *)value;
- (void)addSchedules:(NSSet *)values;
- (void)removeSchedules:(NSSet *)values;

- (void)addSharesObject:(NSManagedObject *)value;
- (void)removeSharesObject:(NSManagedObject *)value;
- (void)addShares:(NSSet *)values;
- (void)removeShares:(NSSet *)values;

- (void)addSynchronousObject:(NSManagedObject *)value;
- (void)removeSynchronousObject:(NSManagedObject *)value;
- (void)addSynchronous:(NSSet *)values;
- (void)removeSynchronous:(NSSet *)values;

@end
