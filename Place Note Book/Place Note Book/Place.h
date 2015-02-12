//
//  Place.h
//  Place Note Book
//
//  Created by framgiavn on 2/12/15.
//  Copyright (c) 2015 framgiavn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Place : NSManagedObject

@property (nonatomic, retain) NSString * place_id;
@property (nonatomic, retain) NSString * place_name;
@property (nonatomic, retain) NSString * place_address;
@property (nonatomic, retain) NSString * place_phone_local;
@property (nonatomic, retain) NSString * place_phone_international;
@property (nonatomic, retain) NSString * place_location_lat;
@property (nonatomic, retain) NSString * place_location_lng;
@property (nonatomic, retain) NSString * place_icon_path;
@property (nonatomic, retain) NSString * place_type;
@property (nonatomic, retain) NSString * place_website;
@property (nonatomic, retain) NSString * place_map_url;
@property (nonatomic, retain) NSString * place_rate;
@property (nonatomic, retain) NSString * place_status;
@property (nonatomic, retain) NSSet *paths;
@property (nonatomic, retain) NSSet *schedules;
@property (nonatomic, retain) NSSet *assesses;
@property (nonatomic, retain) NSSet *knows;
@property (nonatomic, retain) NSSet *likes;
@property (nonatomic, retain) NSSet *shares;
@end

@interface Place (CoreDataGeneratedAccessors)

- (void)addPathsObject:(NSManagedObject *)value;
- (void)removePathsObject:(NSManagedObject *)value;
- (void)addPaths:(NSSet *)values;
- (void)removePaths:(NSSet *)values;

- (void)addSchedulesObject:(NSManagedObject *)value;
- (void)removeSchedulesObject:(NSManagedObject *)value;
- (void)addSchedules:(NSSet *)values;
- (void)removeSchedules:(NSSet *)values;

- (void)addAssessesObject:(NSManagedObject *)value;
- (void)removeAssessesObject:(NSManagedObject *)value;
- (void)addAssesses:(NSSet *)values;
- (void)removeAssesses:(NSSet *)values;

- (void)addKnowsObject:(NSManagedObject *)value;
- (void)removeKnowsObject:(NSManagedObject *)value;
- (void)addKnows:(NSSet *)values;
- (void)removeKnows:(NSSet *)values;

- (void)addLikesObject:(NSManagedObject *)value;
- (void)removeLikesObject:(NSManagedObject *)value;
- (void)addLikes:(NSSet *)values;
- (void)removeLikes:(NSSet *)values;

- (void)addSharesObject:(NSManagedObject *)value;
- (void)removeSharesObject:(NSManagedObject *)value;
- (void)addShares:(NSSet *)values;
- (void)removeShares:(NSSet *)values;

@end
