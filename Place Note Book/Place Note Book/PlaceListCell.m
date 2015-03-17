//
//  PlaceListCell.m
//  Place Note Book
//
//  Created by Ngo Dac Du on 3/13/15.
//  Copyright (c) 2015 ngodacdu. All rights reserved.
//

#import "PlaceListCell.h"

@implementation PlaceListCell

+ (NSString *)cellIdentifier {
    return @"PlaceListCellIdentifier";
}

+ (UINib *)loadNib {
    return [UINib nibWithNibName:@"PlaceListCell" bundle:nil];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
