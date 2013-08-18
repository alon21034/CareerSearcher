//
//  ViewController.h
//  CareerSearcher
//
//  Created by MD631 on 13/8/18.
//  Copyright (c) 2013年 MD631. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *mCareerTextField;
@property (weak, nonatomic) IBOutlet UITextField *mLocationField;
@property (weak, nonatomic) IBOutlet UIButton *mButton;
- (IBAction)onButtonClicked:(id)sender;

@end
