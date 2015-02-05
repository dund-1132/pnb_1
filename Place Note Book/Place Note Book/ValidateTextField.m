//
//  ValidateTextField.m
//  Place Note Book
//
//  Created by framgiavn on 2/5/15.
//  Copyright (c) 2015 framgiavn. All rights reserved.
//

#import "ValidateTextField.h"

#import "ValidateTextField.h"

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

- (void)setRegularExpression:(NSString *)expression {
    self.expression = expression;
}

- (void)textFieldTextDidChange:(NSNotification *)notification {
    if ([self isFirstResponder]) {
        if ([@"" isEqualToString:self.expression]) {
            return;
        }
        
        if ([self isValidate]) {
            // set border blue
        } else {
            // set border red
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"EnableButton"
                                                            object:nil];
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
