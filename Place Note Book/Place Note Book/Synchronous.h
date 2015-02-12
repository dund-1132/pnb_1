//
//  Synchronous.h
//  Place Note Book
//
//  Created by framgiavn on 2/12/15.
//  Copyright (c) 2015 framgiavn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Account;

@interface Synchronous : NSManagedObject

@property (nonatomic, retain) NSDate * synchronous_time;
@property (nonatomic, retain) NSString * synchronous_table;
@property (nonatomic, retain) NSString * synchronous_content;
@property (nonatomic, retain) NSString * synchronous_status;
@property (nonatomic, retain) Account *account;

@end
