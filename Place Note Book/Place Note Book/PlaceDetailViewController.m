//
//  PlaceDetailViewController.m
//  Place Note Book
//
//  Created by Ngo Dac Du on 3/10/15.
//  Copyright (c) 2015 ngodacdu. All rights reserved.
//

#import "PlaceDetailViewController.h"
#import "ImageDownload.h"
#import "PageImageView.h"
#import <MapKit/MapKit.h>

@interface PlaceDetailViewController () <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *imageDate;
@property (weak, nonatomic) IBOutlet UIView *rateView;
@property (weak, nonatomic) IBOutlet UILabel *placeName;
@property (weak, nonatomic) IBOutlet UILabel *placeAddress;
@property (weak, nonatomic) IBOutlet UIButton *likeCount;
@property (weak, nonatomic) IBOutlet UIButton *imageCount;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIImageView *iconNearPlace;
@property (weak, nonatomic) IBOutlet UIButton *nearPlaceButton;
@property (weak, nonatomic) IBOutlet UILabel *rate;
@property (weak, nonatomic) IBOutlet UITableViewCell *imageCell;

@end

@implementation PlaceDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.mapView setDelegate:self];
    self.rateView.layer.cornerRadius = self.rateView.frame.size.width / 2;
    [self.imageCell.layer setMasksToBounds:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self refreshPlaceInformation];
}

- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView {
    PFGeoPoint *point = self.object[@"location"];
    CLLocationCoordinate2D location = CLLocationCoordinate2DMake(point.latitude, point.longitude);
    [mapView setCenterCoordinate:location animated:YES];
}

- (void)refreshPlaceInformation {
    [self.imageDate setText:self.object[@"createAt"]];
    [self.rate setText:self.object[@"rating"]];
    [self.placeName setText:self.object[@"name"]];
    [self.placeAddress setText:self.object[@"address"]];
    NSString *url = @"https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcTZcL18Rnwrx3WqvGtkNFuDvVOWULfwX11K3NBj65uXMYmp9fJVUw";
    [ImageDownload downloadImageFromURL:url
                            andUpdateTo:self.imageView];
    self.imageDate.layer.zPosition = 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)likeDidClick:(id)sender {
    
}

- (IBAction)checkInDidClick:(id)sender {
    
}

- (IBAction)shareDidClick:(id)sender {
    
}

- (IBAction)saveDidClick:(id)sender {
    
}

- (IBAction)likeCountDidClick:(id)sender {
    
}

- (IBAction)imageCountDidClick:(id)sender {
    
}

- (IBAction)nearPlaceDidClick:(id)sender {

}

#pragma mark - table view delegate
- (void)        tableView:(UITableView *)tableView
  didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ((indexPath.section == 1) && (indexPath.row == 1)) {
//        [[PageImageView sharePageImageView] showPageImageView];
//        UIImage *image = self.placeImageView.image;
//        [[PageImageView sharePageImageView] updateImage:image];
    }
}

@end
