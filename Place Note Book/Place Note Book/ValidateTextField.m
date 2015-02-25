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
#define INSET   10

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
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, INSET, INSET);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, INSET, INSET);
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
            self.rightViewMode = UITextFieldViewModeAlways;
            UIImage *validImage = [UIImage imageNamed:@"valid.png"];
            self.rightView = [[UIImageView alloc] initWithImage:validImage];
        } else {
            if ([self.text isEqualToString:@""]) {
                self.rightView = nil;
            } else {
                self.rightViewMode = UITextFieldViewModeAlways;
                UIImage *validImage = [UIImage imageNamed:@"invalid.png"];
                self.rightView = [[UIImageView alloc] initWithImage:validImage];
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
    return [self validateTextField:self.text
                 regularExpression:self.expression];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
