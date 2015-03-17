//
//  PFModelUser.m
//  Place Note Book
//
//  Created by framgiavn on 3/2/15.
//  Copyright (c) 2015 framgiavn. All rights reserved.
//

#import "PFUserManager.h"

#define INFO_USER_NAME  @"username"
#define INFO_USER_EMAIL @"email"
#define INFO_USER_PASS @"password"
#define INFO_USER_FRIEND    @"friends"
#define INFO_NAME @"name"
#define INFO_POSITION @"position"
#define INFO_PHONE @"phone"
#define INFO_NOTE @"note"
#define INFO_STATUS @"status"

static PFUserManager *staticPFModelUser;

@interface PFUserManager()

@property (nonatomic, strong) PFGeoPoint *currentLocation;

@end

@implementation PFUserManager

@synthesize delegate;

+ (PFUserManager *)sharePFUserManager {
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        staticPFModelUser = [[PFUserManager alloc] init];
    });
    
    return staticPFModelUser;
}

- (instancetype)init {
    if (self = [super init]) {
        
    }
    
    return self;
}

- (void)isExistAccount:(NSString *)userName
              password:(NSString *)password {
    [PFUser logInWithUsernameInBackground:userName
                                 password:password
                                    block:^(PFUser *user, NSError *error) {
                                        SEL selector = @selector(PFUserManager:didCheckExist:);
                                        if (delegate && [delegate respondsToSelector:selector]) {
                                            if (user && !error) {
                                                [delegate PFUserManager:self didCheckExist:YES];
                                            } else {
                                                [delegate PFUserManager:self didCheckExist:NO];
                                            }
                                        }
                                    }];
}

- (void)signUp:(PFModelUser *)account {
    if (!account) {
        return;
    }
    PFUser *user = [PFUser user];
    user.username = account.userName;
    user.password = account.password;
    user.email = account.email;
    user[INFO_USER_FRIEND] = [NSArray arrayWithArray:account.friendList];
    user[INFO_NAME] = account.name;
    user[INFO_POSITION] = account.position;
    user[INFO_PHONE] = account.phone;
    user[INFO_NOTE] = account.note;
    user[INFO_STATUS] = account.status;
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        SEL selector = @selector(PFUserManager:didSignUp:);
        if (delegate && [delegate respondsToSelector:selector]) {
            if (!error && succeeded) {
                [delegate PFUserManager:self didSignUp:YES];
                [user pinInBackground];
            } else {
                [delegate PFUserManager:self didSignUp:NO];
            }
        }
    }];
}

- (void)loginWith:(NSString *)userName password:(NSString *)password {
    if (!userName || !password) {
        return;
    }
    [PFUser logInWithUsernameInBackground:userName
                                 password:password
                                    block:^(PFUser *user, NSError *error) {
                                        SEL selector = @selector(PFUserManager:didLogin:);
                                        if (delegate && [delegate respondsToSelector:selector]) {
                                            if (user && !error) {
                                                BOOL isLogin = [self loginWithNetwork:user];
                                                [delegate PFUserManager:self didLogin:isLogin];
                                            } else {
                                                BOOL isLogin = [self loginWithLocal:userName
                                                                        andPassword:password];
                                                [delegate PFUserManager:self didLogin:isLogin];
                                            }
                                        }
    }];
}

- (BOOL)loginWithNetwork:(PFUser *)user {
    [user pinInBackground];
    return YES;
}

- (BOOL)loginWithLocal:(NSString *)userName andPassword:(NSString *)password {
    PFQuery *query = [PFQuery queryWithClassName:[PFUser parseClassName]];
    [query fromLocalDatastore];
    [query whereKey:@"username" equalTo:userName];
    [query whereKey:@"password" equalTo:password];
    [query setLimit:1];
    __block BOOL isLogin = NO;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error && ([objects count] > 0)) {
            isLogin = YES;
        }
    }];
    
    return isLogin;
}

- (PFUser *)currentUser {
    return [PFUser currentUser];
}

- (void)logout {
    [PFUser logOut];
}

- (void)loginAnonymousUsers {
    
}

- (void)userCurrentLocation {
    [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error) {
        if (delegate && [delegate respondsToSelector:@selector(PFModelUserDidUserLocation:location:)]) {
            if (!error) {
                self.currentLocation = geoPoint;
                [delegate PFModelUserDidUserLocation:YES location:geoPoint];
            } else {
                [delegate PFModelUserDidUserLocation:NO location:nil];
            }
        }
    }];
}

- (PFGeoPoint *)location {
    return self.currentLocation;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
