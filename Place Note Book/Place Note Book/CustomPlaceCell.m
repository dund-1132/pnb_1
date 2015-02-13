//
//  CustomPlaceTableViewCell.m
//  Place Note Book
//
//  Created by framgiavn on 2/5/15.
//  Copyright (c) 2015 framgiavn. All rights reserved.
//

#import "CustomPlaceCell.h"
#import "ImageDownload.h"
#import "CustomPageImageView.h"

#define PLACE_CELL_HEIGHT   278

@interface CustomPlaceCell() <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIView *backgroundPlaceView;
@property (weak, nonatomic) IBOutlet UICollectionView *placeCollectionView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

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

- (void)setIconImage:(UIImage *)image {
    [self.iconImageView setImage:image];
}

- (UIImageView *)getIconImageView {
    return self.iconImageView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    [self.placeCollectionView registerClass:[UICollectionViewCell class]
                 forCellWithReuseIdentifier:@"CustomCollectionViewIdentifier"];
    self.placeCollectionView.delegate = self;
    self.placeCollectionView.dataSource = self;
    
    [self setShadowForView:self.backgroundPlaceView];
}

- (void)setShadowForView:(UIView *)shadowView {
    [shadowView.layer setCornerRadius:4.0f];
    [shadowView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [shadowView.layer setBorderWidth:0.5f];
    
    [shadowView.layer setShadowColor:[UIColor lightGrayColor].CGColor];
    [shadowView.layer setShadowOpacity:0.5];
    [shadowView.layer setShadowRadius:4.0];
    [shadowView.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
}

- (void)prepareForReuse {
//    self.iconImageView = nil;
//    [self.nameLabel setText:nil];
//    [self.addressLabel setText:nil];
    
    [super prepareForReuse];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark - Collection View Delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CustomCollectionViewIdentifier" forIndexPath:indexPath];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:cell.contentView.bounds];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [cell.contentView addSubview:imageView];
    NSString *urlString = @"https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcTP0of4WBTP2Pxj_QVZr44gPdlSVLRk14qDPw8kHl5zwC2wr2x8";
    [ImageDownload downloadImageFromURL:urlString andUpdateTo:imageView];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView scrollToItemAtIndexPath:indexPath
                           atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally
                                   animated:YES];
    [[CustomPageImageView shareCustomPageImageView] showPageImageView];
}

@end
