//
//  PFModelPlace.m
//  Place Note Book
//
//  Created by Ngo Dac Du on 3/9/15.
//  Copyright (c) 2015 ngodacdu. All rights reserved.
//

#import "PFModelPlace.h"
#import "PFUserManager.h"

#define PLACE_USER  @"parent"
#define PLACE_IDENTIFIER @"identifier"
#define PLACE_LIKE  @"like"
#define PLACE_NAME @"name"
#define PLACE_LOCATION @"location"
#define PLACE_ADDRESS @"address"
#define PLACE_FORMAT_ADDRESS @"formart_address"
#define PLACE_FORMAT_PHONE  @"format_phone"
#define PLACE_ICON_URL  @"icon_url"
#define PLACE_RATE @"rating"
#define PLACE_REFERENCE @"reference"
#define PLACE_TYPES @"types"
#define PLACE_URL @"url"
#define PLACE_WEB_URL @"website_url"
#define PLACE_IMAGES @"images"

@implementation PFModelPlace

- (instancetype)initWithData:(NSDictionary *)placeDictionary {
    if (self = [super init]) {
        self.parent = [[PFUserManager sharePFUserManager] currentUser];
        self.identifier = [placeDictionary objectForKey:PLACE_IDENTIFIER];
        self.like = [[placeDictionary objectForKey:PLACE_LIKE] intValue];
        self.name = [placeDictionary objectForKey:PLACE_NAME];
        CLLocation *location = [placeDictionary objectForKey:PLACE_LOCATION];
        self.location = [PFGeoPoint geoPointWithLocation:location];
        self.address = [placeDictionary objectForKey:PLACE_ADDRESS];
        self.formatAddress = [placeDictionary objectForKey:PLACE_FORMAT_ADDRESS];
        self.formatPhone = [placeDictionary objectForKey:PLACE_FORMAT_PHONE];
        self.iconURL = [placeDictionary objectForKey:PLACE_ICON_URL];
        self.rating = [[placeDictionary objectForKey:PLACE_RATE] floatValue];
        self.reference = [placeDictionary objectForKey:PLACE_REFERENCE];
        self.types = [placeDictionary objectForKey:PLACE_TYPES];
        self.url = [placeDictionary objectForKey:PLACE_URL];;
        self.websiteURL = [placeDictionary objectForKey:PLACE_WEB_URL];
        self.images = [placeDictionary objectForKey:PLACE_IMAGES];
    }
    
    return self;
}

@end
