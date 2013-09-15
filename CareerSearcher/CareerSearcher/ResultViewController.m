//
//  ResultViewController.m
//  CareerSearcher
//
//  Created by MD631 on 13/8/18.
//  Copyright (c) 2013年 MD631. All rights reserved.
//

#import "ResultViewController.h"
#import "JobDetailViewController.h"
#import "SearchViewController.h"
#import "SearchContentViewController.h"

@interface ResultViewController ()
{
    int pageNum;
    int pageWidth;
    int pageHeight;
}

@end

@implementation ResultViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)reloadPages
{

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark onClick

- (IBAction)onBackButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onNextButtonPressed:(id)sender {
    SearchViewController *searchView = [self.storyboard instantiateViewControllerWithIdentifier:@"search_view"];
    searchView.mDelegate = self;
    searchView.mCareerTermArr = [[NSMutableArray alloc] init];
    
    for (NSUInteger i = 0; i < 3 ; i++) {
        //[searchView.mCareerTermArr addObject:[_mCareerList objectAtIndex:i]];
    }
    
    [self presentViewController:searchView animated:YES completion:nil];
}

@end