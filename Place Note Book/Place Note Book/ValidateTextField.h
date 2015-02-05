//
//  ValidateTextField.h
//  Place Note Book
//
//  Created by framgiavn on 2/5/15.
//  Copyright (c) 2015 framgiavn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ValidateTextField : UITextField <UITextFieldDelegate>

- (void)setRegularExpression:(NSString *)expression;

- (BOOL)isValidate;

@end
