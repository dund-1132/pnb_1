//
//  PeopleExploreCell.m
//  Place Note Book
//
//  Created by Ngo Dac Du on 3/10/15.
//  Copyright (c) 2015 ngodacdu. All rights reserved.
//

#import "PeopleExploreCell.h"
#import "ImageDownload.h"
#import "ValidateTextField.h"
#import "PlaceNoteBookStandard.h"

#define CORNER_RADIUS   3.0

@interface PeopleExploreCell()

@property (weak, nonatomic) IBOutlet UIView *shadowView;

@end


@implementation PeopleExploreCell

+ (NSString *)cellIdentifier {
    return @"PeopleExploreCellIdentifier";
}

+ (UINib *)loadNib {
    return [UINib nibWithNibName:@"PeopleExploreCell"
                          bundle:nil];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self makeUpCell:self.shadowView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)makeUpCell:(UIView *)view {
    [view.layer setCornerRadius:CORNER_RADIUS];
    [view.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [view.layer setBorderWidth:[PlaceNoteBookStandard lineWidth]];
    
    [view.layer setShadowColor:[UIColor blackColor].CGColor];
    [view.layer setShadowOpacity:0.2];
    [view.layer setShadowRadius:CORNER_RADIUS];
    [view.layer setShadowOffset:CGSizeMake(1.0, 2.0)];
}

@end
