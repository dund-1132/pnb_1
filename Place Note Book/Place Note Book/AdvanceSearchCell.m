//
//  AdvanceSearchCell.m
//  Place Note Book
//
//  Created by Ngo Dac Du on 3/10/15.
//  Copyright (c) 2015 ngodacdu. All rights reserved.
//

#import "AdvanceSearchCell.h"

@implementation AdvanceSearchCell

+ (NSString *)cellIdentifier {
    return @"AdvanceSearchCellIdentifier";
}

+ (UINib *)loadNib {
    return [UINib nibWithNibName:@"AdvanceSearchCell" bundle:nil];
}

@end
