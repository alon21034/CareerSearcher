//
//  JobDetailViewController.m
//  CareerSearcher
//
//  Created by MD631 on 13/9/30.
//  Copyright (c) 2013年 MD631. All rights reserved.
//

#import "JobDetailViewController.h"
#import "JobContentViewController.h"

@interface JobDetailViewController ()

@end

@implementation JobDetailViewController

@synthesize jobList;
@synthesize data;
@synthesize mScrollView;

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
    
    JobContentViewController *view = [[JobContentViewController alloc]initWithNibName:@"JobContentViewController" bundle:nil];
    
    view.jobTitle = [data valueForKey:@"JOB"];
    view.jobName = [data valueForKey:@"NAME"];
    view.jobcatDescript = [data valueForKey:@"JOBCAT_DESCRIPT"];
    view.jobAddress = [data valueForKey:@"JOB_ADDRESS"];
    view.description = [data valueForKey:@"DESCRIPTION"];
    view.sal = [data valueForKey:@"SAL"];
    view.needEmp = [data valueForKey:@"NEED_EMP"];
    view.worktime = [data valueForKey:@"WORKTIME"];
    view.role = [data valueForKey:@"ROLE"];
    
    [mScrollView addSubview:view.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onBackButtonClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
