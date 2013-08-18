//
//  JobDetailViewController.h
//  CareerSearcher
//
//  Created by MD631 on 13/8/18.
//  Copyright (c) 2013年 MD631. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JobDetailViewController : UIViewController
- (IBAction)onBackButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *mLabel;
@property (weak, nonatomic) NSData *mJobData;
@property int mJobIndex;

@end
