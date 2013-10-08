//
//  EditStringViewController.h
//  CareerSearcher
//
//  Created by MD631 on 13/9/29.
//  Copyright (c) 2013年 MD631. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EditStringDelegate <NSObject>

- (void) onFinished:(NSMutableArray*)arr :(NSMutableArray*) indexList;

@end

@interface EditStringViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *mStringArray;
@property (strong, nonatomic) NSMutableArray *mIndexArray;
@property (strong, nonatomic) NSMutableArray *mLabelArray;
@property (strong, nonatomic) NSArray *mListData;
@property (strong, nonatomic) NSArray *mIndexData;
@property (strong, nonatomic) NSString *mItemIndex;
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

@property (assign, nonatomic) NSString* str1;
@property (assign, nonatomic) NSString* str2;
@property (assign, nonatomic) NSString* str3;
@property (assign, nonatomic) NSString* str4;

@property (assign, nonatomic) NSString* index1;
@property (assign, nonatomic) NSString* index2;
@property (assign, nonatomic) NSString* index3;
@property (assign, nonatomic) NSString* index4;


@end
