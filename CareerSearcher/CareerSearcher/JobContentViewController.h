//
//  JobContentViewController.h
//  CareerSearcher
//
//  Created by Lee Haw on 13/10/8.
//  Copyright (c) 2013年 Lee Haw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JobContentViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *mTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *mNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *mContentLabel;

@property (assign, nonatomic) NSString *jobTitle;
@property (assign, nonatomic) NSString *jobName;
@property (assign, nonatomic) NSString *description;
@property (assign, nonatomic) NSString *jobcatDescript;
@property (assign, nonatomic) NSString *sal;
@property (assign, nonatomic) NSString *role;
@property (assign, nonatomic) NSString *worktime;
@property (assign, nonatomic) NSString *needEmp;
@property (assign, nonatomic) NSString *jobAddress;



@end
