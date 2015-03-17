//
//  ExploreViewController.m
//  Place Note Book
//
//  Created by Ngo Dac Du on 3/8/15.
//  Copyright (c) 2015 ngodacdu. All rights reserved.
//

#import "ExploreViewController.h"
#import "HomeExploreCollectionViewCell.h"
#import "PeopleExploreCollectionViewCell.h"
#import "HomeExploreCell.h"
#import "PlaceDetailViewController.h"
#import "PFPlaceManager.h"

@interface ExploreViewController () <UICollectionViewDataSource, UICollectionViewDelegate, HomeExploreCollectionViewCellDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ExploreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerCollectionViewCell];
}

- (void)registerCollectionViewCell {
    [self.collectionView registerNib:[HomeExploreCollectionViewCell loadNib]
          forCellWithReuseIdentifier:[HomeExploreCollectionViewCell cellIdentifier]];
    [self.collectionView registerNib:[PeopleExploreCollectionViewCell loadNib]
          forCellWithReuseIdentifier:[PeopleExploreCollectionViewCell cellIdentifier]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - collection view delegate
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    float width = collectionView.frame.size.width;
    float height = collectionView.frame.size.height;
    [collectionView setContentInset:UIEdgeInsetsZero];
    
    return CGSizeMake(width, height);
}

#define ADDITION 2
- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return ADDITION;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        HomeExploreCollectionViewCell *cell =
        (HomeExploreCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:[HomeExploreCollectionViewCell cellIdentifier]
                                                                                   forIndexPath:indexPath];
        cell.delegate = self;
        
        return cell;
    } else {
        PeopleExploreCollectionViewCell *cell =
        (PeopleExploreCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:[PeopleExploreCollectionViewCell cellIdentifier]
                                                                                     forIndexPath:indexPath];

        return cell;
    }
    
    return nil;
}

- (IBAction)switchExplore:(id)sender {
    UISegmentedControl *segmentControl = (UISegmentedControl *)sender;
    if (segmentControl.selectedSegmentIndex == 0) {
        [self.collectionView setContentOffset:CGPointZero
                                     animated:YES];
    } else {
        float width = self.collectionView.frame.size.width;
        [self.collectionView setContentOffset:CGPointMake(width, 0)
                                     animated:YES];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x <= 0) {
        [self.segmentControl setSelectedSegmentIndex:0];
    } else if (scrollView.contentOffset.x > 0) {
        [self.segmentControl setSelectedSegmentIndex:1];
    }
}

- (void)homeExploreCollectionViewCell:(HomeExploreCollectionViewCell *)collectionView
             didReceivedTouchUpInside:(HomeExploreCell *)cell {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                         bundle:nil];
    PlaceDetailViewController *placeDetailViewController =
    [storyboard instantiateViewControllerWithIdentifier:@"PlaceDetailViewController"];
    placeDetailViewController.object = cell.object;
    [self.navigationController pushViewController:placeDetailViewController
                                         animated:YES];
}

@end
