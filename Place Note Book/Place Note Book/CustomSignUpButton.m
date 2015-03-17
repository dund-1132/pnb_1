//
//  CustomSignUpButton.m
//  Place Note Book
//
//  Created by Ngo Dac Du on 3/8/15.
//  Copyright (c) 2015 ngodacdu. All rights reserved.
//

#import "CustomSignUpButton.h"
#import "PlaceNoteBookStandard.h"

@implementation CustomSignUpButton

- (instancetype)init {
    if (self = [super init]) {
        
    }
    
    return self;
}

- (void)awakeFromNib {
    self.layer.cornerRadius = [PlaceNoteBookStandard cornerRadius];
}

@end
