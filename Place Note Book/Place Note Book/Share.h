//
//  Share.h
//  Place Note Book
//
//  Created by framgiavn on 2/12/15.
//  Copyright (c) 2015 framgiavn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Account, Place;

@interface Share : NSManagedObject

@property (nonatomic, retain) NSString * share_content;
@property (nonatomic, retain) NSString * share_status;
@property (nonatomic, retain) Place *place;
@property (nonatomic, retain) Account *account;

@end
