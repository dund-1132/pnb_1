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
                NSString *cachesDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
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

+ (void)updateImage:(UIImage *)image forObject:(UIImageView *)object {
    if (image && object) {
        [object setImage:image];
    }
}

@end
