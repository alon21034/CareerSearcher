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
@property (strong, nonatomic) IBOutlet UINavigationBar *mTitleBar;
@property (strong, nonatomic) IBOutlet UILabel *mTitleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *mImageVIew;
@property (strong, nonatomic) IBOutlet UILabel *mContentLabel;

@end
