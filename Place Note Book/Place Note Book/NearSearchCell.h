//
//  NearSearchCell.h
//  Place Note Book
//
//  Created by Ngo Dac Du on 3/10/15.
//  Copyright (c) 2015 ngodacdu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NearPlaceCell.h"

@class NearPlaceCell;

@protocol NearPlaceCellDelegate <NSObject>

@optional
- (void)nearSearchCellDidSelect:(NearPlaceCell *)placeCell;

@end

@interface NearSearchCell : UICollectionViewCell

@property (nonatomic, weak) id<NearPlaceCellDelegate>delegate;

+ (NSString *)cellIdentifier;

+ (UINib *)loadNib;

@end
