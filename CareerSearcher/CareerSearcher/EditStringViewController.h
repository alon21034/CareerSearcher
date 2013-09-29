//
//  EditStringViewController.h
//  CareerSearcher
//
//  Created by MD631 on 13/9/29.
//  Copyright (c) 2013年 MD631. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EditStringDelegate <NSObject>

- (void) onFinished:(NSMutableArray*) arr;

@end

@interface EditStringViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (assign, nonatomic) NSMutableArray *mStringArray;
@property (strong, nonatomic) NSMutableArray *mLabelArray;
@property (strong, nonatomic) NSArray *mListData;
@property (assign, nonatomic) id<EditStringDelegate> mDelegate;

@property (strong, nonatomic) IBOutlet UILabel *mLabel1;
@property (strong, nonatomic) IBOutlet UILabel *mLabel2;
@property (strong, nonatomic) IBOutlet UILabel *mLabel3;
@property (strong, nonatomic) IBOutlet UILabel *mLabel4;
@property (strong, nonatomic) IBOutlet UITextField *mTextField;
@property (strong, nonatomic) IBOutlet UITableView *mTableView;
- (IBAction)onBackButtonClicked:(id)sender;
- (IBAction)onAddButtonClicked:(id)sender;
- (IBAction)onTextChanged:(id)sender;


- (IBAction)handlePan:(UIPanGestureRecognizer*)sender;
- (IBAction)handlePan2:(UIPanGestureRecognizer*)sender;
- (IBAction)handlePan3:(UIPanGestureRecognizer*)sender;
- (IBAction)handlePan4:(UIPanGestureRecognizer*)sender;


@end
