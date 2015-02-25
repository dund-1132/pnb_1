//
//  SearchBarCell.m
//  Place Note Book
//
//  Created by framgiavn on 2/5/15.
//  Copyright (c) 2015 framgiavn. All rights reserved.
//

#import "CustomSearchBarCell.h"

#define SEARCH_BAR_CELL_HEIGHT  44

@interface CustomSearchBarCell() <UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation CustomSearchBarCell

+ (NSString *)cellIdentifier {
    return @"SearchBarCell";
}

+ (UINib *)getSearchBarNib {
    return [UINib nibWithNibName:@"SearchBarCell"
                          bundle:nil];
}

+ (CGFloat)getHeight {
    return SEARCH_BAR_CELL_HEIGHT;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.searchBar.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onKeyboardShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onKeyboardHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(coverViewDidClicked:)
                                                 name:@"TouchCoverView"
                                               object:nil];
}

- (void)onKeyboardShow:(NSNotification *)notification {
    
}

- (void)onKeyboardHide:(NSNotification *)notification {
    
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:YES
                           animated:YES];
    UIColor *statusColor = [UIColor colorWithRed:10/255.0
                                           green:183/255.0
                                            blue:128/255.0
                                           alpha:1.0];
    for (UIView *firstView in searchBar.subviews) {
        for(UIView *view in firstView.subviews) {
            if([view isKindOfClass:[UIButton class]]) {
                UIButton *cancelButton = (UIButton *)view;
                [cancelButton setEnabled:YES];
                [cancelButton.titleLabel setTextColor:[UIColor whiteColor]];
//                [cancelButton setTitleColor:[UIColor whiteColor]
//                                   forState:UIControlStateNormal];
            }
        }
    }
    [searchBar setBarTintColor:statusColor];
    searchBar.layer.borderWidth = 1.0;
    searchBar.layer.borderColor = statusColor.CGColor;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HideNavigationBar"
                                                        object:nil];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self endEdittingSearchBar:searchBar];
}

- (void)coverViewDidClicked:(NSNotification *)notification {
    [self endEdittingSearchBar:self.searchBar];
}

- (void)endEdittingSearchBar:(UISearchBar *)searchBar {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowNavigationBar"
                                                        object:nil];
    if ([searchBar isFirstResponder]) {
        [searchBar endEditing:YES];
    }
    [searchBar setShowsCancelButton:NO
                           animated:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected
              animated:animated];
}

- (void)prepareForReuse {
    
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
