//
//  ValidateTextField.m
//  Place Note Book
//
//  Created by framgiavn on 2/5/15.
//  Copyright (c) 2015 framgiavn. All rights reserved.
//

#import "ValidateTextField.h"

#define USER_NAME_VALIDATE_EXPRESSION   @"^[a-zA-Z0-9]+([a-zA-Z0-9](_|-| )[a-zA-Z0-9])*[a-zA-Z0-9]+$"
#define EMAIL_NAME_VALIDATE_EXPRESSION  @"^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}$"
#define PASSWORD_VALIDATE_EXPRESSION    @"^[a-zA-Z0-9]{5,11}$"
#define TEXT_FIELD_BORDER_WIDTH 0.3f
#define TEXT_FIELD_BORDER_RADIUS    5.0f
#define ACCESSORY_HEIGHT    20

@interface ValidateTextField()

@property (nonatomic, strong) NSString *expression;

@end

@implementation ValidateTextField

- (void)awakeFromNib {
    [super awakeFromNib];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFieldTextDidChange:)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onKeyboardShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
}

- (void)onKeyboardShow:(NSNotification *)notification {
    if ([self isFirstResponder]) {
        NSDictionary *info = [notification userInfo];
        CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
        CGPoint textFieldOrigin = self.frame.origin;
        CGFloat textFieldHeight = self.frame.size.height;
        CGRect visibleRect = [UIScreen mainScreen].bounds;
        visibleRect.size.height = visibleRect.size.height - keyboardSize.height - ACCESSORY_HEIGHT;
        if ((textFieldOrigin.y + textFieldHeight) > visibleRect.size.height) {
            CGPoint scrollPoint = CGPointMake(0.0, textFieldOrigin.y - visibleRect.size.height + textFieldHeight);
            [(UIScrollView *)self.superview setContentOffset:scrollPoint
                                                    animated:YES];
        }
    }
}

- (void)setRegularExpression:(ValidateState)validateType {
    switch (validateType) {
        case ValidateUserName:
            self.expression = USER_NAME_VALIDATE_EXPRESSION;
            break;
        case ValidateEmail:
            self.expression = EMAIL_NAME_VALIDATE_EXPRESSION;
            break;
        case ValidatePassword:
            self.expression = PASSWORD_VALIDATE_EXPRESSION;
            break;
            
        default:
            break;
    }
}

- (void)textFieldTextDidChange:(NSNotification *)notification {
    if ([self isFirstResponder]) {
        if ([@"" isEqualToString:self.expression] || !self.expression) {
            return;
        }
        if ([self isValidate]) {
            self.layer.borderWidth = TEXT_FIELD_BORDER_WIDTH;
            self.layer.borderColor = [UIColor greenColor].CGColor;
        } else {
            if ([self.text isEqualToString:@""]) {
                self.layer.borderWidth = 0.0f;
            } else {
                self.layer.borderWidth = TEXT_FIELD_BORDER_WIDTH;
                self.layer.cornerRadius = TEXT_FIELD_BORDER_RADIUS;
                self.layer.borderColor = [UIColor redColor].CGColor;
            }
        }
    }
}

- (BOOL)validateTextField:(NSString *)text regularExpression:(NSString *)expression {
    NSRegularExpression *regularExpressionPattern =
    [[NSRegularExpression alloc] initWithPattern:expression
                                         options:NSRegularExpressionCaseInsensitive
                                           error:nil];
    NSUInteger regularExpressionMatches =
    [regularExpressionPattern numberOfMatchesInString:text
                                              options:0
                                                range:NSMakeRange(0, [text length])];
    if (regularExpressionMatches == 0) {
        return NO;
    }
    
    return YES;
}

- (BOOL)isValidate {
    NSLog(@"%@", self.expression);
    return [self validateTextField:self.text
                 regularExpression:self.expression];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
