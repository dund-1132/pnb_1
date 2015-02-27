//
//  UserData.h
//  Place Note Book
//
//  Created by framgiavn on 2/27/15.
//  Copyright (c) 2015 framgiavn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Account.h"

@interface UserData : NSObject

+ (UserData *)shareUserData;

- (void)saveAccount:(Account *)account;

- (Account *)accountFromUserData;

@end
