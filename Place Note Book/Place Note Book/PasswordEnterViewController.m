//
//  PasswordEnterViewController.m
//  Place Note Book
//
//  Created by Ngo Dac Du on 3/7/15.
//  Copyright (c) 2015 ngodacdu. All rights reserved.
//

#import "PasswordEnterViewController.h"
#import "ValidateTextField.h"
#import "PFModelUser.h"

@interface PasswordEnterViewController ()

@property (weak, nonatomic) IBOutlet UIButton *continueButton;
@property (weak, nonatomic) IBOutlet ValidateTextField *passwordTextField;

@end

@implementation PasswordEnterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addObserverKeyboard];
    [self.passwordTextField setRegularExpression:ValidatePassword];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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

#define ANIMATION   1.0
#define ACCESSORY_HEIGHT    40
- (void)onKeyboardShow:(NSNotification *)notification {
    NSDictionary *keyboardInfo = [notification userInfo];
    NSValue *keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    [UIView animateWithDuration:ANIMATION animations:^{
        CGRect currentRect = [[UIScreen mainScreen] bounds];
        float loginYOrigin = self.continueButton.frame.origin.y;
        float loginHeight = self.continueButton.frame.size.height;
        float keyboardHeight = keyboardFrameBeginRect.size.height - ACCESSORY_HEIGHT;
        float moveDistance = loginYOrigin + loginHeight - keyboardHeight;
        currentRect.origin.y = currentRect.origin.y - moveDistance;
        [self.view setFrame:currentRect];
    }];
}

- (void)onKeyboardHide:(NSNotification *)notification {
    [UIView animateWithDuration:ANIMATION
                     animations:^{
                         [self.view setFrame:[[UIScreen mainScreen] bounds]];
                     }];
}

- (IBAction)gotoGenderViewController:(id)sender {
    if ([self.passwordTextField isValidate]) {
        [self performSegueWithIdentifier:@"PasswordToGenderViewController"
                                  sender:self];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"PasswordToGenderViewController"]) {
        [PFModelUser sharePFModelUser].password = [self.passwordTextField text];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
