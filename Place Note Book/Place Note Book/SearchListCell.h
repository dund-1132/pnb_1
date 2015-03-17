//
//  SearchListCell.h
//  Place Note Book
//
//  Created by Ngo Dac Du on 3/10/15.
//  Copyright (c) 2015 ngodacdu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "FTGooglePlacesAPI.h"

@interface SearchListCell : UITableViewCell

@property (nonatomic, strong) FTGooglePlacesAPISearchResultItem *item;

+ (NSString *)cellIdentifier;

+ (UINib *)loadNib;

- (void)updateData;

@end
