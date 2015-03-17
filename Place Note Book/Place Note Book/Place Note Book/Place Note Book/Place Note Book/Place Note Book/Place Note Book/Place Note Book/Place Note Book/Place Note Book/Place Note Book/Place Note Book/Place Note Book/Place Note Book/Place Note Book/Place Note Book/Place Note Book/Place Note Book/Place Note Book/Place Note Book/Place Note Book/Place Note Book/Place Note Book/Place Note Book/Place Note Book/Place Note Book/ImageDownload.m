//
//  ImageDownload.m
//  Place Note Book
//
//  Created by framgiavn on 2/10/15.
//  Copyright (c) 2015 framgiavn. All rights reserved.
//

#import "ImageDownload.h"

static NSCache *imageCache;

@interface ImageDownload()

@end

@implementation ImageDownload

+ (void)downloadImageFromURL:(NSString *)URLString andUpdateTo:(UIImageView *)object {
    if (!imageCache) {
        imageCache = [[NSCache alloc] init];
    }
    UIImage *imageFromCache = [imageCache objectForKey:URLString];
    if (imageFromCache) {
        [self updateImage:imageFromCache forObject:object];
    } else {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSURL *imageURL = [NSURL URLWithString:URLString];
            NSData *downloadedData = [NSData dataWithContentsOfURL:imageURL];
            if (downloadedData) {
                NSString *cachesDirectory =
                [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                NSString *filePath = [cachesDirectory stringByAppendingString:URLString];
                [downloadedData writeToFile:filePath atomically:YES];
                UIImage *downloadedImage = [[UIImage alloc] initWithData:downloadedData];
                if (downloadedImage) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self updateImage:downloadedImage forObject:object];
                        [imageCache setObject:downloadedImage forKey:URLString];
                    });
                }
            }
        });
    }
}

+ (UIImage *)resizeImage:(UIImage *)orginalImage resizeSize:(CGSize)size {
    CGFloat actualHeight = orginalImage.size.height;
    CGFloat actualWidth = orginalImage.size.width;
    float oldRatio = actualWidth/actualHeight;
    float newRatio = size.width/size.height;
    if(oldRatio < newRatio) {
        oldRatio = size.height/actualHeight;
        actualWidth = oldRatio * actualWidth;
        actualHeight = size.height;
    } else {
        oldRatio = size.width/actualWidth;
        actualHeight = oldRatio * actualHeight;
        actualWidth = size.width;
    }
    
    CGRect rect = CGRectMake(0.0,0.0,actualWidth,actualHeight);
    UIGraphicsBeginImageContext(rect.size);
    [orginalImage drawInRect:rect];
    orginalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return orginalImage;
}

+ (void)updateImage:(UIImage *)image forObject:(UIImageView *)object {
    if (image && object) {
        [object setImage:image];
    }
}

@end
