//
//  RequetsFormat.m
//  Place Note Book
//
//  Created by framgiavn on 2/12/15.
//  Copyright (c) 2015 framgiavn. All rights reserved.
//

#import "RequetsFormat.h"

#define PROTOCOL    @"http://"
#define SERVER_IP   @"192.168.2.105/"

#define METHOD_GET  @"GET"
#define METHOD_POST @"POST"

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

- (NSString *)url {
    return [NSString stringWithFormat:@"%@%@", PROTOCOL, SERVER_IP];
    
}

- (NSString *)getMethod {
    return METHOD_GET;
}

- (NSString *)postMethod {
    return METHOD_POST;
}

- (NSString *)requestFormatLogin:(NSString *)userName password:(NSString *)password {
    return [NSString stringWithFormat:@"%@%@?username=%@&password=%@", PROTOCOL, SERVER_IP, userName, password];
}

@end
