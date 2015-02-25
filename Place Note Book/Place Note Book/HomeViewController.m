//
//  HomeViewController.m
//  Place Note Book
//
//  Created by framgiavn on 2/5/15.
//  Copyright (c) 2015 framgiavn. All rights reserved.
//

#import "HomeViewController.h"
#import "CustomSearchBarCell.h"
#import "CustomPlaceCell.h"
#import "PlaceDetailViewController.h"
#import "ImageDownload.h"

#define ANIMATE_DURATION    0.8f
#define CORVER_VIEW_ALPHA   0.6f

@interface HomeViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *homeTableView;
@property (nonatomic, strong) UIView *coverView;
@property (nonatomic, strong) NSCache *imageCache;
@property (nonatomic, strong) UIRefreshControl *homeRefreshControl;
@property (nonatomic, strong) UIView *statusView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerClass];
    [self addObserverNavigationBar];
    [self createCorverView];
    [self addRefreshControl];
}

- (void)showSearchBar {
    NSIndexPath *firstPlaceCellIndexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    [self.homeTableView scrollToRowAtIndexPath:firstPlaceCellIndexPath
                              atScrollPosition:UITableViewScrollPositionBottom
                                      animated:YES];
}
- (IBAction)dismissHomeViewController:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)registerClass {
    [self.homeTableView registerNib:[CustomSearchBarCell getSearchBarNib]
             forCellReuseIdentifier:[CustomSearchBarCell cellIdentifier]];
    [self.homeTableView registerNib:[CustomPlaceCell getPlaceNib]
             forCellReuseIdentifier:[CustomPlaceCell cellIdentifier]];
}

- (void)addRefreshControl {
    self.homeRefreshControl = [[UIRefreshControl alloc] init];
    [self.homeRefreshControl setBackgroundColor:[UIColor whiteColor]];
    [self.homeRefreshControl setTintColor:[UIColor groupTableViewBackgroundColor]];
    [self.homeRefreshControl addTarget:self
                                action:@selector(updatePlaces)
                      forControlEvents:UIControlEventValueChanged];
    [self.homeTableView addSubview:self.homeRefreshControl];
}

#pragma mark - refresh control
- (void)updatePlaces {
    
    //[self reloadHomeTableView];
}

#pragma mark - show/hide navigation bar
- (void)addObserverNavigationBar {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(hideNavigationBar:)
                                                 name:@"HideNavigationBar"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(showNavigationBar:)
                                                 name:@"ShowNavigationBar"
                                               object:nil];
}

- (void)hideNavigationBar:(NSNotification *)notification {
    if (!self.statusView) {
        CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
        self.statusView = [[UIView alloc] initWithFrame:statusBarFrame];
        UIColor *statusColor = [UIColor colorWithRed:10/255.0
                                               green:183/255.0
                                                blue:128/255.0
                                               alpha:1.0];
        [self.statusView setBackgroundColor:statusColor];
    }
    [self.view addSubview:self.statusView];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self addCoverView];
}

- (void)showNavigationBar:(NSNotification *)notification {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    if (self.statusView) {
        [self.statusView removeFromSuperview];
    }
    [self removeCoverView];
}

- (void)createCorverView {
    float navigationBarOriginY = self.navigationController.navigationBar.frame.origin.y;
    float navigationBarSizeHeight = self.navigationController.navigationBar.frame.size.height;
    float coverOriginY = navigationBarOriginY + navigationBarSizeHeight;
    CGRect coverRect = CGRectMake(0,
                                  coverOriginY,
                                  self.view.frame.size.width,
                                  self.view.frame.size.height - coverOriginY);
    self.coverView = [[UIView alloc] initWithFrame:coverRect];
    [self.coverView setBackgroundColor:[UIColor blackColor]];
    UITapGestureRecognizer *tapToCoverViewGesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(cancelSearch)];
    [self.coverView addGestureRecognizer:tapToCoverViewGesture];
}

- (void)cancelSearch {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TouchCoverView"
                                                        object:nil];
}

- (void)addCoverView {
    [UIView animateWithDuration:ANIMATE_DURATION animations:^{
        [self.coverView setAlpha:CORVER_VIEW_ALPHA];
    } completion:^(BOOL finished){
        [self.view addSubview:self.coverView];
    }];
}

- (void)removeCoverView {
    [self.coverView removeFromSuperview];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSIndexPath *firstPlaceCellIndexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    [self.homeTableView scrollToRowAtIndexPath:firstPlaceCellIndexPath
                              atScrollPosition:UITableViewScrollPositionTop
                                      animated:NO];
}

#pragma mark - TableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return [CustomSearchBarCell getHeight];
    }
    
    return [CustomPlaceCell getHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        NSString *identifier = [CustomSearchBarCell cellIdentifier];
        CustomSearchBarCell *cell =
        (CustomSearchBarCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
        
        return cell;
    } else {
        NSString *identifier = [CustomPlaceCell cellIdentifier];
        CustomPlaceCell *cell =
        (CustomPlaceCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
        NSString *urlString = @"https://cdn4.iconfinder.com/data/icons/gnome-desktop-icons-png/PNG/64/Dialog-Apply-64.png";
        [ImageDownload downloadImageFromURL:urlString andUpdateTo:[cell getIconImageView]];
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
     [self performSegueWithIdentifier:@"pushToDetailViewController"
                               sender:[self.homeTableView cellForRowAtIndexPath:indexPath]];
}

- (void)reloadHomeTableView {
    [self.homeTableView reloadData];
    if (self.homeRefreshControl) {
        
        [self.homeRefreshControl endRefreshing];
    }
}

#define OFFSET_LOAD 100
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    CGFloat currentOffset = scrollView.contentOffset.y;
    CGFloat maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;
    NSInteger offset = currentOffset - maximumOffset;
    if (offset > OFFSET_LOAD) {
        [self loadMorePlaces];
    }
}

- (void)loadMorePlaces {
    
    [self reloadHomeTableView];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"pushToDetailViewController"]) {
        NSLog(@"%@", sender);
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
