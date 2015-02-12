//
//  RequetsFormat.m
//  Place Note Book
//
//  Created by framgiavn on 2/12/15.
//  Copyright (c) 2015 framgiavn. All rights reserved.
//

#import "RequetsFormat.h"

@implementation RequetsFormat

static RequetsFormat *staticRequestFormat;

+ (RequetsFormat *)shareRequestFormat {
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        staticRequestFormat = [[RequetsFormat alloc] init];
    });
    
    return staticRequestFormat;
}

- (instancetype)init {
    if (self = [super init]) {
        
    }
    
    return self;
}

@end
