//
//  SearchContentViewController.h
//  CareerSearcher
//
//  Created by Lee Haw on 13/8/26.
//  Copyright (c) 2013年 MD631. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchContentViewController : UIViewController

- (id)initWithPageNumber:(NSUInteger)page;
@property (strong, nonatomic) IBOutlet UILabel *mLabel;

@end
