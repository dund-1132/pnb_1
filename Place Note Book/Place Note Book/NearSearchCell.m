//
//  NearSearchCell.m
//  Place Note Book
//
//  Created by Ngo Dac Du on 3/10/15.
//  Copyright (c) 2015 ngodacdu. All rights reserved.
//

#import "NearSearchCell.h"
#import "PFPlaceManager.h"
#import "CustomInputAccessoryView.h"

@interface NearSearchCell() <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, CustomInputAccessoryViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *nearSearchTableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation NearSearchCell

@synthesize delegate;

+ (NSString *)cellIdentifier {
    return @"NearSearchCellIdentifier";
}

+ (UINib *)loadNib {
    return [UINib nibWithNibName:@"NearSearchCell" bundle:nil];
}

// custom input accessory view -> keyboard
- (UIView *)inputAccessoryView {
    CustomInputAccessoryView *customAccessoryView = [CustomInputAccessoryView instanceFromNibFile];
    customAccessoryView.delegate = self;
    
    return customAccessoryView;
}

- (void)inputAccessoryViewPreviousButtonDidClick {
    
}

- (void)inputAccessoryViewNextButtonDidClick {
    
}

- (void)inputAccessoryViewDoneButtonDidClick {
    [self.searchBar setShowsCancelButton:NO animated:YES];
    [self.searchBar resignFirstResponder];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.nearSearchTableView.delegate = self;
    self.nearSearchTableView.dataSource = self;
    self.searchBar.delegate = self;
    [self registerNearPlaceCell];
    [[PFPlaceManager sharePFModelPlace] placeTypesWith:@""];
}

- (void)registerNearPlaceCell {
    [self.nearSearchTableView registerNib:[NearPlaceCell loadNib]
                   forCellReuseIdentifier:[NearPlaceCell cellIdentifier]];
}

#pragma mark - search bar delegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:YES animated:YES];
    
    return YES;
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:NO animated:YES];
    searchBar.text = nil;
    [searchBar resignFirstResponder];
    [self updateService:@""];
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)theSearchBar {
    [theSearchBar setShowsCancelButton:NO animated:YES];
    [theSearchBar resignFirstResponder];
    [self updateService:@""];
}

- (void)searchBar:(UISearchBar *)searchBar
    textDidChange:(NSString *)searchText {
    [self updateService:searchText];
}

- (void)updateService:(NSString *)text {
    [[PFPlaceManager sharePFModelPlace] placeTypesWith:text];
    [self.nearSearchTableView reloadData];
}

#pragma mark - tableview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)     tableView:(UITableView *)tableView
  heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 66;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return [[PFPlaceManager sharePFModelPlace].searchServiceResult count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NearPlaceCell *cell =
    [tableView dequeueReusableCellWithIdentifier:[NearPlaceCell cellIdentifier]
                                    forIndexPath:indexPath];
    NSArray *services = [PFPlaceManager sharePFModelPlace].searchServiceResult;
    NSString *serviceName = [services objectAtIndex:indexPath.row];
    cell.serviceName = serviceName;
    [cell refreshService];
    
    return cell;
}

- (void)        tableView:(UITableView *)tableView
  didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (delegate && [delegate respondsToSelector:@selector(nearSearchCellDidSelect:)]) {
        NearPlaceCell *cell = (NearPlaceCell *)[tableView cellForRowAtIndexPath:indexPath];
        [delegate nearSearchCellDidSelect:cell];
    }
}

@end
