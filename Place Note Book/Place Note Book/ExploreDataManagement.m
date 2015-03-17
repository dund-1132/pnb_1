//
//  ExploreDataManagement.m
//  Place Note Book
//
//  Created by Ngo Dac Du on 3/9/15.
//  Copyright (c) 2015 ngodacdu. All rights reserved.
//

#import "ExploreDataManagement.h"

static ExploreDataManagement *staticExploreDataManagement;

@interface ExploreDataManagement()

@property (nonatomic, strong) NSArray *timelineData;
@property (nonatomic, strong) NSArray *supportTypes;

@end

@implementation ExploreDataManagement

@synthesize timelineData, supportTypes;

+ (ExploreDataManagement *)shareExploreDataManagement {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        staticExploreDataManagement = [[ExploreDataManagement alloc] init];
    });
    
    return staticExploreDataManagement;
}

- (instancetype)init {
    if (self = [super init]) {
        timelineData = @[@"timeline1.png",
                         @"timeline2.png",
                         @"timeline3.png",
                         @"timeline4.png",
                         @"timeline5.png"];
        supportTypes = @[@"ATM",
                         @"Bank",
                         @"School",
                         @"University",
                         @"Bar",
                         @"Book store",
                         @"Bus station",
                         @"Cafe",
                         @"Clothing store",
                         @"Finance",
                         @"Food",
                         @"Gas station",
                         @"Gym",
                         @"Hair care",
                         @"Hospital",
                         @"Insurance agency",
                         @"Library",
                         @"Movie theater",
                         @"Musium",
                         @"Park",
                         @"Parking",
                         @"Police",
                         @"Real estate",
                         @"Restaurant",
                         @"Stadium",
                         @"Store",
                         @"Subway station",
                         @"Train station",
                         @"Zoo",
                         @"Airport",
                         @"Accounting"
                         ];

    }
    
    return self;
}

- (NSArray *)timelineDatas {
    return self.timelineData;
}

- (NSArray *)typeList {
    return self.supportTypes;
}

@end
