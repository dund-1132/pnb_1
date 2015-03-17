//
//  PlaceListController.m
//  Place Note Book
//
//  Created by Ngo Dac Du on 3/13/15.
//  Copyright (c) 2015 ngodacdu. All rights reserved.
//

#import "PlaceListController.h"
#import "PFPlaceManager.h"
#import "PlaceListCell.h"

@interface PlaceListController () <UITableViewDataSource, UITableViewDelegate, PFPlaceManagerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *placeListTableView;

@end

@implementation PlaceListController

- (void)viewDidLoad {
    [super viewDidLoad];
    [PFPlaceManager sharePFModelPlace].delegate = self;
    [self registerPlaceListCell];
    [[PFPlaceManager sharePFModelPlace] queryGetPlace];
}

- (void)registerPlaceListCell {
    [self.placeListTableView registerNib:[PlaceListCell loadNib]
                  forCellReuseIdentifier:[PlaceListCell cellIdentifier]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - table view delegate
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return [[[PFPlaceManager sharePFModelPlace] places] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PlaceListCell *cell =
    (PlaceListCell *)[tableView dequeueReusableCellWithIdentifier:[PlaceListCell cellIdentifier]
                                                     forIndexPath:indexPath];
    
    return cell;
}


#pragma mark - PFPlaceManagerDelegate
- (void)PFModelPlace:(PFPlaceManager *)modelPlace didGetPlace:(BOOL)successed {
    if (successed) {
        [self.placeListTableView reloadData];
    }
}

@end
