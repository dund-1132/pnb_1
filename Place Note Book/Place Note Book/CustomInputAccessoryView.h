//
//  CustomInputAccessoryView.h
//  Place Note Book
//
//  Created by framgiavn on 2/4/15.
//  Copyright (c) 2015 framgiavn. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomInputAccessoryViewDelegate;

@interface CustomInputAccessoryView : UIView

@property (nonatomic, assign) id<CustomInputAccessoryViewDelegate> delegate;

+ (CustomInputAccessoryView *)instanceFromNibFile;

- (IBAction)clickPreviousButton:(id)sender;

- (IBAction)clickNextButton:(id)sender;

- (IBAction)clickDoneButton:(id)sender;

@end

@protocol CustomInputAccessoryViewDelegate <NSObject>

@optional
- (void)inputAccessoryViewPreviousButtonDidClick;
- (void)inputAccessoryViewNextButtonDidClick;
- (void)inputAccessoryViewDoneButtonDidClick;

@end