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

NSString *const kUserNameValidateExpression = @"^[a-zA-Z0-9]+([a-zA-Z0-9](_|-| )[a-zA-Z0-9])*[a-zA-Z0-9]+$";
NSString *const kEmailValidateExpression = @"^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}$";
NSString *const kPasswordValidateExpression = @"^[a-zA-Z0-9]{5,11}$";

@interface SignUpViewController () <UITextFieldDelegate, CustomInputAccessoryViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet ValidateTextField *userNameTextField;
@property (weak, nonatomic) IBOutlet ValidateTextField *emailTextField;
@property (weak, nonatomic) IBOutlet ValidateTextField *passwordTextField;
@property (weak, nonatomic) IBOutlet ValidateTextField *confirmPasswordTextField;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;
@property (weak, nonatomic) IBOutlet UIScrollView *signUpScrollView;

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
    [self.userNameTextField setRegularExpression:kUserNameValidateExpression];
    [self.emailTextField setRegularExpression:kEmailValidateExpression];
    [self.passwordTextField setRegularExpression:kPasswordValidateExpression];
    [self.confirmPasswordTextField setRegularExpression:kPasswordValidateExpression];
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
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(validateSignUpForm:)
                                                 name:@"EnableButton"
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

- (void)validateSignUpForm:(NSNotification *)notification {
    if ([self.userNameTextField isValidate]
        && [self.emailTextField isValidate]
        && [self.passwordTextField isValidate]
        && [self.confirmPasswordTextField isValidate]
        && [[self.passwordTextField text] isEqualToString:[self.confirmPasswordTextField text]]) {
        
        [self.signUpButton setUserInteractionEnabled:YES];
    } else {
        [self.signUpButton setUserInteractionEnabled:NO];
    }
}

- (IBAction)touchUpInsideSignUp:(UIButton *)sender {
    NSLog(@"Touch Up inside sign up button");
}

#pragma mark - customAccessoryView Delegate
- (void)inputAccessoryViewNextButtonDidClick {
    if ([self.userNameTextField resignFirstResponder]) {
        [self.emailTextField becomeFirstResponder];
    } else if ([self.emailTextField resignFirstResponder]) {
        [self.passwordTextField becomeFirstResponder];
    } else if ([self.passwordTextField resignFirstResponder]) {
        [self.confirmPasswordTextField becomeFirstResponder];
    }
}

- (void)inputAccessoryViewPreviousButtonDidClick {
    if ([self.emailTextField resignFirstResponder]) {
        [self.userNameTextField becomeFirstResponder];
    } else if ([self.passwordTextField resignFirstResponder]) {
        [self.emailTextField becomeFirstResponder];
    } else if ([self.confirmPasswordTextField resignFirstResponder]) {
        [self.passwordTextField becomeFirstResponder];
    }
}

- (void)inputAccessoryViewDoneButtonDidClick {
    [self.view endEditing:YES];
}

- (IBAction)dismissSignUpViewController:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
