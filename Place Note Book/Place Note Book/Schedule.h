//
//  Schedule.h
//  Place Note Book
//
//  Created by framgiavn on 2/12/15.
//  Copyright (c) 2015 framgiavn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Place, Account;

@interface Schedule : NSManagedObject

@property (nonatomic, retain) NSDate * schedule_time;
@property (nonatomic, retain) NSString * schedule_content;
@property (nonatomic, retain) NSString * schedule_status;
@property (nonatomic, retain) Place *place;
@property (nonatomic, retain) Account *account;

@end
