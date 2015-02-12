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

@interface LoginViewController () <CustomInputAccessoryViewDelegate>

@property (weak, nonatomic) IBOutlet ValidateTextField *userNameTextField;
@property (weak, nonatomic) IBOutlet ValidateTextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIScrollView *loginScrollView;
@property (nonatomic, strong) NSString *notifyString;
@property (weak, nonatomic) IBOutlet UILabel *notifyLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic) UITabBarController *placeTabBarController;
@property (weak, nonatomic) IBOutlet UIView *backgroundView;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addObserverKeyboard];
    [self setValidateExpression];
    [self createPlaceTabbarController];
    [self setShadowForView:self.backgroundView];
    [self makeUp];
}

#define DEFAULT_TAB_SELECTED    0  // HOME SCREEN
- (void)createPlaceTabbarController {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                         bundle:[NSBundle mainBundle]];
    self.placeTabBarController = [[UITabBarController alloc] init];
    HomeViewController *homeViewController = [storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
    [homeViewController setTitle:@"Home"];
    UINavigationController *homeNavigationController = [[UINavigationController alloc] initWithRootViewController:homeViewController];
    ScheduleViewController *scheduleViewController = [storyboard instantiateViewControllerWithIdentifier:@"ScheduleViewController"];
    [scheduleViewController setTitle:@"Schedule"];
    UINavigationController *scheduleNavigationController = [[UINavigationController alloc] initWithRootViewController:scheduleViewController];
    AdvanceSearchViewController *advanceViewController = [storyboard instantiateViewControllerWithIdentifier:@"AdvanceSearchViewController"];
    [advanceViewController setTitle:@"Advance Search"];
    UINavigationController *advanceSearchNavigationController = [[UINavigationController alloc] initWithRootViewController:advanceViewController];
    PlaceListViewController *placeListViewController = [storyboard instantiateViewControllerWithIdentifier:@"PlaceListViewController"];
    [placeListViewController setTitle:@"Place List"];
    UINavigationController *placeListNavigationController = [[UINavigationController alloc] initWithRootViewController:placeListViewController];
    AdditionViewController *additionViewController = [storyboard instantiateViewControllerWithIdentifier:@"AdditionViewController"];
    [additionViewController setTitle:@"Addition"];
    UINavigationController *additionNavigationController = [[UINavigationController alloc] initWithRootViewController:additionViewController];
    [self.placeTabBarController setViewControllers:@[homeNavigationController, scheduleNavigationController, advanceSearchNavigationController, placeListNavigationController, additionNavigationController]];
    self.placeTabBarController.selectedIndex = DEFAULT_TAB_SELECTED;
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
    [self.userNameTextField setRegularExpression:ValidateUserName];
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

- (IBAction)touchUpInsideLogin:(id)sender {
    BOOL isValidate = [self isValidateLoginForm];
    if (isValidate) {
        [self.activityIndicator startAnimating];
        [self.notifyLabel setTextColor:[UIColor blackColor]];
    } else {
        [self.activityIndicator stopAnimating];
    }
    [self.notifyLabel setText:self.notifyString];
//    if (isValidate) {
        [self.navigationController presentViewController:self.placeTabBarController animated:YES completion:nil];
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
