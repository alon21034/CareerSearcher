//
//  JobDetailViewController.h
//  CareerSearcher
//
//  Created by MD631 on 13/9/30.
//  Copyright (c) 2013年 MD631. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JobDetailViewController : UIViewController

@property (assign, nonatomic) NSArray *jobList;
@property (assign, nonatomic) NSDictionary *data;
- (IBAction)onBackButtonClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIScrollView *mScrollView;

@end
