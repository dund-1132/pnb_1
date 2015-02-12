//
//  About.h
//  Place Note Book
//
//  Created by framgiavn on 2/12/15.
//  Copyright (c) 2015 framgiavn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Account;

@interface About : NSManagedObject

@property (nonatomic, retain) NSString * about_language;
@property (nonatomic, retain) NSString * about_status;
@property (nonatomic, retain) Account *account;

@end
