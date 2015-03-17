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
    ValidatePassword,
    ValidateName
} ValidateState;

@interface ValidateTextField : UITextField <UITextFieldDelegate>

- (void)setRegularExpression:(ValidateState)validateType;

- (BOOL)isValidate;

+ (UIView *)roundCornersOnView:(UIView *)view
                     onTopLeft:(BOOL)tl
                      topRight:(BOOL)tr
                    bottomLeft:(BOOL)bl
                   bottomRight:(BOOL)br
                        radius:(float)radius;

+ (UIView *)borderColor:(UIView *)view color:(UIColor *)color width:(float)width;

+ (UIView *)roundOnView:(UIView *)view radius:(float)radius;

- (void)clearBorder;

@end
