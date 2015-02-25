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
#import "ModelManager.h"
#import "LoginViewController.h"

#define DISTANCE 70

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
@property (weak, nonatomic) IBOutlet UIView *backgroundView;

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
    [self setShadowForView:self.backgroundView];
    [self makeUp];
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

- (void)setShadowForView:(UIView *)shadowView {
    [shadowView.layer setShadowColor:[UIColor lightGrayColor].CGColor];
    [shadowView.layer setShadowOpacity:0.5];
    [shadowView.layer setShadowRadius:4.0];
    [shadowView.layer setShadowOffset:CGSizeMake(1.0, 2.0)];
}

- (void)makeUp {
    [self makeUpTextField:self.userNameTextField];
    [self makeUpTextField:self.emailTextField];
    [self makeUpTextField:self.passwordTextField];
    [self makeUpTextField:self.confirmPasswordTextField];
    [self makeButton:self.signUpButton];
}

- (void)makeUpTextField:(UITextField *)textField {
    textField.layer.borderColor = [UIColor colorWithRed:192.0/255
                                                  green:192.0/255
                                                   blue:192.0/255
                                                  alpha:1.0].CGColor;
    textField.layer.borderWidth = 0.5f;
}

- (void)makeButton:(UIButton *)button {
    button.layer.cornerRadius = 4.0f;
}

- (void)setContentSizeScrollView:(NSNotification *)notification onKeyboard:(BOOL)isShow {
    NSDictionary *keyboardInfo = [notification userInfo];
    NSValue *keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    float heightKeyboard = keyboardFrameBeginRect.size.height;
    
    float signUpOriginY = self.signUpButton.frame.origin.y + self.backgroundView.frame.origin.y;
    float signUpHeight = self.signUpButton.frame.size.height + self.backgroundView.frame.size.height;
    float signUpButtonYPosition = signUpOriginY + signUpHeight;
    float heightScrollView = 0.0f;
    if (signUpButtonYPosition > (self.view.frame.size.height - heightKeyboard)) {
        if (isShow) {
            heightScrollView = signUpButtonYPosition + heightKeyboard;
        }
    }
    CGSize size = CGSizeMake(self.signUpScrollView.frame.size.width, heightScrollView);
    [self.signUpScrollView setContentSize:size];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    float originY = self.backgroundView.frame.origin.y + textField.frame.origin.y;
    CGPoint scrollPoint = CGPointMake(0,
                                      originY - self.signUpScrollView.contentInset.top - DISTANCE);
    [self.signUpScrollView setContentOffset:scrollPoint animated:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self.signUpScrollView setContentOffset:CGPointZero animated:YES];
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
        self.notifyString = @"--> Invalid user name";
        return NO;
    }
    if (![self.emailTextField isValidate]) {
        self.notifyString = @"--> Invalidate email";
        return NO;
    }
    if (![self.passwordTextField isValidate]) {
        self.notifyString = @"--> Invalidate password";
        return NO;
    }
    if (![self.confirmPasswordTextField isValidate]) {
        self.notifyString = @"--> Invalidate confirm password";
        return NO;
    }
    if (![[self.passwordTextField text] isEqualToString:[self.confirmPasswordTextField text]]) {
        self.notifyString = @"--> Verify password and confirm password";
        return NO;
    }
    self.notifyString = @"Creating account";
    
    return YES;
}

#define ACCOUNT_FORMAT @"(account_email == '%@')"
- (IBAction)touchUpInsideSignUp:(UIButton *)sender {
    if ([self isValidateSignUpForm]) {
        [self.activityIndicatior startAnimating];
        NSString *userName = [self.userNameTextField text];
        NSString *email = [self.emailTextField text];
        NSString *password = [self.passwordTextField text];
        NSString *predicate =
        [NSString stringWithFormat:ACCOUNT_FORMAT, email];
        if ([[ModelManager shareModelManager] isExistRecordIn:TableAccount
                                           andPredicateFormat:predicate]) {
            [self.notifyLabel setTextColor:[UIColor blackColor]];
            [self.notifyLabel setText:@"Fail, account exist"];
        } else {
            NSDictionary *account = @{
                                      @"account_user_name" : userName,
                                      @"account_email" : email,
                                      @"account_password" : password
                                      };
            [[ModelManager shareModelManager] insertAccount:account];
            [self performSegueWithIdentifier:@"signUpPushToLogin" sender:self];
        }
    } else {
        [self.notifyLabel setTextColor:[UIColor blackColor]];
        [self.notifyLabel setText:self.notifyString];
    }
    [self.activityIndicatior stopAnimating];
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
