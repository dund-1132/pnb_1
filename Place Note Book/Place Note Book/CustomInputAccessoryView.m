//
//  CustomInputAccessoryView.m
//  Place Note Book
//
//  Created by framgiavn on 2/4/15.
//  Copyright (c) 2015 framgiavn. All rights reserved.
//

#import "CustomInputAccessoryView.h"

@implementation CustomInputAccessoryView

@synthesize delegate;

+ (CustomInputAccessoryView *)instanceFromNibFile {
    CustomInputAccessoryView *customInputAccessoryView =
    (CustomInputAccessoryView *)[[[NSBundle mainBundle] loadNibNamed:@"CustomInputAccessoryView"
                                                               owner:self
                                                             options:nil] firstObject];
    
    return customInputAccessoryView;
}

- (IBAction)clickPreviousButton:(id)sender {
    SEL selector = @selector(inputAccessoryViewPreviousButtonDidClick);
    if ([self.delegate respondsToSelector:selector]) {
        [self.delegate inputAccessoryViewPreviousButtonDidClick];
    }
}

- (IBAction)clickNextButton:(id)sender {
    SEL selector = @selector(inputAccessoryViewNextButtonDidClick);
    if ([self.delegate respondsToSelector:selector]) {
        [self.delegate inputAccessoryViewNextButtonDidClick];
    }
}

- (IBAction)clickDoneButton:(id)sender {
    SEL selector = @selector(inputAccessoryViewDoneButtonDidClick);
    if ([self.delegate respondsToSelector:selector]) {
        [self.delegate inputAccessoryViewDoneButtonDidClick];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (float)inputAccessoryHeight {
    return self.frame.size.height;
}

@end
