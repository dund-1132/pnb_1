//
//  ImageDownload.h
//  Place Note Book
//
//  Created by framgiavn on 2/10/15.
//  Copyright (c) 2015 framgiavn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageDownload : NSObject

+ (void)downloadImageFromURL:(NSString *)URLString andUpdateTo:(UIImageView *)object;

@end
