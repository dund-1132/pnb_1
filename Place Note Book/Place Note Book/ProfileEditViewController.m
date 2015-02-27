//
//  ProfileEditViewController.m
//  Place Note Book
//
//  Created by framgiavn on 2/27/15.
//  Copyright (c) 2015 framgiavn. All rights reserved.
//

#import "ProfileEditViewController.h"

@interface ProfileEditViewController () <UITextFieldDelegate, UITextViewDelegate>

@end

@implementation ProfileEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismissProfileEditViewController:(id)sender {
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textView:(UITextView *)textView
shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text {
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
    }
    return YES;
}

@end
