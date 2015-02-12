//
//  JSONDownload.h
//  Place Note Book
//
//  Created by framgiavn on 2/11/15.
//  Copyright (c) 2015 framgiavn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONDownload : NSObject

+ (JSONDownload *)shareJSONDownload;

- (void)sendRequestWithURL:(NSString *)urlString;

- (void)sendRequestWithURL:(NSString *)urlString methodRequest:(NSString *)method bodyString:(NSString *)body;

@end
