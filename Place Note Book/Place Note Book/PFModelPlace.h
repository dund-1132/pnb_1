//
//  PFModelPlace.h
//  Place Note Book
//
//  Created by Ngo Dac Du on 3/9/15.
//  Copyright (c) 2015 ngodacdu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface PFModelPlace : NSObject

@property (nonatomic, strong) PFUser *parent;
@property (nonatomic, strong) NSString *identifier;
@property (nonatomic) int like;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) PFGeoPoint *location;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *formatAddress;
@property (nonatomic, strong) NSString *formatPhone;
@property (nonatomic, strong) NSString *iconURL;
@property (nonatomic) float rating;
@property (nonatomic, strong) NSString *reference;
@property (nonatomic, strong) NSMutableArray *types;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *websiteURL;
@property (nonatomic, strong) NSMutableArray *images;

- (instancetype)initWithData:(NSDictionary *)placeDictionary;

@end
