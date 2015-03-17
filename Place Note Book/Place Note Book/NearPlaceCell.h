//
//  NearPlaceCell.h
//  Place Note Book
//
//  Created by Ngo Dac Du on 3/10/15.
//  Copyright (c) 2015 ngodacdu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NearPlaceCell : UITableViewCell

@property (nonatomic, strong) NSString *serviceName;

+ (NSString *)cellIdentifier;

+ (UINib *)loadNib;

- (void)refreshService;

@end
