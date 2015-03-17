//
//  HomeExploreCell.m
//  Place Note Book
//
//  Created by Ngo Dac Du on 3/10/15.
//  Copyright (c) 2015 ngodacdu. All rights reserved.
//

#import "HomeExploreCell.h"
#import "PlaceNoteBookStandard.h"
#import "ImageDownload.h"

#define CORNER_RADIUS   3.0

@interface HomeExploreCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *rateView;
@property (weak, nonatomic) IBOutlet UILabel *placeName;
@property (weak, nonatomic) IBOutlet UILabel *placeAddress;
@property (weak, nonatomic) IBOutlet UILabel *rate;

@end

@implementation HomeExploreCell

+ (NSString *)cellIdentifier {
    return @"ShareCollectionViewIdentifier";
}

+ (UINib *)loadNib {
    return [UINib nibWithNibName:@"HomeExploreCell" bundle:nil];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self makeUpCell];
}

- (void)makeUpCell {
    self.rateView.layer.cornerRadius = self.rateView.frame.size.width / 2;
}

- (void)loadImage:(NSString *)url {
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.imageView];
    [ImageDownload downloadImageFromURL:url
                            andUpdateTo:self.imageView];
    self.rateView.layer.zPosition = 1;
}

- (void)refresh {
//    NSString *url = self.object[@""];
    NSString *url = @"https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcTZcL18Rnwrx3WqvGtkNFuDvVOWULfwX11K3NBj65uXMYmp9fJVUw";
    [self loadImage:url];
    [self.placeName setText:self.object[@"name"]];
    [self.placeAddress setText:self.object[@"address"]];
    [self.rate setText:self.object[@"rating"]];
}

@end
