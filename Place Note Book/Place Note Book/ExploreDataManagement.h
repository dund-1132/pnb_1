//
//  ExploreDataManagement.h
//  Place Note Book
//
//  Created by Ngo Dac Du on 3/9/15.
//  Copyright (c) 2015 ngodacdu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExploreDataManagement : NSObject

+ (ExploreDataManagement *)shareExploreDataManagement;

- (NSArray *)timelineDatas;

- (NSArray *)typeList;

@end
