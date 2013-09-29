//
//  ResultViewController.h
//  CareerSearcher
//
//  Created by MD631 on 13/9/28.
//  Copyright (c) 2013年 MD631. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditStringViewController.h"

@interface ResultViewController : UIViewController <UIScrollViewDelegate, EditStringDelegate>

@property (assign, nonatomic) int mTabNum;
@property (assign, nonatomic) NSString* stringFromHomePage;
@property (strong, nonatomic) NSMutableArray* mControllerArray;
@property (strong, nonatomic) NSMutableArray* mTabButtonArray;
@property (strong, nonatomic) UIView *lineView;
@property (strong, nonatomic) NSMutableArray* mSearchTermList;

@property (strong, nonatomic) IBOutlet UIScrollView *mScrollView;
@property (strong, nonatomic) IBOutlet UIPageControl *mPageControll;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *mNextButton;
- (IBAction)onNextButtonClicked:(id)sender;

@end
