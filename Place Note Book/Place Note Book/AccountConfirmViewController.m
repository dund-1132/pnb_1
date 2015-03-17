//
//  AccountConfirmViewController.m
//  Place Note Book
//
//  Created by Ngo Dac Du on 3/7/15.
//  Copyright (c) 2015 ngodacdu. All rights reserved.
//

#import "AccountConfirmViewController.h"
#import "PlaceNoteBookStandard.h"
#import "ValidateTextField.h"
#import "PFModelUser.h"
#import "CustomInputAccessoryView.h"
#import "PFUserManager.h"
#import "CustomSignUpButton.h"

@interface AccountConfirmViewController () <CustomInputAccessoryViewDelegate, PFUserManagerDelegate>

@property (weak, nonatomic) IBOutlet ValidateTextField *emailTextField;
@property (weak, nonatomic) IBOutlet ValidateTextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIView *formView;
@property (weak, nonatomic) IBOutlet CustomSignUpButton *verifyButton;


@end

@implementation AccountConfirmViewController

// custom input accessory view -> keyboard
- (UIView *)inputAccessoryView {
    CustomInputAccessoryView *customAccessoryView = [CustomInputAccessoryView instanceFromNibFile];
    customAccessoryView.delegate = self;
    
    return customAccessoryView;
}

- (void)inputAccessoryViewPreviousButtonDidClick {
    if ([self.passwordTextField isFirstResponder]) {
        [self.emailTextField becomeFirstResponder];
    }
}

- (void)inputAccessoryViewNextButtonDidClick {
    if ([self.emailTextField isFirstResponder]) {
        [self.passwordTextField becomeFirstResponder];
    }
}

- (void)inputAccessoryViewDoneButtonDidClick {
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [PFUserManager sharePFUserManager].delegate = self;
    [self addObserverKeyboard];
    [self makeUp];
    [self.emailTextField setRegularExpression:ValidateEmail];
    [self.passwordTextField setRegularExpression:ValidatePassword];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)verifyViewController:(id)sender {
    if ([self.emailTextField isValidate]
        && [self.passwordTextField isValidate]) {
        
        NSString *email = [PFModelUser sharePFModelUser].email;
        NSString *password = [PFModelUser sharePFModelUser].password;
        [[PFUserManager sharePFUserManager] isExistAccount:email
                                                password:password];
    }
}

- (void)PFUserManager:(PFUserManager *)userManager didCheckExist:(BOOL)successed {
    if (successed) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sign up fail"
                                                            message:@"Account exist"
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
    } else {
        NSString *email = [PFModelUser sharePFModelUser].email;
        NSString *password = [PFModelUser sharePFModelUser].password;
        NSString *confirmEmail = [self.emailTextField text];
        NSString *confirmPassword = [self.passwordTextField text];
        if ([email isEqualToString:confirmEmail]
            && [password isEqualToString:confirmPassword]) {
            [PFModelUser sharePFModelUser].userName = [PFModelUser sharePFModelUser].email;
            [PFModelUser sharePFModelUser].position = @"user position";
            [PFModelUser sharePFModelUser].phone = @"phone number";
            [PFModelUser sharePFModelUser].note = @"";
            [PFModelUser sharePFModelUser].status = @"";
            [[PFUserManager sharePFUserManager] signUp:[PFModelUser sharePFModelUser]];
        } else {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Fail"
                                                                message:@"Please check information"
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
}

- (void)PFUserManager:(PFUserManager *)userManager didSignUp:(BOOL)successed {
    if (successed) {
        [self performSegueWithIdentifier:@"VerifyToTabBarController"
                                  sender:self];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sign up fail"
                                                            message:@"Please check information"
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"VerifyToTabBarController"]) {
        
    }
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
        float loginYOrigin = self.verifyButton.frame.origin.y;
        float loginHeight = self.verifyButton.frame.size.height;
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

- (void)goBackViewController {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#define mark - make up UI
- (void)makeUp {
    self.formView.layer.cornerRadius = [PlaceNoteBookStandard cornerRadius];
    [ValidateTextField roundCornersOnView:self.formView
                                onTopLeft:YES
                                 topRight:YES
                               bottomLeft:YES
                              bottomRight:YES
                                   radius:[PlaceNoteBookStandard cornerRadius]];
    [self.emailTextField clearBorder];
    [self.passwordTextField clearBorder];
}

@end
