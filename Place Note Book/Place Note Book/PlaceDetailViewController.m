//
//  PlaceDetailViewController.m
//  Place Note Book
//
//  Created by framgiavn on 2/9/15.
//  Copyright (c) 2015 framgiavn. All rights reserved.
//

#import "PlaceDetailViewController.h"
#import "CustomPlaceDetailCell.h"

@interface PlaceDetailViewController () <UIActionSheetDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) UIButton *downloadButton;
@property (nonatomic) UIBarButtonItem *shareButton;
@property (weak, nonatomic) IBOutlet UITableView *placeDetailTableView;

@end

@implementation PlaceDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addObserverKeyboard];
    [self registerClass];
}

- (void)registerClass {
    [self.placeDetailTableView registerNib:[CustomPlaceDetailCell getNib:PlaceDetailCellInforation]
                    forCellReuseIdentifier:[CustomPlaceDetailCell getCellIdentifier:PlaceDetailCellInforation]];
    [self.placeDetailTableView registerNib:[CustomPlaceDetailCell getNib:PlaceDetailCellCollection]
                    forCellReuseIdentifier:[CustomPlaceDetailCell getCellIdentifier:PlaceDetailCellCollection]];
    [self.placeDetailTableView registerNib:[CustomPlaceDetailCell getNib:PlaceDetailCellDescription]
                    forCellReuseIdentifier:[CustomPlaceDetailCell getCellIdentifier:PlaceDetailCellDescription]];
    [self.placeDetailTableView registerNib:[CustomPlaceDetailCell getNib:PlaceDetailCellMap]
                    forCellReuseIdentifier:[CustomPlaceDetailCell getCellIdentifier:PlaceDetailCellMap]];
    [self.placeDetailTableView registerNib:[CustomPlaceDetailCell getNib:PlaceDetailCellComment]
                    forCellReuseIdentifier:[CustomPlaceDetailCell getCellIdentifier:PlaceDetailCellComment]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self addDownloadButton];
    [self addShareButton];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.downloadButton removeFromSuperview];
}

#pragma mark - option
- (void)addDownloadButton {
    if (!self.downloadButton) {
        self.downloadButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    }
    [self.downloadButton setFrame:CGRectMake(0, 0, 100, 44)];
    [self.downloadButton setCenter:CGPointMake(self.navigationController.navigationBar.center.x, self.downloadButton.center.y)];
    [self.navigationController.navigationBar addSubview:self.downloadButton];
    [self.downloadButton addTarget:self
                       action:@selector(downloadButtonDidClick)
             forControlEvents:UIControlEventTouchUpInside];
    [self.downloadButton setTitle:@"Download" forState:UIControlStateNormal];
}

- (void)addShareButton {
    if (!self.shareButton) {
        self.shareButton = [[UIBarButtonItem alloc] initWithTitle:@"Share"
                                                            style:UIBarButtonItemStyleDone
                                                           target:self
                                                           action:@selector(shareButtonDidClick)];
    }
    self.navigationItem.rightBarButtonItem = self.shareButton;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            // facebook button
            break;
        case 1:
            // cancel
            
            break;
            
        default:
            break;
    }
}

- (void)downloadButtonDidClick {
    
}

- (void)shareButtonDidClick {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Share with facebook"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Facebook", nil];
    [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
}

#pragma mark - handle show/hide keyboard
- (void)addObserverKeyboard {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onKeyboardShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onKeyboardHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)onKeyboardShow:(NSNotification *)notification {
    NSDictionary *keyboardInfo = [notification userInfo];
    NSValue *keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    CGRect rect = self.placeDetailTableView.frame;
    rect.size.height = rect.size.height - keyboardFrameBeginRect.size.height;
    [self.placeDetailTableView setFrame:rect];
}

- (void)onKeyboardHide:(NSNotification *)notification {
    [self.placeDetailTableView setFrame:self.view.bounds];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - table view delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return [CustomPlaceDetailCell getHeight:PlaceDetailCellInforation];
            break;
            
        case 1:
            return [CustomPlaceDetailCell getHeight:PlaceDetailCellCollection];
            break;
            
        case 2:
            return [CustomPlaceDetailCell getHeight:PlaceDetailCellDescription];
            break;
            
        case 3:
            return [CustomPlaceDetailCell getHeight:PlaceDetailCellMap];
            break;
            
        case 4:
            return [CustomPlaceDetailCell getHeight:PlaceDetailCellComment];
            break;
            
        default:
            break;
    }
    
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"Infomation";
            break;
        case 1:
            return @"Image";
            break;
        case 2:
            return @"Description";
            break;
        case 3:
            return @"Map";
            break;
        case 4:
            return @"Comment";
            break;
        default:
            break;
    }
    
    return @"";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        CustomPlaceDetailCell *cell =
        (CustomPlaceDetailCell *)[tableView dequeueReusableCellWithIdentifier:[CustomPlaceDetailCell getCellIdentifier:PlaceDetailCellInforation]];
        return cell;
    } else if (indexPath.section == 1) {
        CustomPlaceDetailCell *cell =
        (CustomPlaceDetailCell *)[tableView dequeueReusableCellWithIdentifier:[CustomPlaceDetailCell getCellIdentifier:PlaceDetailCellCollection]];
        return cell;
    } else if (indexPath.section == 2) {
        CustomPlaceDetailCell *cell =
        (CustomPlaceDetailCell *)[tableView dequeueReusableCellWithIdentifier:[CustomPlaceDetailCell getCellIdentifier:PlaceDetailCellDescription]];
        return cell;
    } else if (indexPath.section == 3) {
        CustomPlaceDetailCell *cell =
        (CustomPlaceDetailCell *)[tableView dequeueReusableCellWithIdentifier:[CustomPlaceDetailCell getCellIdentifier:PlaceDetailCellMap]];
        return cell;
    } else {
        CustomPlaceDetailCell *cell =
        (CustomPlaceDetailCell *)[tableView dequeueReusableCellWithIdentifier:[CustomPlaceDetailCell getCellIdentifier:PlaceDetailCellComment]];
        return cell;
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
