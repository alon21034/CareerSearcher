//
//  ViewController.m
//  CareerSearcher
//
//  Created by MD631 on 13/8/18.
//  Copyright (c) 2013年 MD631. All rights reserved.
//

#import "ViewController.h"
#import "ResultViewController.h"


@interface ViewController ()

@end

@implementation ViewController

@synthesize mLocationTextField;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    mLocationTextField.placeholder = @"所在地區";
    
    mLocationTextField.text = @"台北市";
    
    _vc = [self.childViewControllers objectAtIndex:0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Button
- (IBAction)onButtonClicked:(id)sender {
    
    ResultViewController *view= [self.storyboard instantiateViewControllerWithIdentifier:@"result_view"];
//    if (view.mCareerList == NULL) {
//        view.mCareerList = [[NSMutableArray alloc] init];
//        for (NSUInteger i = 0; i < 3 ; i++) {
//            [view.mCareerList addObject:[NSNull null]];
//        }
//        [view.mCareerList replaceObjectAtIndex:0 withObject:[_vc getText]];
//    } else {
//        [view.mCareerList replaceObjectAtIndex:0 withObject:[_vc getText]];
//    }

    [self presentViewController:view animated:YES completion:nil];
}

@end
