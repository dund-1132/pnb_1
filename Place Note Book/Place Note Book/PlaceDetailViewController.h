//
//  PlaceDetailViewController.h
//  Place Note Book
//
//  Created by Ngo Dac Du on 3/10/15.
//  Copyright (c) 2015 ngodacdu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface PlaceDetailViewController : UITableViewController

@property (nonatomic, strong) PFObject *object;

@end
