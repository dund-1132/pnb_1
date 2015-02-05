//
//  ValidateTextField.h
//  Place Note Book
//
//  Created by framgiavn on 2/5/15.
//  Copyright (c) 2015 framgiavn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum ValidateType {
    ValidateUserName,
    ValidateEmail,
    ValidatePassword
} ValidateState;

@interface ValidateTextField : UITextField <UITextFieldDelegate>

- (void)setRegularExpression:(ValidateState)validateType;

- (BOOL)isValidate;

@end
