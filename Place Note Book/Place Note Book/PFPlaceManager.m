//
//  PFModelPlace.m
//  Place Note Book
//
//  Created by Ngo Dac Du on 3/4/15.
//  Copyright (c) 2015 framgiavn. All rights reserved.
//

#import "PFPlaceManager.h"
#import "PFModelUser.h"
#import "PFUserManager.h"

/* 01 */NSString *const kPFPlaceTypeATMString = @"atm";
/* 02 */NSString *const kPFPlaceTypeBankString = @"bank";
/* 03 */NSString *const kPFPlaceTypeSchoolString = @"school";
/* 04 */NSString *const kPFPlaceTypeUniversityString = @"university";
/* 05 */NSString *const kPFPlaceTypeBarString = @"bar";
/* 06 */NSString *const kPFPlaceTypeBookStoreString = @"book_store";
/* 07 */NSString *const kPFPlaceTypeBusStationString = @"bus_station";
/* 08 */NSString *const kPFPlaceTypeCafeString = @"cafe";
/* 09 */NSString *const kPFPlaceTypeClothingStoreString = @"clothing_store";
/* 10 */NSString *const kPFPlaceTypeFinanceString = @"finance";
/* 11 */NSString *const kPFPlaceTypeFoodString = @"food";
/* 12 */NSString *const kPFPlaceTypeGasStationString = @"gas_station";
/* 13 */NSString *const kPFPlaceTypeGymString = @"gym";
/* 14 */NSString *const kPFPlaceTypeHairCareString = @"hair_care";
/* 15 */NSString *const kPFPlaceTypeHospitalString = @"hospital";
/* 16 */NSString *const kPFPlaceTypeInsuranceAgencyString = @"insurance_agency";
/* 17 */NSString *const kPFPlaceTypeLibraryString = @"library";
/* 18 */NSString *const kPFPlaceTypeMovieTheaterString = @"movie_theater";
/* 19 */NSString *const kPFPlaceTypeMusiumString = @"museum";
/* 20 */NSString *const kPFPlaceTypeParkString = @"park";
/* 21 */NSString *const kPFPlaceTypeParkingString = @"parking";
/* 22 */NSString *const kPFPlaceTypePoliceString = @"police";
/* 23 */NSString *const kPFPlaceTypeRealEstateString = @"real_estate_agency";
/* 24 */NSString *const kPFPlaceTypeRestaurantString = @"restaurant";
/* 25 */NSString *const kPFPlaceTypeStadiumString = @"stadium";
/* 26 */NSString *const kPFPlaceTypeStoreString = @"store";
/* 27 */NSString *const kPFPlaceTypeSubwayStationString = @"subway_station";
/* 28 */NSString *const kPFPlaceTypeTrainStationString = @"train_station";
/* 29 */NSString *const kPFPlaceTypeZooString = @"zoo";
/* 30 */NSString *const kPFPlaceTypeAirportString = @"airport";
/* 31 */NSString *const kPFPlaceTypeAccountingString = @"accounting";

// Google Place API Key
// NgoDacDu AIzaSyA9LeiTKpQr6rMUMooNR0Vs9mYxVz1_RTQ
// LeMinhTuan AIzaSyBg02ORn_Kk4l4005sH8AzaNTH_b2gBCuA
NSString *const kGooglePlaceAPIKey = @"AIzaSyA9LeiTKpQr6rMUMooNR0Vs9mYxVz1_RTQ";

#define PLACE_USER  @"parent"
#define PLACE_IDENTIFIER @"identifier"
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

static PFPlaceManager *staticPFModelPlace;

@interface PFPlaceManager()

@property (nonatomic) NSArray *services;
@property (nonatomic) PFModelPlace *placeDictionary;

@end

@implementation PFPlaceManager

@synthesize delegate, lastResponse, request, nearSearchResults, services, searchServiceResult, placeDetailDictionary, placeDictionary, listPlace, listPlaceSortedByRate;

+ (PFPlaceManager *)sharePFModelPlace {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        staticPFModelPlace = [[PFPlaceManager alloc] init];
    });
    
    return staticPFModelPlace;
}

- (instancetype)init {
    if (self = [super init]) {
        self.nearSearchResults = [[NSMutableArray alloc] init];
        self.listPlace = [[NSMutableArray alloc] init];
        self.listPlaceSortedByRate = [[NSMutableArray alloc] init];
        self.services = @[@"ATM",
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

+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"Place";
}

- (void)preparePlace:(PFModelPlace *)place {
    self.placeDictionary = place;
    if (delegate && [delegate respondsToSelector:@selector(PFModelPlace:didPreparePlace:identifier:)]) {
        NSString *identifier = place.identifier;
        [delegate PFModelPlace:self
               didPreparePlace:YES
                    identifier:identifier];
    }
}

- (void)checkExistPlace:(NSString *)identifier {
    PFQuery *query = [PFQuery queryWithClassName:[PFPlaceManager parseClassName]];
    [query whereKey:@"identifier" equalTo:identifier];
    [query setLimit:1];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            SEL selector = @selector(PFModelPlace:isExist:identifier:);
            if (delegate && [delegate respondsToSelector:selector]) {
                if ([objects count] > 0) {
                    [delegate PFModelPlace:self isExist:YES identifier:identifier];
                } else {
                    [delegate PFModelPlace:self isExist:NO identifier:identifier];
                }
            }
        }
    }];
}

