//
//  JSONDownload.m
//  Place Note Book
//
//  Created by framgiavn on 2/11/15.
//  Copyright (c) 2015 framgiavn. All rights reserved.
//

#import "JSONDownload.h"

#define REQUEST_TIMEOUT 10.0f

@interface JSONDownload() <NSURLConnectionDelegate> {
    NSMutableData *_responseData;
}

@end

@implementation JSONDownload

static JSONDownload *staticRequest;

+ (JSONDownload *)shareJSONDownload {
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        staticRequest = [[JSONDownload alloc] init];
    });
    
    return staticRequest;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

- (void)sendRequestWithURL:(NSString *)urlString {
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url
                                             cachePolicy:NSURLRequestUseProtocolCachePolicy
                                         timeoutInterval:REQUEST_TIMEOUT];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
    [connection scheduleInRunLoop:[NSRunLoop mainRunLoop]
                          forMode:NSDefaultRunLoopMode];
    if (connection) {
        [connection start];
        
    }
}

- (void)sendRequestWithURL:(NSString *)urlString
             methodRequest:(NSString *)method
                bodyString:(NSString *)body {
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:REQUEST_TIMEOUT];
    [request setHTTPMethod:method];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];
}

#pragma mark - handle NSURLConnectionDelegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    _responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSString *data = [[NSString alloc] initWithData:_responseData encoding:NSUTF8StringEncoding];
    NSLog(@"%@", data);
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // error
    NSLog(@"Error");
}

@end
