//
//  SearchViewController.h
//  CareerSearcher
//
//  Created by MD631 on 13/8/18.
//  Copyright (c) 2013年 MD631. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SearchViewDelegate <NSObject>

-(void)searchViewDismissed:(NSString*)str;

@end

@interface SearchViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
- (IBAction)onFinishedButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *mCareerTextField;
@property (weak, nonatomic) IBOutlet UITextField *mLocationTextField;
@property (weak, nonatomic) IBOutlet UIButton *mAddButton;
@property (strong, nonatomic) IBOutlet UITableView *mTableView;
@property (strong, nonatomic) NSArray *listData;

@property (weak, nonatomic) NSMutableArray* mSearchTermArr;

- (IBAction)onAddButtonClicked:(id)sender;

- (IBAction)onTextChanged:(id)sender;
@property (assign, nonatomic) id<SearchViewDelegate> mDelegate;

@property (strong, nonatomic) NSMutableArray *mCareerTermArr;
@property (strong, nonatomic) IBOutlet UIButton *mButton1;
@property (strong, nonatomic) IBOutlet UIButton *mButton2;
@property (strong, nonatomic) IBOutlet UIButton *mButton3;

@end
