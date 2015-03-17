//
//  SearchListCell.m
//  Place Note Book
//
//  Created by Ngo Dac Du on 3/10/15.
//  Copyright (c) 2015 ngodacdu. All rights reserved.
//

#import "SearchListCell.h"
#import "PFUserManager.h"
#import "PFPlaceManager.h"
#import "ImageDownload.h"
#import "ValidateTextField.h"
#import "PlaceNoteBookStandard.h"

#define CORNER_RADIUS   3.0

@interface SearchListCell()

@property (weak, nonatomic) IBOutlet UIView *shadowView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *placeName;
@property (weak, nonatomic) IBOutlet UILabel *distance;
@property (weak, nonatomic) IBOutlet UILabel *placeAddress;
@property (weak, nonatomic) IBOutlet UILabel *rate;
@property (weak, nonatomic) IBOutlet UIView *controlView;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UIView *rateView;

@end

@implementation SearchListCell

+ (NSString *)cellIdentifier {
    return @"SearchListCellIdentifier";
}

+ (UINib *)loadNib {
    return [UINib nibWithNibName:@"SearchListCell" bundle:nil];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self makeUpCell:self.shadowView];
    [ValidateTextField roundCornersOnView:self.controlView
                                onTopLeft:NO
                                 topRight:NO
                               bottomLeft:YES
                              bottomRight:YES
                                   radius:CORNER_RADIUS];
    [ValidateTextField roundCornersOnView:self.likeButton
                                onTopLeft:NO
                                 topRight:NO
                               bottomLeft:YES
                              bottomRight:NO
                                   radius:CORNER_RADIUS];
    [ValidateTextField roundCornersOnView:self.saveButton
                                onTopLeft:NO
                                 topRight:NO
                               bottomLeft:NO
                              bottomRight:YES
                                   radius:CORNER_RADIUS];
}

- (void)makeUpCell:(UIView *)view {
    [view.layer setCornerRadius:CORNER_RADIUS];
    [view.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [view.layer setBorderWidth:[PlaceNoteBookStandard lineWidth]];
    
    [view.layer setShadowColor:[UIColor blackColor].CGColor];
    [view.layer setShadowOpacity:0.2];
    [view.layer setShadowRadius:CORNER_RADIUS];
    [view.layer setShadowOffset:CGSizeMake(1.0, 2.0)];
    
    self.rateView.layer.cornerRadius = self.rateView.frame.size.width / 2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)updateData {
    [self.placeName setText:self.item.name];
    [self.placeAddress setText:[NSString stringWithFormat:@"Address: %@", self.item.addressString]];
    [ImageDownload downloadImageFromURL:self.item.iconImageUrl
                            andUpdateTo:self.iconImageView];
    PFGeoPoint *source = [[PFUserManager sharePFUserManager] location];
    PFGeoPoint *destination = [PFGeoPoint geoPointWithLocation:self.item.location];
    double distance = [[PFPlaceManager sharePFModelPlace] distanceInKilometersFrom:source
                                                                                to:destination];
    [self.distance setText:[NSString stringWithFormat:@"Distance: %.1f kilometer", distance]];
}

- (IBAction)likeButtonDidClick:(id)sender {
    NSLog(@"Like");
}

- (IBAction)shareButtonDidClick:(id)sender {
    NSLog(@"Share");
}

- (IBAction)saveButtonDidClick:(id)sender {
    NSLog(@"Save");
}

@end
