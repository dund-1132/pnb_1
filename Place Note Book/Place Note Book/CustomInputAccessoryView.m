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
    (CustomInputAccessoryView *)[[[NSBundle mainBundle] loadNibNamed:@"CustomInputAccessoryView" owner:self options:nil] firstObject];
    
    return customInputAccessoryView;
}

- (IBAction)clickPreviousButton:(id)sender {
    if ([self.delegate respondsToSelector:@selector(inputAccessoryViewPreviousButtonDidClick)]) {
        [self.delegate inputAccessoryViewPreviousButtonDidClick];
    }
}

- (IBAction)clickNextButton:(id)sender {
    if ([self.delegate respondsToSelector:@selector(inputAccessoryViewNextButtonDidClick)]) {
        [self.delegate inputAccessoryViewNextButtonDidClick];
    }
}

- (IBAction)clickDoneButton:(id)sender {
    if ([self.delegate respondsToSelector:@selector(inputAccessoryViewDoneButtonDidClick)]) {
        [self.delegate inputAccessoryViewDoneButtonDidClick];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

@end
