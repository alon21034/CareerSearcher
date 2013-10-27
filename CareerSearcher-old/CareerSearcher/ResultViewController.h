//
//  ResultViewController.h
//  CareerSearcher
//
//  Created by MD631 on 13/8/18.
//  Copyright (c) 2013年 MD631. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchViewController.h"
#import "SearchContentViewController.h"

@interface ResultViewController : UIViewController

#pragma mark navigation_bar
@property (weak, nonatomic) IBOutlet UIBarButtonItem *mNextButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *mBackButton;
- (IBAction)onBackButtonPressed:(id)sender;
- (IBAction)onNextButtonPressed:(id)sender;

@end
