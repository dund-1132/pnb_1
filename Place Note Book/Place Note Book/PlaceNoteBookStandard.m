//
//  PlaceNoteBookColor.m
//  Place Note Book
//
//  Created by Ngo Dac Du on 3/7/15.
//  Copyright (c) 2015 ngodacdu. All rights reserved.
//

#import "PlaceNoteBookStandard.h"

#define CORNER_RADIUS   6.0
#define LINE_WIDTH  0.3
#define BORDER_WIDTH    0.5
#define COLOR_SIGN_UP_BUTTON [UIColor colorWithRed:0 green:122/255.0 blue:255/255.0 alpha:1.0]

@implementation PlaceNoteBookStandard

+ (float)cornerRadius {
    return CORNER_RADIUS;
}

+ (float)lineWidth {
    return LINE_WIDTH;
}

+ (float)borderWidth {
    return BORDER_WIDTH;
}

+ (UIColor *)colorSignUpButton {
    return COLOR_SIGN_UP_BUTTON;
}

@end
