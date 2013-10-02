//
//  JobDetailViewController.m
//  CareerSearcher
//
//  Created by MD631 on 13/9/30.
//  Copyright (c) 2013年 MD631. All rights reserved.
//

#import "JobDetailViewController.h"

@interface JobDetailViewController ()

@end

@implementation JobDetailViewController

@synthesize jobList;
@synthesize data;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // set title
    _mTitleBar.topItem.title = [data valueForKey:@"JOB"];
    _mTitleLabel.text = [data valueForKey:@"DESCRIPTION"];
    
    // set logo Image
    NSURL *url = [NSURL URLWithString:[data valueForKey:@"LOGO"]];
    NSLog(@"logo: %@", [data valueForKey:@"LOGO"]);
    NSData *image = [NSData dataWithContentsOfURL:url];
    UIImage *img = [[UIImage alloc] initWithData:image];
    _mImageVIew.image = img;
    
    // set job detail
    _mContentLabel.numberOfLines = 40;
    _mContentLabel.text = [NSString stringWithFormat:
        @"職務類別: %@\n\n工作待遇: %@\n\n工作性質: %@\n\n上班時段: %@\n\n需求人數: %@",
                           [data valueForKey:@"JOBCAT_DESCRIPT"],
                           [data valueForKey:@"SAL"],
                           [data valueForKey:@"ROLE"],
                           [data valueForKey:@"WORKTIME"],
                           [data valueForKey:@"NEED_EMP"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
