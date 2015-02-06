//
//  CustomPlaceTableViewCell.m
//  Place Note Book
//
//  Created by framgiavn on 2/5/15.
//  Copyright (c) 2015 framgiavn. All rights reserved.
//

#import "CustomPlaceCell.h"

#define PLACE_CELL_HEIGHT   250

@interface CustomPlaceCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end

@implementation CustomPlaceCell

+ (NSString *)cellIdentifier {
    return @"PlaceCellIdentifier";
}

+ (UINib *)getPlaceNib {
    return [UINib nibWithNibName:@"PlaceCell" bundle:nil];
}

+ (CGFloat)getHeight {
    return PLACE_CELL_HEIGHT;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)prepareForReuse {
    self.iconImageView = nil;
    [self.nameLabel setText:nil];
    [self.addressLabel setText:nil];
    
    [super prepareForReuse];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
