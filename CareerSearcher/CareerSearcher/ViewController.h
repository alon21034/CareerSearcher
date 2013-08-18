//
//  ViewController.h
//  CareerSearcher
//
//  Created by MD631 on 13/8/18.
//  Copyright (c) 2013年 MD631. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *mCareerTextField;
@property (weak, nonatomic) IBOutlet UITextField *mLocationField;
@property (weak, nonatomic) IBOutlet UIButton *mButton;
@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@property (strong, nonatomic) NSArray *listData;
- (IBAction)onButtonClicked:(id)sender;
- (IBAction)onTextChanged:(id)sender;

@end
