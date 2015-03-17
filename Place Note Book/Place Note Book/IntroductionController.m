//
//  ViewController.m
//  Place Note Book
//
//  Created by Ngo Dac Du on 3/6/15.
//  Copyright (c) 2015 ngodacdu. All rights reserved.
//

#import "IntroductionController.h"
#import "CustomInputAccessoryView.h"
#import "PlaceNoteBookStandard.h"
#import "ValidateTextField.h"
#import "PFUserManager.h"

typedef enum : NSUInteger {
    BorderTop,
    BorderBottom,
} BorderType;

@interface IntroductionController () <CustomInputAccessoryViewDelegate, UITextFieldDelegate, PFUserManagerDelegate>

@property (weak, nonatomic) IBOutlet UIView *formView;
@property (weak, nonatomic) IBOutlet ValidateTextField *emailTextField;
@property (weak, nonatomic) IBOutlet ValidateTextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation IntroductionController

// custom input accessory view -> keyboard
- (UIView *)inputAccessoryView {
    CustomInputAccessoryView *customAccessoryView = [CustomInputAccessoryView instanceFromNibFile];
    customAccessoryView.delegate = self;
    
    return customAccessoryView;
}

#pragma mark - CustomInputAccessoryViewDelegate
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

#pragma mark - event
- (void)viewDidLoad {
    [super viewDidLoad];
    [PFUserManager sharePFUserManager].delegate = self;
    [self validateExpression];
    [self addObserverKeyboard];
    [self gestureForView];
    [self makeUp];
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

- (void)gestureForView {
    SEL selector = @selector(inputAccessoryViewDoneButtonDidClick);
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:selector];
    [self.view addGestureRecognizer:tapGesture];
}

#define ANIMATION   1.0
#define ACCESSORY_HEIGHT    40
- (void)onKeyboardShow:(NSNotification *)notification {
    NSDictionary *keyboardInfo = [notification userInfo];
    NSValue *keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    [UIView animateWithDuration:ANIMATION animations:^{
        CGRect currentRect = [[UIScreen mainScreen] bounds];
        float loginYOrigin = self.loginButton.frame.origin.y;
        float loginHeight = self.loginButton.frame.size.height;
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

#define mark - make up UI
- (void)makeUp {
    self.formView.layer.cornerRadius = [PlaceNoteBookStandard cornerRadius];
    [self makeButton:self.loginButton];
    [ValidateTextField roundCornersOnView:self.formView
                                onTopLeft:YES
                                 topRight:YES
                               bottomLeft:YES
                              bottomRight:YES
                                   radius:[PlaceNoteBookStandard cornerRadius]];
    [self.emailTextField clearBorder];
    [self.passwordTextField clearBorder];
}

- (void)makeButton:(UIButton *)button {
    button.layer.cornerRadius = [PlaceNoteBookStandard cornerRadius];
}

#pragma mark - validate
- (void)validateExpression {
    [self.emailTextField setRegularExpression:ValidateEmail];
    [self.passwordTextField setRegularExpression:ValidatePassword];
}

#pragma mark - control to view controller
- (IBAction)login:(id)sender {
    if ([self.emailTextField isValidate]
        && [self.passwordTextField isValidate]) {
        
        NSString *email = [self.emailTextField text];
        NSString *password = [self.passwordTextField text];
        [[PFUserManager sharePFUserManager] isExistAccount:email
                                                  password:password];
        
    }
}

- (void)PFUserManager:(PFUserManager *)userManager didCheckExist:(BOOL)successed {
    if (successed) {
        [self performSegueWithIdentifier:@"LoginPresentTabBarController"
                                  sender:self];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sign in fail"
                                                            message:@"Please check information"
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
    }
}

- (IBAction)singin:(id)sender {
    [self performSegueWithIdentifier:@"IntroductionToSignUp"
                              sender:self];
}

- (IBAction)facebook:(id)sender {
    [self performSegueWithIdentifier:@"IntroductionToFacebook"
                              sender:self];
}

@end
