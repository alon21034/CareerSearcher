//
//  JobContentViewController.m
//  CareerSearcher
//
//  Created by Lee Haw on 13/10/8.
//  Copyright (c) 2013年 Lee Haw. All rights reserved.
//

#import "JobContentViewController.h"

@interface JobContentViewController ()

@end

@implementation JobContentViewController

@synthesize mTitleLabel;
@synthesize mNameLabel;
@synthesize mContentLabel;

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
    
    mTitleLabel.text = _jobTitle;
    mNameLabel.text = _jobName;
    
    mContentLabel.text = [NSString stringWithFormat:@"[職務說明]:\n%@\n[職務類別]:\n%@\n[工作待遇]:\n%@", _description, _jobcatDescript, _sal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
