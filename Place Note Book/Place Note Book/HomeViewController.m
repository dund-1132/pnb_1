//
//  HomeViewController.m
//  Place Note Book
//
//  Created by framgiavn on 2/5/15.
//  Copyright (c) 2015 framgiavn. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *homeTableView;
@property (weak, nonatomic) IBOutlet UIButton *downloadButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *shareButton;


@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - TableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 44;
    }
    
    return 250;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *customCellIdentifier = [NSString stringWithFormat:@"Cell-%ld-%ld", (long)indexPath.section, (long)indexPath.row];
    UITableViewCell *cell = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:customCellIdentifier];
    if (!cell) {
        if (indexPath.row == 0) {
            cell = (UITableViewCell *)[[[NSBundle mainBundle] loadNibNamed:@"PlaceCell" owner:self options:nil] firstObject];
        } else {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"PlaceCell" owner:self options:nil] lastObject];
        }
    }
    
    return cell;
}

- (IBAction)touchToDownload:(UIButton *)sender {
    NSLog(@"Touch to download");
}

- (IBAction)touchToShare:(UIBarButtonItem *)sender {
    NSLog(@"Touch to share");
}

@end
