//
//  SearchContentViewController.h
//  CareerSearcher
//
//  Created by MD631 on 13/9/28.
//  Copyright (c) 2013年 MD631. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchContentViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

- (id)initWithString:(NSString*)str :(NSString*)index;
@property (strong, nonatomic) IBOutlet UITableView *mTableView;
@property (strong, nonatomic) NSMutableArray *mListData;
@property (strong, nonatomic) NSMutableArray *mJobDetailArr;
@property (strong, nonatomic) NSData *data;

@property (assign, nonatomic) NSString* jobIndex;

@end
