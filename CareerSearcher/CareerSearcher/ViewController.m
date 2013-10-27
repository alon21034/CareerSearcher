//
//  ViewController.m
//  CareerSearcher
//
//  Created by MD631 on 13/9/28.
//  Copyright (c) 2013年 MD631. All rights reserved.
//

#import "ViewController.h"
#import "ResultViewController.h"
#import "MBProgressHUD.h"

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
    vc.mDelegate = self;
    
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
    view.indexFromHomePage = [vc getIndex];
    
    if ([vc getIndex] == nil) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
        // Configure for text only and offset down
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"Please enter a job.";
        hud.margin = 10.f;
        hud.yOffset = 150.f;
        hud.removeFromSuperViewOnHide = YES;
    
        [hud hide:YES afterDelay:3];
    } else {
        [self presentViewController:view animated:YES completion:nil];
    }
}

- (void) isTableView:(BOOL)isShow {
    NSLog(@"is table view show");
    mButton.hidden = !isShow;
}

@end
