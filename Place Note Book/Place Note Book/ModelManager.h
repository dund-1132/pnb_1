//
//  ModelManager.h
//  Place Note Book
//
//  Created by framgiavn on 2/12/15.
//  Copyright (c) 2015 framgiavn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "Like.h"
#import "Know.h"
#import "Assess.h"
#import "Path.h"
#import "Share.h"
#import "Account.h"
#import "About.h"
#import "Synchronous.h"
#import "Schedule.h"
#import "Place.h"

typedef enum : NSUInteger {
    TablePlace,
    TableAccount,
    TableLike,
    TableKnow,
    TableAssess,
    TablePath,
    TableShare,
    TableAbout,
    TableSynchronous,
    TableSchedule
} DatabaseTableName;

@interface ModelManager : NSObject

+ (ModelManager *)shareModelManager;

- (void)insertPlace:(NSDictionary *)placeInfo;

- (void)insertAccount:(NSDictionary *)accountInfo;

- (void)insertLike:(NSDictionary *)likeInfo;

- (void)insertKnow:(NSDictionary *)knowInfo;

- (void)insertAssess:(NSDictionary *)assessInfo;

- (void)insertPath:(NSDictionary *)pathInfo;

- (void)insertShare:(NSDictionary *)shareInfo;

- (void)insertAbout:(NSDictionary *)aboutInfo;

- (void)insertSynchronous:(NSDictionary *)synchronousInfo;

- (void)insertSchedule:(NSDictionary *)scheduleInfo;

- (BOOL)isExistRecordIn:(DatabaseTableName)tableName andPredicateFormat:(NSString *)format;

@end
