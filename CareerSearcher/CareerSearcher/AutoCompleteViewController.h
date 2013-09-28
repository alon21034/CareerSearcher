//
//  AutoCompleteViewController.h
//  CareerSearcher
//
//  Created by MD631 on 13/9/28.
//  Copyright (c) 2013年 MD631. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AutoCompleteViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITextField *mTextField;
@property (strong, nonatomic) IBOutlet UITableView *mTableView;

@property (strong, nonatomic) NSArray* mListData;

- (IBAction)onTextChanged:(id)sender;

- (void) setText:(NSString*)str;
- (void) setHint:(NSString*)str;
- (NSString*) getText;

@end
