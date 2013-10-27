//
//  ViewController.h
//  CareerSearcher
//
//  Created by MD631 on 13/8/18.
//  Copyright (c) 2013年 MD631. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AutoCompleteViewController.h"

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIButton *mButton;
@property (strong, nonatomic) AutoCompleteViewController *vc;

@property (strong, nonatomic) IBOutlet UIView *mCareerACTextField;
@property (strong, nonatomic) IBOutlet UITextField *mLocationTextField;

- (IBAction)onButtonClicked:(id)sender;

@end
