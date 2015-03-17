//
//  PeopleExploreCollectionViewCell.m
//  Place Note Book
//
//  Created by Ngo Dac Du on 3/9/15.
//  Copyright (c) 2015 ngodacdu. All rights reserved.
//

#import "PeopleExploreCollectionViewCell.h"
#import "PeopleExploreCell.h"

@interface PeopleExploreCollectionViewCell() <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation PeopleExploreCollectionViewCell

+ (NSString *)cellIdentifier {
    return @"PeopleExploreCollectionViewCellIdentifier";
}

+ (UINib *)loadNib {
    return [UINib nibWithNibName:@"PeopleExploreCollectionViewCell" bundle:nil];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self registerNib];
}

- (void)registerNib {
    [self.tableView registerNib:[PeopleExploreCell loadNib]
         forCellReuseIdentifier:[PeopleExploreCell cellIdentifier]];
}

#pragma mark - table view delegate, datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)     tableView:(UITableView *)tableView
  heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 250;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = [PeopleExploreCell cellIdentifier];
    PeopleExploreCell *peopleCell =
    (PeopleExploreCell *)[tableView dequeueReusableCellWithIdentifier:identifier
                                                         forIndexPath:indexPath];
    
    return peopleCell;
}

@end
