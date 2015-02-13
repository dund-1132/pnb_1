//
//  CustomPlaceInformationCellCell.m
//  Place Note Book
//
//  Created by framgiavn on 2/9/15.
//  Copyright (c) 2015 framgiavn. All rights reserved.
//

#import "CustomPlaceDetailCell.h"
#import "ImageDownload.h"
#import "CustomPageImageView.h"
#import <MapKit/MapKit.h>

#define PLACE_DETAIL_IDENTIFIER_INFORMATION   @"PlaceDetailInformationCell"
#define PLACE_DETAIL_IDENTIFIER_COLLECTION    @"PlaceDetailCollectionCell"
#define PLACE_DETAIL_IDENTIFIER_DESCRIPTION   @"PlaceDetailDescriptionCell"
#define PLACE_DETAIL_IDENTIFIER_MAP   @"PlaceDetailMapCell"
#define PLACE_DETAIL_IDENTIFIER_CMMENT  @"PlaceDetailCommentCell"

#define NIB_INFORMATION @"CustomPlaceInformationCell"
#define NIB_COLLECTION  @"CustomPlaceCollectionCell"
#define NIB_DESCRIPTION @"CustomPlaceDescriptionCell"
#define NIB_MAP @"CustomPlaceMapCell"
#define NIB_COMMENT @"CustomPlaceCommentCell"

#define HEIGHT_INFORMATION  100
#define HEIGHT_COLLECTION   200
#define HEIGHT_DESCRIPTION  120
#define HEIGHT_MAP  300
#define HEIGHT_COMMENT  150

static MKMapView *mapView;

@interface CustomPlaceDetailCell() <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *placeCollectionCell;

@end

@implementation CustomPlaceDetailCell

+ (NSString *)getCellIdentifier:(PlaceDetailCellType)cellType {
    switch (cellType) {
        case 0:
            return PLACE_DETAIL_IDENTIFIER_INFORMATION;
            break;
            
        case 1:
            return PLACE_DETAIL_IDENTIFIER_COLLECTION;
            break;
            
        case 2:
            return PLACE_DETAIL_IDENTIFIER_DESCRIPTION;
            break;
            
        case 3:
            return PLACE_DETAIL_IDENTIFIER_MAP;
            break;
            
        case 4:
            return PLACE_DETAIL_IDENTIFIER_CMMENT;
            break;
            
        default:
            break;
    }
    
    return @"";
}

+ (UINib *)getNib:(PlaceDetailCellType)cellType {
    switch (cellType) {
        case 0:
            return [UINib nibWithNibName:NIB_INFORMATION bundle:nil];
            break;
            
        case 1:
            return [UINib nibWithNibName:NIB_COLLECTION bundle:nil];
            break;
            
        case 2:
            return [UINib nibWithNibName:NIB_DESCRIPTION bundle:nil];
            break;
            
        case 3:
            return [UINib nibWithNibName:NIB_MAP bundle:nil];
            break;
            
        case 4:
            return [UINib nibWithNibName:NIB_COMMENT bundle:nil];
            break;
            
        default:
            break;
    }
    
    return nil;
}

+ (CGFloat)getHeight:(PlaceDetailCellType)cellType {
    switch (cellType) {
        case 0:
            return HEIGHT_INFORMATION;
            break;
            
        case 1:
            return HEIGHT_COLLECTION;
            break;
            
        case 2:
            return HEIGHT_DESCRIPTION;
            break;
            
        case 3:
            return HEIGHT_MAP;
            break;
            
        case 4:
            return HEIGHT_COMMENT;
            break;
            
        default:
            break;
    }
    
    return 0;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    [self.placeCollectionCell registerClass:[UICollectionViewCell class]
                 forCellWithReuseIdentifier:@"CustomCollectionCellIdentifier"];
    self.placeCollectionCell.delegate = self;
    self.placeCollectionCell.dataSource = self;
}

- (void)prepareForReuse {
   
    
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
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CustomCollectionCellIdentifier" forIndexPath:indexPath];
    
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
