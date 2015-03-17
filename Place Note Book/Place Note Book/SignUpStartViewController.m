//
//  SignUpViewController.m
//  Place Note Book
//
//  Created by Ngo Dac Du on 3/7/15.
//  Copyright (c) 2015 ngodacdu. All rights reserved.
//

#import "SignUpStartViewController.h"
#import "EmailEnterViewController.h"
#import "NameEnterViewController.h"
#import "PFModelUser.h"

@interface SignUpStartViewController ()

@end

@implementation SignUpStartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES
                                             animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)gotoEmailViewController:(id)sender {
    [self performSegueWithIdentifier:@"GetStartToEmailViewController"
                              sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"GetStartToEmailViewController"]) {
        [PFModelUser sharePFModelUser];
    }
}

- (void)dismissSignUpStartViewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
