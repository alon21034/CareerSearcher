//
//  JobDetailViewController.m
//  CareerSearcher
//
//  Created by MD631 on 13/8/18.
//  Copyright (c) 2013年 MD631. All rights reserved.
//

#import "JobDetailViewController.h"

@interface JobDetailViewController ()

@end

@implementation JobDetailViewController

@synthesize mLabel;
@synthesize mJobData;

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
    
	// Do any additional setup after loading the view.
    
//    NSArray *arr = [NSJSONSerialization JSONObjectWithData:mJobData options:nil error:nil];
//    
//    NSDictionary *dic = [arr objectAtIndex:_mJobIndex];
//    
//    NSString *title = [dic valueForKey:@"JOB"];
//    NSString *description = [dic valueForKey:@"DESCRIPTION"];
//    
//    mLabel.text = [NSString stringWithFormat:@"title: %@ description: %@", title, description];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onBackButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
