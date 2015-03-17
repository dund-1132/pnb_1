//
//  PFModelUser.h
//  Place Note Book
//
//  Created by framgiavn on 3/2/15.
//  Copyright (c) 2015 framgiavn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "PFModelUser.h"

@class PFUserManager;

@protocol PFUserManagerDelegate <NSObject>

@optional
- (void)PFUserManager:(PFUserManager *)userManager didCheckExist:(BOOL)successed;
- (void)PFUserManager:(PFUserManager *)userManager didSignUp:(BOOL)successed;
- (void)PFUserManager:(PFUserManager *)userManager didLogin:(BOOL)successed;
- (void)PFModelUserDidUserLocation:(BOOL)succeeded location:(PFGeoPoint *)geoPoint;

@end

@interface PFUserManager : NSObject

+ (PFUserManager *)sharePFUserManager;

@property (nonatomic, weak) id<PFUserManagerDelegate>delegate;

- (void)isExistAccount:(NSString *)userName
              password:(NSString *)password;
- (void)signUp:(PFModelUser *)account;

- (void)loginWith:(NSString *)userName
         password:(NSString *)password;

- (PFUser *)currentUser;

- (void)logout;

- (void)loginAnonymousUsers;

- (void)userCurrentLocation;

- (PFGeoPoint *)location;

@end
