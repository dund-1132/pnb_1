//
//  PFNetWork.h
//  Place Note Book
//
//  Created by framgiavn on 3/16/15.
//  Copyright (c) 2015 ngodacdu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PFNetWork : NSObject

+ (PFNetWork *)sharePFNetwork;

- (BOOL)connectedToInternet;

@end
