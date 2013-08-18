//
//  ResultViewController.h
//  CareerSearcher
//
//  Created by MD631 on 13/8/18.
//  Copyright (c) 2013年 MD631. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) NSString *mCareer;
@property (weak, nonatomic) NSString *mLocation;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *mBackButton;
@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@property (strong, nonatomic) NSMutableArray *mResults;
- (IBAction)onBackButtonPressed:(id)sender;

@end
