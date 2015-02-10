//
//  CustomPlaceInformationCellCell.h
//  Place Note Book
//
//  Created by framgiavn on 2/9/15.
//  Copyright (c) 2015 framgiavn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    PlaceDetailCellInforation,
    PlaceDetailCellCollection,
    PlaceDetailCellDescription,
    PlaceDetailCellMap,
    PlaceDetailCellComment
} PlaceDetailCellType;

@interface CustomPlaceDetailCell : UITableViewCell

+ (NSString *)getCellIdentifier:(PlaceDetailCellType)cellType;
+ (UINib *)getNib:(PlaceDetailCellType)cellType;
+ (CGFloat)getHeight:(PlaceDetailCellType)cellType;

@end
