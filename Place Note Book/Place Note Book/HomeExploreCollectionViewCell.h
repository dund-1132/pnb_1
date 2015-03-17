//
//  HomeExploreCollectionViewCell.h
//  Place Note Book
//
//  Created by Ngo Dac Du on 3/9/15.
//  Copyright (c) 2015 ngodacdu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeExploreCell.h"

@class HomeExploreCollectionViewCell;

@protocol HomeExploreCollectionViewCellDelegate <NSObject>

@optional
- (void)homeExploreCollectionViewCell:(HomeExploreCollectionViewCell *)collectionView
             didReceivedTouchUpInside:(HomeExploreCell *)cell;

@end

@interface HomeExploreCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) id<HomeExploreCollectionViewCellDelegate>delegate;

+ (NSString *)cellIdentifier;

+ (UINib *)loadNib;

@end
