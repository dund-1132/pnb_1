//
//  SignUpViewController.m
//  Place Note Book
//
//  Created by framgiavn on 2/2/15.
//  Copyright (c) 2015 framgiavn. All rights reserved.
//

#import "SignUpViewController.h"
#import "CustomInputAccessoryView.h"
#import "ValidateTextField.h"

@interface SignUpViewController () <UITextFieldDelegate, CustomInputAccessoryViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet ValidateTextField *userNameTextField;
@property (weak, nonatomic) IBOutlet ValidateTextField *emailTextField;
@property (weak, nonatomic) IBOutlet ValidateTextField *passwordTextField;
@property (weak, nonatomic) IBOutlet ValidateTextField *confirmPasswordTextField;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;
@property (weak, nonatomic) IBOutlet UIScrollView *signUpScrollView;
@property (weak, nonatomic) IBOutlet UILabel *notifyLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatior;
@property (nonatomic, strong) NSString *notifyString;

@end

@implementation SignUpViewController

- (UIView *)inputAccessoryView {
    CustomInputAccessoryView *customAccessoryView = [CustomInputAccessoryView instanceFromNibFile];
    customAccessoryView.delegate = self;
    
    return customAccessoryView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addObserverKeyboard];
    [self setValidateExpression];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - set validate expression
- (void)setValidateExpression {
    [self.userNameTextField setRegularExpression:ValidateUserName];
    [self.emailTextField setRegularExpression:ValidateEmail];
    [self.passwordTextField setRegularExpression:ValidatePassword];
    [self.confirmPasswordTextField setRegularExpression:ValidatePassword];
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
    [self setContentSizeScrollView:notification onKeyboard:YES];
}

- (void)onKeyboardHide:(NSNotification *)notification {
    [self setContentSizeScrollView:notification onKeyboard:NO];
}

- (void)setContentSizeScrollView:(NSNotification *)notification onKeyboard:(BOOL)isShow {
    NSDictionary *keyboardInfo = [notification userInfo];
    NSValue *keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    float heightKeyboard = keyboardFrameBeginRect.size.height;
    float signUpButtonYPosition = self.signUpButton.frame.origin.y + self.signUpButton.frame.size.height;
    float heightScrollView = 0.0f;
    if (signUpButtonYPosition > (self.view.frame.size.height - heightKeyboard)) {
        if (isShow) {
            heightScrollView = signUpButtonYPosition + heightKeyboard;
        }
    }
    CGSize size = CGSizeMake(self.signUpScrollView.frame.size.width, heightScrollView);
    [self.signUpScrollView setContentSize:size];
}

- (IBAction)tapToScrollView:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return NO;
}

- (BOOL)isValidateSignUpForm {
    if (![self.userNameTextField isValidate]) {
        self.notifyString = @"Invalid user name";
        return NO;
    }
    if (![self.emailTextField isValidate]) {
        self.notifyString = @"Invalidate email";
        return NO;
    }
    if (![self.passwordTextField isValidate]) {
        self.notifyString = @"Invalidate password";
        return NO;
    }
    if (![self.confirmPasswordTextField isValidate]) {
        self.notifyString = @"Invalidate confirm password";
        return NO;
    }
    if (![[self.passwordTextField text] isEqualToString:[self.confirmPasswordTextField text]]) {
        self.notifyString = @"Verify password and confirm password";
        return NO;
    }
    self.notifyString = @"Creating account";
    
    return YES;
}

- (IBAction)touchUpInsideSignUp:(UIButton *)sender {
    if ([self isValidateSignUpForm]) {
        [self.activityIndicatior startAnimating];
        [self.notifyLabel setTextColor:[UIColor blackColor]];
    } else {
        [self.activityIndicatior stopAnimating];
    }
    [self.notifyLabel setText:self.notifyString];
}

#pragma mark - customAccessoryView Delegate
- (void)inputAccessoryViewNextButtonDidClick {
    if ([self.userNameTextField isFirstResponder]) {
        [self.emailTextField becomeFirstResponder];
    } else if ([self.emailTextField isFirstResponder]) {
        [self.passwordTextField becomeFirstResponder];
    } else if ([self.passwordTextField isFirstResponder]) {
        [self.confirmPasswordTextField becomeFirstResponder];
    }
}

- (void)inputAccessoryViewPreviousButtonDidClick {
    if ([self.emailTextField isFirstResponder]) {
        [self.userNameTextField becomeFirstResponder];
    } else if ([self.passwordTextField isFirstResponder]) {
        [self.emailTextField becomeFirstResponder];
    } else if ([self.confirmPasswordTextField isFirstResponder]) {
        [self.passwordTextField becomeFirstResponder];
    }
}

- (void)inputAccessoryViewDoneButtonDidClick {
    [self.view endEditing:YES];
}

- (IBAction)dismissSignUpViewController:(id)sender {
    [UIView animateWithDuration:0.2f animations:^{
        [self.view endEditing:YES];
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
