//
//  Account.h
//  Place Note Book
//
//  Created by framgiavn on 2/26/15.
//  Copyright (c) 2015 framgiavn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class About, Assess, Know, Like, Path, Schedule, Share, Synchronous;

@interface Account : NSManagedObject

@property (nonatomic, retain) NSString * account_name;
@property (nonatomic, retain) NSString * account_note;
@property (nonatomic, retain) NSString * account_password;
@property (nonatomic, retain) NSString * account_phone;
@property (nonatomic, retain) NSString * account_position;
@property (nonatomic, retain) NSString * account_status;
@property (nonatomic, retain) NSString * account_user_name;
@property (nonatomic, retain) NSString * account_email;
@property (nonatomic, retain) NSSet *abouts;
@property (nonatomic, retain) NSSet *assesses;
@property (nonatomic, retain) NSSet *knows;
@property (nonatomic, retain) NSSet *likes;
@property (nonatomic, retain) NSSet *paths;
@property (nonatomic, retain) NSSet *schedules;
@property (nonatomic, retain) NSSet *shares;
@property (nonatomic, retain) NSSet *synchronous;
@end

@interface Account (CoreDataGeneratedAccessors)

- (void)addAboutsObject:(About *)value;
- (void)removeAboutsObject:(About *)value;
- (void)addAbouts:(NSSet *)values;
- (void)removeAbouts:(NSSet *)values;

- (void)addAssessesObject:(Assess *)value;
- (void)removeAssessesObject:(Assess *)value;
- (void)addAssesses:(NSSet *)values;
- (void)removeAssesses:(NSSet *)values;

- (void)addKnowsObject:(Know *)value;
- (void)removeKnowsObject:(Know *)value;
- (void)addKnows:(NSSet *)values;
- (void)removeKnows:(NSSet *)values;

- (void)addLikesObject:(Like *)value;
- (void)removeLikesObject:(Like *)value;
- (void)addLikes:(NSSet *)values;
- (void)removeLikes:(NSSet *)values;

- (void)addPathsObject:(Path *)value;
- (void)removePathsObject:(Path *)value;
- (void)addPaths:(NSSet *)values;
- (void)removePaths:(NSSet *)values;

- (void)addSchedulesObject:(Schedule *)value;
- (void)removeSchedulesObject:(Schedule *)value;
- (void)addSchedules:(NSSet *)values;
- (void)removeSchedules:(NSSet *)values;

- (void)addSharesObject:(Share *)value;
- (void)removeSharesObject:(Share *)value;
- (void)addShares:(NSSet *)values;
- (void)removeShares:(NSSet *)values;

- (void)addSynchronousObject:(Synchronous *)value;
- (void)removeSynchronousObject:(Synchronous *)value;
- (void)addSynchronous:(NSSet *)values;
- (void)removeSynchronous:(NSSet *)values;

@end
