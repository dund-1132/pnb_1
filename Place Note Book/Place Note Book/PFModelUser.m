//
//  PFModelUser.m
//  Place Note Book
//
//  Created by Ngo Dac Du on 3/8/15.
//  Copyright (c) 2015 ngodacdu. All rights reserved.
//

#import "PFModelUser.h"

static PFModelUser *staticPFModelUser;

@implementation PFModelUser

+ (PFModelUser *)sharePFModelUser {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        staticPFModelUser = [[PFModelUser alloc] init];
    });
    
    return staticPFModelUser;
}

- (instancetype)init {
    if (self = [super init]) {
        self.friendList = [[NSMutableArray alloc] init];
    }
    
    return self;
}

@end