- (void)addPlace {
    PFObject *place = [PFObject objectWithClassName:[PFPlaceManager parseClassName]];
    
    NSString *identifier = placeDictionary.identifier;
    NSString *name = placeDictionary.name;
    PFGeoPoint *location = placeDictionary.location;
    NSString *address = placeDictionary.address;
    NSString *formattedAddress = placeDictionary.formatAddress;
    NSString *formattedPhone = placeDictionary.formatPhone;
    NSString *iconImageURL = placeDictionary.iconURL;
    float rating = placeDictionary.rating;
    NSString *reference = placeDictionary.reference;
    NSArray *types = [NSArray arrayWithArray:placeDictionary.types];
    NSString *url = placeDictionary.url;
    NSString *webURL = placeDictionary.websiteURL;
    
    if (identifier) {
        place[PLACE_IDENTIFIER] = identifier;
        place[PLACE_USER] = placeDictionary.parent;
        place[PLACE_NAME] = name ? name : @"";
        place[PLACE_LOCATION] = location;
        place[PLACE_ADDRESS] = address ? address : @"";
        place[PLACE_FORMAT_ADDRESS] = formattedAddress ? formattedAddress : @"";
        place[PLACE_FORMAT_PHONE] = formattedPhone ? formattedPhone : @"";
        place[PLACE_ICON_URL] = iconImageURL ? iconImageURL : @"";
        place[PLACE_RATE] = [NSNumber numberWithFloat:rating];
        place[PLACE_REFERENCE] = reference ? reference : @"";
        place[PLACE_TYPES] = types;
        place[PLACE_URL] = url;
        place[PLACE_WEB_URL] = webURL;
    }
  
    [place pinInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (delegate && [delegate respondsToSelector:@selector(PFModelPlace:didAddPlace:)]) {
            if (succeeded) {
                [delegate PFModelPlace:self didAddPlace:YES];
            } else {
                [delegate PFModelPlace:self didAddPlace:NO];
            }
        }
    }];

    [place saveEventually];
}

- (void)editPlace:(NSDictionary *)place withObject:(PFObject *)object {
    
}

- (void)deletePlace:(PFObject *)object {
    
}

- (void)queryGetPlace {
    PFQuery *query = [PFQuery queryWithClassName:[PFPlaceManager parseClassName]];
    [query whereKey:@"parent" equalTo:[[PFUserManager sharePFUserManager] currentUser]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            SEL selector = @selector(PFModelPlace:didGetPlace:);
            if (delegate && [delegate respondsToSelector:selector]) {
                if ([objects count] > 0) {
                    self.listPlace = [NSMutableArray arrayWithArray:objects];
                    [delegate PFModelPlace:self didGetPlace:YES];
                } else {
                    [delegate PFModelPlace:self didGetPlace:NO];
                }
            }
        }
    }];
}

- (void)queryGetPlaceWithSortedByRate {
    PFQuery *query = [PFQuery queryWithClassName:[PFPlaceManager parseClassName]];
    [query orderByDescending:@"rating"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            SEL selector = @selector(PFModelPlace:didGetPlaceSortedByRate:);
            if (delegate && [delegate respondsToSelector:selector]) {
                if ([objects count] > 0) {
                    self.listPlaceSortedByRate = [NSMutableArray arrayWithArray:objects];
                    [delegate PFModelPlace:self didGetPlaceSortedByRate:YES];
                } else {
                    [delegate PFModelPlace:self didGetPlaceSortedByRate:NO];
                }
            }
        }
    }];
}


- (NSArray *)places {
    return [NSArray arrayWithArray:self.listPlace];
}

- (NSArray *)placeSortedByRate {
    return [NSArray arrayWithArray:self.listPlaceSortedByRate];
}

- (void)setupDevice {
    [FTGooglePlacesAPIService provideAPIKey:kGooglePlaceAPIKey];
    [FTGooglePlacesAPIService setDebugLoggingEnabled:YES];
}

- (void)createRequestWith:(PFGeoPoint *)geoPoint andTypes:(NSArray *)types {
    CLLocationCoordinate2D locationCoordinate =
    CLLocationCoordinate2DMake(geoPoint.latitude, geoPoint.longitude);
    self.request =
    [[FTGooglePlacesAPINearbySearchRequest alloc] initWithLocationCoordinate:locationCoordinate];
    self.request.rankBy = FTGooglePlacesAPIRequestParamRankByDistance;
    self.request.types = types;
    if (delegate && [delegate respondsToSelector:@selector(PFModelPlace:didCreateRequest:)]) {
        [delegate PFModelPlace:self didCreateRequest:YES];
    }
}

