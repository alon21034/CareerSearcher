//
//  ViewController.m
//  CareerSearcher
//
//  Created by MD631 on 13/9/28.
//  Copyright (c) 2013年 MD631. All rights reserved.
//

#import "ViewController.h"
#import "ResultViewController.h";

@interface ViewController ()

@end

@implementation ViewController

@synthesize vc;
@synthesize mButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    vc = [self.childViewControllers objectAtIndex:0];

    [vc setHint:@"job detail"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onButtonClicked:(id)sender {
    ResultViewController *view= [[ResultViewController alloc] initWithNibName:@"ResultViewController" bundle:nil];
    view.mTabNum = 1;
    view.stringFromHomePage = [vc getText];
    [self presentViewController:view animated:YES completion:nil];
}

@end
