//
//  ResultViewController.h
//  CareerSearcher
//
//  Created by MD631 on 13/8/18.
//  Copyright (c) 2013年 MD631. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchViewController.h"

@interface ResultViewController : UIViewController<UIScrollViewDelegate, SearchViewDelegate>

@property (strong, nonatomic) NSMutableArray* mCareerList;

@property (weak, nonatomic) NSString *mLocation1;
@property (weak, nonatomic) NSString *mLocation2;
@property (weak, nonatomic) NSString *mLocation3;

#pragma mark navigation_bar
@property (weak, nonatomic) IBOutlet UIBarButtonItem *mNextButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *mBackButton;
- (IBAction)onBackButtonPressed:(id)sender;
- (IBAction)onNextButtonPressed:(id)sender;

#pragma mark ui_items
@property (strong, nonatomic) NSMutableArray *mControllersArray;
@property (strong, nonatomic) IBOutlet UIScrollView *mScrollView;
@property (strong, nonatomic) IBOutlet UIPageControl *mPageControl;

#pragma mark tab_button
@property (strong, nonatomic) IBOutlet UIButton *mButton1;
@property (strong, nonatomic) IBOutlet UIButton *mButton2;
@property (strong, nonatomic) IBOutlet UIButton *mButton3;

- (IBAction)onTabButtonClicked:(id)sender;

@end