- (void)performRequestAndHandleResults {
    [FTGooglePlacesAPIService executeSearchRequest:self.request
                             withCompletionHandler:^(FTGooglePlacesAPISearchResponse *response, NSError *error) {
                                 if (error) {
                                     NSLog(@"Request failed. Error: %@", error);
                                 }
                                 // respone
                                 self.lastResponse = response;
                                 [self processRespone:response];
                             }];
}

- (void)processRespone:(FTGooglePlacesAPISearchResponse *)response {
    if (!self.nearSearchResults) {
        self.nearSearchResults = [[NSMutableArray alloc] init];
    }
    [self.nearSearchResults addObjectsFromArray:[response results]];
    SEL selector = @selector(PFModelPlace:didResponeRequest:);
    if (delegate && [delegate respondsToSelector:selector]) {
        [delegate PFModelPlace:self didResponeRequest:YES];
    }
}

- (void)excuteDetailSearchWithRequest:(FTGooglePlacesAPIDetailRequest *)requestDetail {
    [FTGooglePlacesAPIService executeDetailRequest:requestDetail
                             withCompletionHandler:^(FTGooglePlacesAPIDetailResponse *response, NSError *error) {
                                 if (error) {
                                     NSLog(@"Request failed. Error: %@", error);
                                 }
                                 [self processResponeDetail:response];
                             }];
}

- (void)processResponeDetail:(FTGooglePlacesAPIDetailResponse *)respone {
    if (!self.placeDetailDictionary) {
        self.placeDetailDictionary = [[NSMutableDictionary alloc] init];
    }
    [self.placeDetailDictionary setValue:respone.itemId forKey:@"itemId"];
    [self.placeDetailDictionary setValue:respone.name forKey:@"name"];
    [self.placeDetailDictionary setValue:respone.location forKey:@"location"];
    [self.placeDetailDictionary setValue:respone.addressString forKey:@"addressString"];
    [self.placeDetailDictionary setValue:respone.formattedAddress forKey:@"formattedAddress"];
    [self.placeDetailDictionary setValue:respone.formattedPhoneNumber forKey:@"formattedPhoneNumber"];
    [self.placeDetailDictionary setValue:respone.iconImageUrl forKey:@"iconImageUrl"];
    [self.placeDetailDictionary setValue:[NSNumber numberWithFloat:respone.rating] forKey:@"rating"];
    [self.placeDetailDictionary setValue:respone.reference forKey:@"reference"];
    [self.placeDetailDictionary setValue:respone.types forKey:@"types"];
    [self.placeDetailDictionary setValue:respone.url forKey:@"url"];
    [self.placeDetailDictionary setValue:respone.websiteUrl forKey:@"websiteUrl"];

    SEL selector = @selector(PFModelPlace:didResponeDetail:);
    if (delegate && [delegate respondsToSelector:selector]) {
        [delegate PFModelPlace:self didResponeDetail:YES];
    }
}

- (void)currentUserLocation:(PFGeoPoint *)geoPoint {
    CLLocationCoordinate2D locationCoordinate =
    CLLocationCoordinate2DMake(geoPoint.latitude, geoPoint.longitude);
    FTGooglePlacesAPINearbySearchRequest *requestUser =
    [[FTGooglePlacesAPINearbySearchRequest alloc] initWithLocationCoordinate:locationCoordinate];
    [FTGooglePlacesAPIService executeSearchRequest:requestUser
                             withCompletionHandler:^(FTGooglePlacesAPISearchResponse *response, NSError *error) {
                                 if (error) {
                                     NSLog(@"Request failed. Error: %@", error);
                                 }
                                 NSLog(@"%@", response.results);
                                 for (FTGooglePlacesAPISearchResultItem *item in response.results) {
                                     NSLog(@"%@", item.placeId);
                                 }
                             }];
}

- (void)morePlace {
    if ([self.lastResponse hasNextPage]) {
        [self.lastResponse nextPageRequest];
        [self performRequestAndHandleResults];
    }
}

- (BOOL)hasNextPage {
    return [self.lastResponse hasNextPage];
}

- (void)placeTypesWith:(NSString *)textSearch {
    if ([textSearch length] == 0) {
        self.searchServiceResult = [NSArray arrayWithArray:self.services];
    } else {
        NSPredicate *predicate =
        [NSPredicate predicateWithFormat:@"SELF contains[c] %@", textSearch];
        self.searchServiceResult = [self.services filteredArrayUsingPredicate:predicate];
    }
}

- (NSArray *)placeServices {
    return self.services;
}

- (double)distanceInKilometersFrom:(PFGeoPoint *)source to:(PFGeoPoint *)destination {    
    return [source distanceInKilometersTo:destination];
}

- (void)callNumber:(NSString *)phoneNumber {
    NSString *number = [phoneNumber stringByReplacingOccurrencesOfString:@" "
                                                              withString:@""];
    NSURL *phoneUrl = [NSURL URLWithString:[NSString stringWithFormat:@"telprompt:%@", number]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        [[UIApplication sharedApplication] openURL:phoneUrl];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Call facility is not available!!!"
                                                           delegate:nil cancelButtonTitle:@"ok"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
    }
}

@end
