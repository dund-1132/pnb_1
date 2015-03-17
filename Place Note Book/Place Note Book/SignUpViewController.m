//
//  SignUpViewController.m
//  Place Note Book
//
//  Created by Ngo Dac Du on 3/8/15.
//  Copyright (c) 2015 ngodacdu. All rights reserved.
//

#import "SignUpViewController.h"
#import "CustomInputAccessoryView.h"
#import "CustomSignUpButton.h"

@interface SignUpViewController () <CustomInputAccessoryViewDelegate>

@end

@implementation SignUpViewController

// custom input accessory view -> keyboard
- (UIView *)inputAccessoryView {
    CustomInputAccessoryView *customAccessoryView = [CustomInputAccessoryView instanceFromNibFile];
    customAccessoryView.delegate = self;
    
    return customAccessoryView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self gestureForView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)inputAccessoryViewPreviousButtonDidClick {
    
}

- (void)inputAccessoryViewNextButtonDidClick {
    
}

- (void)inputAccessoryViewDoneButtonDidClick {
    [self.view endEditing:YES];
}

#pragma mark - handle show/hide keyboard
- (void)gestureForView {
    SEL selector = @selector(inputAccessoryViewDoneButtonDidClick);
    UITapGestureRecognizer *tapGesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:selector];
    [self.view addGestureRecognizer:tapGesture];
    
    UISwipeGestureRecognizer *swipeGesture =
    [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                              action:@selector(goBackViewController)];
    [swipeGesture setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipeGesture];
}

- (void)goBackViewController {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
