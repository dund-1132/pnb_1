//
//  GenderEnterViewController.m
//  Place Note Book
//
//  Created by Ngo Dac Du on 3/7/15.
//  Copyright (c) 2015 ngodacdu. All rights reserved.
//

#import "GenderEnterViewController.h"
#import "PFModelUser.h"

@interface GenderEnterViewController ()


@end

@implementation GenderEnterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)femaleGoToConfirmViewController:(id)sender {
    [self performSegueWithIdentifier:@"GenderToVerifyController"
                              sender:self];
}

- (IBAction)maleGoToConfirmViewController:(id)sender {
    [self performSegueWithIdentifier:@"GenderToVerifyController"
                              sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"GenderToVerifyController"]) {
        [PFModelUser sharePFModelUser].gender = @"Female";
    }
    if ([segue.identifier isEqualToString:@"GenderToVerifyController"]) {
        [PFModelUser sharePFModelUser].gender = @"Male";
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
