//
//  ResultViewController.h
//  CareerSearcher
//
//  Created by MD631 on 13/8/18.
//  Copyright (c) 2013年 MD631. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultViewController : UIViewController<UIScrollViewDelegate>

@property (weak, nonatomic) NSString *mCareer;
@property (weak, nonatomic) NSString *mLocation;

#pragma mark navigation_bar
@property (weak, nonatomic) IBOutlet UIBarButtonItem *mNextButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *mBackButton;
- (IBAction)onBackButtonPressed:(id)sender;
- (IBAction)onNextButtonPressed:(id)sender;

#pragma mark ui_items
@property (strong, nonatomic) NSMutableArray *mControllersArray;
@property (strong, nonatomic) IBOutlet UIScrollView *mScrollView;

@end
