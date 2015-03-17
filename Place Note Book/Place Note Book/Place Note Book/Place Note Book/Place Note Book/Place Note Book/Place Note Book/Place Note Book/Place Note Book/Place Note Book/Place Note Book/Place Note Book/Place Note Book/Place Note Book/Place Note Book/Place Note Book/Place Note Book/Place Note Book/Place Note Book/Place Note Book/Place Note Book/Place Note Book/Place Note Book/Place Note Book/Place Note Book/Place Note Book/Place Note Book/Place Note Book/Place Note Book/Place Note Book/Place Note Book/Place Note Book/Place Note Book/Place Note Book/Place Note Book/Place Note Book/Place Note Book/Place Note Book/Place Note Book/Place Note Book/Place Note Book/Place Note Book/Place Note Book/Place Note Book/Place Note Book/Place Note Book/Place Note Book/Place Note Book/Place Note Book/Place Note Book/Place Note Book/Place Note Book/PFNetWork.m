//
//  PFNetWork.m
//  Place Note Book
//
//  Created by framgiavn on 3/16/15.
//  Copyright (c) 2015 ngodacdu. All rights reserved.
//

#import "PFNetWork.h"
#import "AFNetworking.h"

static PFNetWork *staticPFNetwork;

@implementation PFNetWork

+ (PFNetWork *)sharePFNetwork {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        staticPFNetwork = [[PFNetWork alloc] init];
    });
    
    return staticPFNetwork;
}

- (instancetype)init {
    if (self = [super init]) {
        
    }
    
    return self;
}

- (BOOL)connectedToInternet {
    if ([[AFNetworkReachabilityManager sharedManager] isReachable]) {
        return YES;
    } else {
        return NO;
    }
}

@end
