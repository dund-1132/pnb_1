//
//  CustomPageImageView.m
//  Place Note Book
//
//  Created by framgiavn on 2/13/15.
//  Copyright (c) 2015 framgiavn. All rights reserved.
//

#import "PageImageView.h"
#import "ImageDownload.h"

static PageImageView *staticCustomPageImageView;

@interface PageImageView() <UIScrollViewDelegate>

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation PageImageView

+ (PageImageView *)sharePageImageView {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        staticCustomPageImageView = [[PageImageView alloc] init];
    });
    
    return staticCustomPageImageView;
}

- (instancetype)init {
    if (self = [super init]) {
        [self addTargetForView:self];
        self.imageView = [[UIImageView alloc] init];
        [self.imageView setContentMode:UIViewContentModeScaleAspectFit];
        [self setBackgroundColor:[UIColor blackColor]];
        [self addSubview:self.imageView];
    }
    
    return self;
}

#define TRANSITION  0.5
- (void)showPageImageView {
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [[PageImageView sharePageImageView] setFrame:[window bounds]];
    [self.imageView setFrame:[window bounds]];
    [UIView transitionWithView:window
                      duration:TRANSITION
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        [window addSubview:[PageImageView sharePageImageView]];
                    } completion:nil];
}

- (void)updateImage:(UIImage *)image {
    [self.imageView setImage:image];
}

- (void)hidePageImageView {
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [UIView transitionWithView:window
                      duration:TRANSITION
                       options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                           [[PageImageView sharePageImageView] removeFromSuperview];
                       } completion:nil];
}


- (void)addTargetForView:(UIView *)pageView {
    UITapGestureRecognizer *tapPageView =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(hidePageImageView)];
    tapPageView.numberOfTapsRequired = 1;
    [pageView addGestureRecognizer:tapPageView];
}

@end
