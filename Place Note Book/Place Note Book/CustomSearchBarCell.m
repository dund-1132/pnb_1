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
}

- (void)onKeyboardShow:(NSNotification *)notification {
    
}

- (void)onKeyboardHide:(NSNotification *)notification {
    
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HideNavigationBar"
                                                        object:nil];
    [searchBar setShowsCancelButton:YES
                           animated:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowNavigationBar"
                                                        object:nil];
    if ([searchBar isFirstResponder]) {
        [searchBar endEditing:YES];
    }
    [searchBar setShowsCancelButton:NO animated:YES];
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
