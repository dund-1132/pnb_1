//
//  NearPlaceCell.m
//  Place Note Book
//
//  Created by Ngo Dac Du on 3/10/15.
//  Copyright (c) 2015 ngodacdu. All rights reserved.
//

#import "NearPlaceCell.h"
#import "PFPlaceManager.h"

@interface NearPlaceCell()

@property (weak, nonatomic) IBOutlet UILabel *serviceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *placeImageView;

@end

@implementation NearPlaceCell

+ (NSString *)cellIdentifier {
    return @"NearPlaceCellIdentifier";
}

+ (UINib *)loadNib {
    return [UINib nibWithNibName:@"NearPlaceCell" bundle:nil];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)refreshService {
    [self.serviceLabel setText:self.serviceName];
    NSString *imageName =
    [[self.serviceName lowercaseString] stringByReplacingOccurrencesOfString:@" "
                                                                  withString:@"-"];
    UIImage *image = [UIImage imageNamed:imageName];
    [self.placeImageView setImage:image];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
