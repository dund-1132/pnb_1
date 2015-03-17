//
//  SearchViewController.m
//  Place Note Book
//
//  Created by Ngo Dac Du on 3/10/15.
//  Copyright (c) 2015 ngodacdu. All rights reserved.
//

#import "SearchViewController.h"
#import "NearSearchCell.h"
#import "AdvanceSearchCell.h"
#import "SearchListViewController.h"
#import "NearPlaceCell.h"
#import "PFPlaceManager.h"

@interface SearchViewController () <UICollectionViewDataSource, UICollectionViewDelegate, NearPlaceCellDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *searchCollectionView;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerNib];
}

- (void)registerNib {
    [self.searchCollectionView registerNib:[NearSearchCell loadNib]
                forCellWithReuseIdentifier:[NearSearchCell cellIdentifier]];
    [self.searchCollectionView registerNib:[AdvanceSearchCell loadNib]
                forCellWithReuseIdentifier:[AdvanceSearchCell cellIdentifier]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - collectionview delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return 2;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    float width = collectionView.frame.size.width;
    float height = collectionView.frame.size.height;
    [collectionView setContentInset:UIEdgeInsetsZero];
    
    return CGSizeMake(width, height);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        NearSearchCell *cell =
        (NearSearchCell *)[collectionView dequeueReusableCellWithReuseIdentifier:[NearSearchCell cellIdentifier] forIndexPath:indexPath];
        cell.delegate = self;
        return cell;
    } else {
        AdvanceSearchCell *cell =
        (AdvanceSearchCell *)[collectionView dequeueReusableCellWithReuseIdentifier:[AdvanceSearchCell cellIdentifier] forIndexPath:indexPath];
        return cell;
    }
}

- (void)nearSearchCellDidSelect:(NearPlaceCell *)placeCell {
    [self performSegueWithIdentifier:@"ServiceToListViewController" sender:placeCell];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ServiceToListViewController"]) {
        NearPlaceCell *placeCell = (NearPlaceCell *)sender;
        SearchListViewController *listViewController = [segue destinationViewController];
        listViewController.serviceName = placeCell.serviceName;
        [[PFPlaceManager sharePFModelPlace].nearSearchResults removeAllObjects];
    }
}

@end
