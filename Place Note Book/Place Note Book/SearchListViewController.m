//
//  SearchListViewController.m
//  Place Note Book
//
//  Created by Ngo Dac Du on 3/10/15.
//  Copyright (c) 2015 ngodacdu. All rights reserved.
//

#import "SearchListViewController.h"
#import "SearchListCell.h"
#import "PFPlaceManager.h"
#import "PFUserManager.h"

@interface SearchListViewController () <UITableViewDataSource, UITableViewDelegate, PFUserManagerDelegate, PFPlaceManagerDelegate>

@property (strong, nonatomic) IBOutlet UITableView *searchListTableView;

@end

@implementation SearchListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [PFUserManager sharePFUserManager].delegate = self;
    [PFPlaceManager sharePFModelPlace].delegate = self;
    [[PFPlaceManager sharePFModelPlace] setupDevice];
    [self registerSearchListCell];
    [[PFUserManager sharePFUserManager] userCurrentLocation];
}

- (void)registerSearchListCell {
    [self.searchListTableView registerNib:[SearchListCell loadNib]
                   forCellReuseIdentifier:[SearchListCell cellIdentifier]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - user delegate
- (void)PFModelUserDidUserLocation:(BOOL)succeeded location:(PFGeoPoint *)geoPoint {
    if (!self.serviceName) {
        self.serviceName = @"atm";// default
    }
    if (succeeded) {
        NSString *formatService = [self.serviceName lowercaseString];
        formatService = [formatService stringByReplacingOccurrencesOfString:@" "
                                                                 withString:@"_"];
        [[PFPlaceManager sharePFModelPlace] createRequestWith:geoPoint
                                                     andTypes:@[formatService]];
    } else {
        // can not get location
    }

}

- (void)PFModelPlace:(PFModelPlace *)modelPlace didCreateRequest:(BOOL)successed {
    if (successed) {
        [[PFPlaceManager sharePFModelPlace] performRequestAndHandleResults];
    }
}

- (void)PFModelPlace:(PFModelPlace *)modelPlace didResponeRequest:(BOOL)successed {
    if (successed) {
        [self.searchListTableView reloadData];
    } else {
        NSLog(@"Can not load more");
    }
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[PFPlaceManager sharePFModelPlace].nearSearchResults count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchListCell *cell =
    (SearchListCell *)[tableView dequeueReusableCellWithIdentifier:[SearchListCell cellIdentifier]
                                                      forIndexPath:indexPath];
    FTGooglePlacesAPISearchResultItem *item =
    [[PFPlaceManager sharePFModelPlace].nearSearchResults objectAtIndex:indexPath.row];
    cell.item = item;
    [cell updateData];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger count = [[PFPlaceManager sharePFModelPlace].nearSearchResults count];
    if ([indexPath row] == (count - 1)) {
        [[PFPlaceManager sharePFModelPlace] morePlace];
    }
}

@end
