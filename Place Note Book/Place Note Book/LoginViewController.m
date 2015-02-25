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
#import "ScheduleViewController.h"
#import "PlaceListViewController.h"
#import "HomeViewController.h"
#import "AdvanceSearchViewController.h"
#import "AdditionViewController.h"
#import "JSONDownload.h"
#import "RequetsFormat.h"
#import "ModelManager.h"

@interface LoginViewController () <CustomInputAccessoryViewDelegate>

@property (weak, nonatomic) IBOutlet ValidateTextField *userNameTextField;
@property (weak, nonatomic) IBOutlet ValidateTextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIScrollView *loginScrollView;
@property (nonatomic, strong) NSString *notifyString;
@property (nonatomic) UITabBarController *placeTabBarController;
@property (weak, nonatomic) IBOutlet UIView *backgroundView;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addObserverKeyboard];
    [self setValidateExpression];
    [self setShadowForView:self.backgroundView];
    [self makeUp];
}

- (void)setShadowForView:(UIView *)shadowView {
    [shadowView.layer setShadowColor:[UIColor lightGrayColor].CGColor];
    [shadowView.layer setShadowOpacity:0.5];
    [shadowView.layer setShadowRadius:4.0];
    [shadowView.layer setShadowOffset:CGSizeMake(1.0, 2.0)];
}

- (void)makeUp {
    [self makeUpTextField:self.userNameTextField];
    [self makeUpTextField:self.passwordTextField];
    [self makeButton:self.loginButton];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setValidateExpression {
    [self.userNameTextField setRegularExpression:ValidateEmail];
    [self.passwordTextField setRegularExpression:ValidatePassword];
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
    [self.view endEditing:YES];
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
    
    float signUpOriginY = self.loginButton.frame.origin.y + self.backgroundView.frame.origin.y;
    float signUpHeight = self.loginButton.frame.size.height + self.backgroundView.frame.size.height;
    float signUpButtonYPosition = signUpOriginY + signUpHeight;
    float heightScrollView = 0.0f;
    if (signUpButtonYPosition > (self.view.frame.size.height - heightKeyboard)) {
        if (isShow) {
            heightScrollView = signUpButtonYPosition + heightKeyboard;
        }
    }
    CGSize size = CGSizeMake(self.loginScrollView.frame.size.width, heightScrollView);
    [self.loginScrollView setContentSize:size];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    float originY = self.backgroundView.frame.origin.y;
    CGPoint scrollPoint = CGPointMake(0, originY - self.loginScrollView.contentInset.top);
    [self.loginScrollView setContentOffset:scrollPoint animated:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self.loginScrollView setContentOffset:CGPointZero animated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return NO;
}

- (BOOL)isValidateLoginForm {
    if ([@"" isEqualToString:[self.userNameTextField text]]) {
        self.notifyString = @"Please enter user name";
        return NO;
    }
    if ([@"" isEqualToString:[self.passwordTextField text]]) {
        self.notifyString = @"Please enter password";
        return NO;
    }
    if (![self.userNameTextField isValidate]) {
        self.notifyString = @"Invalid user name";
        return NO;
    }
    if (![self.passwordTextField isValidate]) {
        self.notifyString = @"Invalidate password";
        return NO;
    }
    self.notifyString = @"Login";
    
    return YES;
}

#define ACCOUNT_FORMAT @"(account_email == '%@') AND (account_password == '%@')"
- (IBAction)touchUpInsideLogin:(id)sender {
    BOOL isValidate = [self isValidateLoginForm];
    
//    NSString *url = @"http://192.168.2.58/placenotebookservice/index.php?action=login&username=ngodacdu92@gmail.com&password=ngodacdu";
//    [[JSONDownload shareJSONDownload] sendRequestWithURL:url
//                                           methodRequest:[[RequetsFormat shareRequestFormat] getMethod]];
    
//    if (isValidate) {
//        NSString *userName = [self.userNameTextField text];
//        NSString *password = [self.passwordTextField text];
//        NSString *predicate =
//        [NSString stringWithFormat:ACCOUNT_FORMAT, userName, password];
//        if ([[ModelManager shareModelManager] isExistRecordIn:TableAccount
//                                           andPredicateFormat:predicate]) {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                                 bundle:[NSBundle mainBundle]];
            UITabBarController *placeTabBarController =
            [storyboard instantiateViewControllerWithIdentifier:@"PlaceTabBarController"];
            [self.navigationController presentViewController:placeTabBarController
                                                    animated:YES
                                                  completion:nil];
//        } else {
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error, account not exist"
//                                                                message:@"Please check account"
//                                                               delegate:self
//                                                      cancelButtonTitle:nil
//                                                      otherButtonTitles:@"OK", nil];
//            [alertView show];
//        }
//    }
}

#pragma mark - customAccessoryView Delegate
- (void)inputAccessoryViewPreviousButtonDidClick {
    if ([self.passwordTextField isFirstResponder]) {
        [self.userNameTextField becomeFirstResponder];
    }
}

- (void)inputAccessoryViewNextButtonDidClick {
    if ([self.userNameTextField isFirstResponder]) {
        [self.passwordTextField becomeFirstResponder];
    }
}

- (void)inputAccessoryViewDoneButtonDidClick {
    [self.view endEditing:YES];
}

- (IBAction)dismissLoginViewController:(id)sender {
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
