//
//  LoginViewController.m
//  Place Note Book
//
//  Created by framgiavn on 2/2/15.
//  Copyright (c) 2015 framgiavn. All rights reserved.
//

#import "LoginViewController.h"
#import "CustomInputAccessoryView.h"
#import "ValidateTextField.h"

NSString *const kUserNameValidateExpression = @"^[a-zA-Z0-9]+([a-zA-Z0-9](_|-| )[a-zA-Z0-9])*[a-zA-Z0-9]+$";
NSString *const kEmailValidateExpression = @"^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}$";
NSString *const kPasswordValidateExpression = @"^[a-zA-Z0-9]{5,11}$";

@interface LoginViewController () <CustomInputAccessoryViewDelegate>

@property (weak, nonatomic) IBOutlet ValidateTextField *userNameTextField;
@property (weak, nonatomic) IBOutlet ValidateTextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIScrollView *loginScrollView;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addObserverKeyboard];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (UIView *)inputAccessoryView {
    CustomInputAccessoryView *customAccessoryView = [CustomInputAccessoryView instanceFromNibFile];
    customAccessoryView.delegate = self;
    
    return customAccessoryView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self clearTextField];
}

- (void)clearTextField {
    [self.userNameTextField setText:nil];
    [self.passwordTextField setText:nil];
    [self.userNameTextField becomeFirstResponder];
    [self.view endEditing:YES];
    [self.loginButton setUserInteractionEnabled:NO];
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
                                             selector:@selector(validateLoginForm:)
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
    float signUpButtonYPosition = self.loginButton.frame.origin.y + self.loginButton.frame.size.height;
    float heightScrollView = 0.0f;
    if (signUpButtonYPosition > (self.view.frame.size.height - heightKeyboard)) {
        if (isShow) {
            heightScrollView = signUpButtonYPosition + heightKeyboard;
        }
    }
    CGSize size = CGSizeMake(self.loginScrollView.frame.size.width, heightScrollView);
    [self.loginScrollView setContentSize:size];
}

- (void)validateLoginForm:(NSNotification *)notification {
    if ([self.userNameTextField isValidate] && [self.passwordTextField isValidate]) {
        [self.loginButton setUserInteractionEnabled:YES];
    } else {
        [self.loginButton setUserInteractionEnabled:NO];
    }
}

- (IBAction)touchUpInsideLogin:(id)sender {
    
}

#pragma mark - customAccessoryView Delegate
- (void)inputAccessoryViewPreviousButtonDidClick {
    if ([self.passwordTextField resignFirstResponder]) {
        [self.userNameTextField becomeFirstResponder];
    }
}

- (void)inputAccessoryViewNextButtonDidClick {
    if ([self.userNameTextField resignFirstResponder]) {
        [self.passwordTextField becomeFirstResponder];
    }
}

- (void)inputAccessoryViewDoneButtonDidClick {
    [self.view endEditing:YES];
}

- (IBAction)dismissLoginViewController:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
