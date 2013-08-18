//
//  SearchViewController.h
//  CareerSearcher
//
//  Created by MD631 on 13/8/18.
//  Copyright (c) 2013年 MD631. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController
- (IBAction)onFinishedButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *mCareerTextField;
@property (weak, nonatomic) IBOutlet UITextField *mLocationTextField;
@property (weak, nonatomic) IBOutlet UIButton *mAddButton;
@property (weak, nonatomic) IBOutlet UILabel *mSearchTerm1;
@property (weak, nonatomic) IBOutlet UILabel *mSearchTerm2;

@property (strong, nonatomic) NSString *searchTermStr1;
@property (strong, nonatomic) NSString *searchTermStr2;
- (IBAction)onAddButtonClicked:(id)sender;

@end
