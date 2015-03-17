//
//  PFModelPlace.h
//  Place Note Book
//
//  Created by Ngo Dac Du on 3/4/15.
//  Copyright (c) 2015 framgiavn. All rights reserved.
//

#import <Parse/Parse.h>
#import "FTGooglePlacesAPI.h"
#import "PFModelPlace.h"

@class PFPlaceManager;

@protocol  PFPlaceManagerDelegate<NSObject>

@optional
- (void)PFModelPlace:(PFPlaceManager *)modelPlace
     didPreparePlace:(BOOL)successed
          identifier:(NSString *)identifier;
- (void)PFModelPlace:(PFPlaceManager *)modelPlace didAddPlace:(BOOL)successed;
- (void)PFModelPlace:(PFPlaceManager *)modelPlace didEditPlace:(BOOL)successed;
- (void)PFModelPlace:(PFPlaceManager *)modelPlace didDeletePlace:(BOOL)successed;
- (void)PFModelPlace:(PFPlaceManager *)modelPlace didFilterPlace:(BOOL)successed;
- (void)PFModelPlace:(PFPlaceManager *)modelPlace didCreateRequest:(BOOL)successed;
- (void)PFModelPlace:(PFPlaceManager *)modelPlace didResponeRequest:(BOOL)successed;
- (void)PFModelPlace:(PFPlaceManager *)modelPlace didResponeDetail:(BOOL)successed;
- (void)PFModelPlace:(PFPlaceManager *)modelPlace
             isExist:(BOOL)successed
          identifier:(NSString *)identifier;
- (void)PFModelPlace:(PFPlaceManager *)modelPlace didGetPlace:(BOOL)successed;
- (void)PFModelPlace:(PFPlaceManager *)modelPlace didGetPlaceSortedByRate:(BOOL)successed;

@end

@interface PFPlaceManager : PFObject <PFSubclassing>

@property (nonatomic, weak) id<PFPlaceManagerDelegate>delegate;
@property (nonatomic) FTGooglePlacesAPISearchResponse *lastResponse;
@property (nonatomic) FTGooglePlacesAPINearbySearchRequest *request;
@property (nonatomic) NSMutableArray *nearSearchResults;
@property (nonatomic) NSArray *searchServiceResult;
@property (nonatomic) NSMutableDictionary *placeDetailDictionary;
@property (nonatomic) NSMutableArray *listPlace;
@property (nonatomic) NSMutableArray *listPlaceSortedByRate;

+ (PFPlaceManager *)sharePFModelPlace;

+ (NSString *)parseClassName;

- (void)preparePlace:(PFModelPlace *)place;
- (void)checkExistPlace:(NSString *)identifier;
- (void)addPlace;
- (void)editPlace:(NSDictionary *)place withObject:(PFObject *)object;
- (void)deletePlace:(PFObject *)object;
- (void)queryGetPlace;
- (void)queryGetPlaceWithSortedByRate;
- (NSArray *)places;
- (NSArray *)placeSortedByRate;

- (void)setupDevice;
- (void)createRequestWith:(PFGeoPoint *)geoPoint
                 andTypes:(NSArray *)types;
- (void)performRequestAndHandleResults;
- (void)excuteDetailSearchWithRequest:(FTGooglePlacesAPIDetailRequest *)requestDetail;
- (void)morePlace;
- (void)currentUserLocation:(PFGeoPoint *)geoPoint;

- (void)placeTypesWith:(NSString *)textSearch;
- (NSArray *)placeServices;
- (BOOL)hasNextPage;

- (double)distanceInKilometersFrom:(PFGeoPoint *)source
                                to:(PFGeoPoint *)destination;
- (void)callNumber:(NSString *)phoneNumber;

@end
