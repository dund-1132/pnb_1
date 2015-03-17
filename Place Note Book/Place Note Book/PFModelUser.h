//
//  PFModelUser.h
//  Place Note Book
//
//  Created by Ngo Dac Du on 3/8/15.
//  Copyright (c) 2015 ngodacdu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PFModelUser : NSObject

+ (PFModelUser *)sharePFModelUser;

@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSMutableArray *friendList;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) NSString *position;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *note;
@property (nonatomic, strong) NSString *status;

@end
