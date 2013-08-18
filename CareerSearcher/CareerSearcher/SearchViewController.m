//
//  SearchViewController.m
//  CareerSearcher
//
//  Created by MD631 on 13/8/18.
//  Copyright (c) 2013年 MD631. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

@synthesize searchTermStr1;
@synthesize searchTermStr2;

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
    
    _mCareerTextField.placeholder = @"職務名稱";
    _mLocationTextField.placeholder = @"所在地區";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onFinishedButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)onAddButtonClicked:(id)sender {
    
    if ([searchTermStr1 length] == 0 && [searchTermStr2 length] == 0) {
        searchTermStr1 = _mCareerTextField.text;
    } else if ([searchTermStr2 length] == 0) {
        searchTermStr2 = _mCareerTextField.text;
    } else {
        // do nothing
    }
    
    [self updateSearchTerm];
}

- (void) updateSearchTerm {
    
    _mCareerTextField.text = @"";
    _mLocationTextField.text = @"";
    _mSearchTerm1.text = searchTermStr1;
    _mSearchTerm2.text = searchTermStr2;
}
@end
