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

@synthesize mJobTitle;
@synthesize mJobDetail;
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
    
    NSArray *arr = [NSJSONSerialization JSONObjectWithData:mJobData options:nil error:nil];
    
    NSDictionary *dic = [arr objectAtIndex:_mJobIndex];
    
    NSString *title = [dic valueForKey:@"JOB"];
    NSString *description = [dic valueForKey:@"DESCRIPTION"];
    
    mJobTitle.text = title;
    
    mJobDetail.text = [NSString stringWithFormat:@"職務類別: %@\n工作待遇: %@\n上班地點: %@",
                       [dic valueForKey:@"JOBCAT_DESCRIPT"],
                       [dic valueForKey:@"SAL"],
                       [dic valueForKey:@"ADDRESS"]];
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
