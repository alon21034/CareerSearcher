//
//  ViewController.h
//  CareerSearcher
//
//  Created by MD631 on 13/9/28.
//  Copyright (c) 2013年 MD631. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AutoCompleteViewController.h"

@interface ViewController : UIViewController<AutoCompleteViewDelegate>

@property (strong, nonatomic) AutoCompleteViewController *vc;
@property (strong, nonatomic) IBOutlet UIButton *mButton;
- (IBAction)onButtonClicked:(id)sender;

@end
