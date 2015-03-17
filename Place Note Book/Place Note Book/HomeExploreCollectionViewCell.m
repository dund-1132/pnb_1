//
//  HomeExploreCollectionViewCell.m
//  Place Note Book
//
//  Created by Ngo Dac Du on 3/9/15.
//  Copyright (c) 2015 ngodacdu. All rights reserved.
//

#import "HomeExploreCollectionViewCell.h"
#import "ExploreDataManagement.h"
#import "ImageDownload.h"
#import "PFPlaceManager.h"
#import <Parse/Parse.h>

#define NUM_SECTION 1
#define NUMBER_CATEGORY    4
#define NUMBER_CATEGORY_LOAD    1
#define TIME_LINE_HEIGHT    120
#define TOTAL_LINE_SPACE    2
#define NUM_ITEM_PER_ROW    2
#define MIN_SPACE   20

@interface HomeExploreCollectionViewCell() <UICollectionViewDataSource, UICollectionViewDelegate, PFPlaceManagerDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *shareCollectionView;

@end

@implementation HomeExploreCollectionViewCell

@synthesize delegate;

+ (NSString *)cellIdentifier {
    return @"HomeExploreCollectionViewCellIdentifier";
}

+ (UINib *)loadNib {
    return [UINib nibWithNibName:@"HomeExploreCollectionViewCell" bundle:nil];
}


#define ANIMATION 2.0
- (void)awakeFromNib {
    [super awakeFromNib];
    [PFPlaceManager sharePFModelPlace].delegate = self;
    [[PFPlaceManager sharePFModelPlace] queryGetPlaceWithSortedByRate];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.shareCollectionView.dataSource = self;
    self.shareCollectionView.delegate = self;
    
    [self.collectionView registerClass:[UICollectionViewCell class]
           forCellWithReuseIdentifier:@"TimelineCollectionViewIdentifier"];
    [self.shareCollectionView registerNib:[HomeExploreCell loadNib]
               forCellWithReuseIdentifier:[HomeExploreCell cellIdentifier]];

    [self startTimelineWithAnimation];
}

- (void)PFModelPlace:(PFPlaceManager *)modelPlace didGetPlaceSortedByRate:(BOOL)successed {
    if (successed) {
        [self.shareCollectionView reloadData];
    } else {
        
    }
}

- (void)dealloc {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

#pragma mark - animation timeline imageview
- (void)startTimelineWithAnimation {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    NSInteger pageCount = [self.collectionView numberOfItemsInSection:0];
    NSIndexPath *visibleIndexPath = [[self.collectionView indexPathsForVisibleItems] firstObject];
    if (visibleIndexPath == nil) {
        visibleIndexPath = [NSIndexPath indexPathForItem:0
                                               inSection:0];
    } else {
        NSInteger currentItem = visibleIndexPath.row;
        if (currentItem < (pageCount - 1)) {
            visibleIndexPath = [NSIndexPath indexPathForItem:(currentItem + 1)
                                                   inSection:0];
        } else {
            visibleIndexPath = nil;
        }
    }
    float width = [[UIScreen mainScreen] bounds].size.width;
    float positionX = width * visibleIndexPath.row;
    [self.collectionView setContentOffset:CGPointMake(positionX, 0)
                                 animated:YES];
    
    [self performSelector:@selector(startTimelineWithAnimation)
               withObject:nil
               afterDelay:ANIMATION];
}

#pragma mark - collection view delegate
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    float width = collectionView.frame.size.width;
    if ([collectionView isEqual:self.collectionView]) {
        float width = [UIScreen mainScreen].bounds.size.width;
        return CGSizeMake(width, TIME_LINE_HEIGHT);
    } else if ([collectionView isEqual:self.shareCollectionView]) {
        float width = self.shareCollectionView.frame.size.width;
        float cellWidth = width / NUM_ITEM_PER_ROW - 1.5 * MIN_SPACE;
        return CGSizeMake(cellWidth, cellWidth);
    }
    
    return CGSizeMake(width, width);
}

- (CGFloat)             collectionView:(UICollectionView *)collectionView
                                layout:(UICollectionViewLayout*)collectionViewLayout
   minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if ([collectionView isEqual:self.collectionView]) {
        return 0;
    }
    if ([collectionView isEqual:self.shareCollectionView]) {
        return TOTAL_LINE_SPACE;
    }
    
    return 0;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return NUM_SECTION;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    if ([collectionView isEqual:self.collectionView]) {
        return [[[ExploreDataManagement shareExploreDataManagement] timelineDatas] count];
    } else if ([collectionView isEqual:self.shareCollectionView]) {
        
        return [[PFPlaceManager sharePFModelPlace].listPlaceSortedByRate count];
    }
    
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([collectionView isEqual:self.collectionView]) {
        UICollectionViewCell *cell =
        [collectionView dequeueReusableCellWithReuseIdentifier:@"TimelineCollectionViewIdentifier"
                                                  forIndexPath:indexPath];
        NSArray *imageDatas = [[ExploreDataManagement shareExploreDataManagement] timelineDatas];
        UIImage *image = [UIImage imageNamed:[imageDatas objectAtIndex:indexPath.row]];
        if (image) {
            UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            [imageView setFrame:cell.bounds];
            [cell addSubview:imageView];
        }
        
        return cell;
    } else if ([collectionView isEqual:self.shareCollectionView]) {
        HomeExploreCell *cell =
        [collectionView dequeueReusableCellWithReuseIdentifier:[HomeExploreCell cellIdentifier]
                                                  forIndexPath:indexPath];
        PFObject *object = [PFPlaceManager sharePFModelPlace].listPlaceSortedByRate[indexPath.row];
        cell.object = object;
        [cell refresh];
        
        return cell;
    }
    
    return nil;
}

- (void)    collectionView:(UICollectionView *)collectionView
  didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    SEL selector = @selector(homeExploreCollectionViewCell:didReceivedTouchUpInside:);
    if (delegate && [delegate respondsToSelector:selector]) {
        HomeExploreCell *cell = (HomeExploreCell *)[collectionView cellForItemAtIndexPath:indexPath];
        [delegate homeExploreCollectionViewCell:self
                       didReceivedTouchUpInside:cell];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (decelerate) {
        NSInteger currentOffset = scrollView.contentOffset.y;
        NSInteger maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;
        
        if (maximumOffset - currentOffset <= 0) {
//            start = start + loadMore;
//            [self.shareCollectionView reloadData];
        }
    }
}

@end
