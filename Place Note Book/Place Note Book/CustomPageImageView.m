//
//  CustomPageImageView.m
//  Place Note Book
//
//  Created by framgiavn on 2/13/15.
//  Copyright (c) 2015 framgiavn. All rights reserved.
//

#import "CustomPageImageView.h"
#import "ImageDownload.h"

static CustomPageImageView *staticCustomPageImageView;

@interface CustomPageImageView() <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *pageScrollView;
@property (nonatomic, strong) UIView *pageView;
@property (weak, nonatomic) IBOutlet UILabel *notifyLabel;


@end

@implementation CustomPageImageView

@synthesize pageScrollView;

+ (CustomPageImageView *)shareCustomPageImageView {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        staticCustomPageImageView = [[CustomPageImageView alloc] init];
    });
    
    return staticCustomPageImageView;
}

- (instancetype)init {
    if (self = [super init]) {
        if (!self.pageView) {
            self.pageView = [[[NSBundle mainBundle] loadNibNamed:@"PageImageView"
                                                           owner:self
                                                         options:nil] firstObject];
            [self addTargetForView:self.pageView];            
        }
    }
    
    return self;
}


#define TRANSITION  0.5
- (void)showPageImageView {
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [UIView transitionWithView:window
                      duration:TRANSITION
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        [window addSubview:self.pageView];
                    } completion:nil];
}

- (void)hidePageImageView {
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [UIView transitionWithView:window
                      duration:TRANSITION
                       options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                           [self.pageView removeFromSuperview];
                       } completion:nil];
}

- (void)addTargetForView:(UIView *)pageView {
    UITapGestureRecognizer *tapPageView = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                  action:@selector(hidePageImageView)];
    tapPageView.numberOfTapsRequired = 1;
    [pageView addGestureRecognizer:tapPageView];
}

#define PAGE_COUNT_TEMP 10
#define OFFSET    50
- (void)awakeFromNib {
    [super awakeFromNib];
    self.pageScrollView.delegate = self;
    [self changeContentSizeScrollView];
}

- (void)changeContentSizeScrollView {
    CGRect screen = self.pageScrollView.frame;
    float width = screen.size.width;
    float height = screen.size.height;
    [self.pageScrollView setContentSize:CGSizeMake(width * PAGE_COUNT_TEMP, height)];
    for (int index = 0; index < PAGE_COUNT_TEMP; index++) {
        float originX = index * width;
        CGRect imageViewRect = CGRectMake(originX, 0, width, height);
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:imageViewRect];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.center = CGPointMake(imageView.center.x, imageView.center.y - OFFSET);
        [self.pageScrollView addSubview:imageView];
        NSString *urlString = @"https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcTP0of4WBTP2Pxj_QVZr44gPdlSVLRk14qDPw8kHl5zwC2wr2x8";
        [ImageDownload downloadImageFromURL:urlString andUpdateTo:imageView];
    }
}

#pragma mark - scroll view delegate
- (void)loadScrollViewWithPage:(NSUInteger)page {
    if (page >= PAGE_COUNT_TEMP) {
        return;
    }
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = CGRectGetWidth(self.pageScrollView.frame);
    NSUInteger page = floor((self.pageScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    [self.notifyLabel setText:[NSString stringWithFormat:@"Image %lu/%d", (unsigned long)page + 1, PAGE_COUNT_TEMP]];
}


@end
