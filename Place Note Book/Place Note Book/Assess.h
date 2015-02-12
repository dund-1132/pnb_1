//
//  Assess.h
//  Place Note Book
//
//  Created by framgiavn on 2/12/15.
//  Copyright (c) 2015 framgiavn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Account, Place;

@interface Assess : NSManagedObject

@property (nonatomic, retain) NSNumber * assess_point;
@property (nonatomic, retain) NSString * assess_status;
@property (nonatomic, retain) Place *place;
@property (nonatomic, retain) Account *account;

@end
