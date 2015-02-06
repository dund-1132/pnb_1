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

#define ANIMATE_DURATION    0.8f
#define CORVER_VIEW_ALPHA   0.6f

@interface HomeViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *homeTableView;
@property (weak, nonatomic) IBOutlet UIButton *downloadButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *shareButton;
@property (nonatomic, strong) UIView *coverView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerClass];
    [self addObserverNavigationBar];
    [self createCorverView];
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
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self addCoverView];
}

- (void)showNavigationBar:(NSNotification *)notification {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self removeCoverView];
}

- (void)createCorverView {
    float navigationBarOriginY = self.navigationController.navigationBar.frame.origin.y;
    float navigationBarSizeHeight = self.navigationController.navigationBar.frame.size.height;
    float coverOriginY = navigationBarOriginY + navigationBarSizeHeight;
    CGRect coverRect = CGRectMake(0, coverOriginY, self.view.frame.size.width, self.view.frame.size.height - coverOriginY);
    self.coverView = [[UIView alloc] initWithFrame:coverRect];
    [self.coverView setBackgroundColor:[UIColor blackColor]];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        CustomSearchBarCell *cell = (CustomSearchBarCell *)[tableView dequeueReusableCellWithIdentifier:[CustomSearchBarCell cellIdentifier]];
        return cell;
    } else {
        CustomPlaceCell *cell = (CustomPlaceCell *)[tableView dequeueReusableCellWithIdentifier:[CustomPlaceCell cellIdentifier]];
        return cell;
    }
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
