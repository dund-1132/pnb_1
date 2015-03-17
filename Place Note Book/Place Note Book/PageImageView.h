//
//  CustomPageImageView.h
//  Place Note Book
//
//  Created by framgiavn on 2/13/15.
//  Copyright (c) 2015 framgiavn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageImageView : UIView

+ (PageImageView *)sharePageImageView;

- (void)showPageImageView;

- (void)hidePageImageView;

- (void)updateImage:(UIImage *)image;

@end
