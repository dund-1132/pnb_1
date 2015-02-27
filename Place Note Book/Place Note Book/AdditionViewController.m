//
//  AdditionViewController.m
//  Place Note Book
//
//  Created by framgiavn on 2/27/15.
//  Copyright (c) 2015 framgiavn. All rights reserved.
//

#import "AdditionViewController.h"

@interface AdditionViewController ()

@end

@implementation AdditionViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView
estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

@end
