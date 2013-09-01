//
//  SearchContentViewController.h
//  CareerSearcher
//
//  Created by Lee Haw on 13/8/26.
//  Copyright (c) 2013年 MD631. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectJobDelegate <NSObject>

-(void)selectJob:(NSString*)index;

@end

@interface SearchContentViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

- (id)initWithPageNumber:(NSUInteger)page;

@property (strong, nonatomic) IBOutlet UITableView *mTableView;
@property (strong, nonatomic) NSMutableArray *mListData;
@property (strong, nonatomic) NSMutableArray *mJobDetailArr;

@property (assign, nonatomic) id<SelectJobDelegate> mDelegate;

@end
