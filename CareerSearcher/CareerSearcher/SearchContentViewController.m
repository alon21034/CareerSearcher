//
//  SearchContentViewController.m
//  CareerSearcher
//
//  Created by Lee Haw on 13/8/26.
//  Copyright (c) 2013年 MD631. All rights reserved.
//

#import "SearchContentViewController.h"

@interface SearchContentViewController ()
{
    int mPage;
}
@end

@implementation SearchContentViewController

- (id)initWithPageNumber:(NSUInteger)page
{
    if (self = [super initWithNibName:@"SearchContentViewController" bundle:nil])
    {
        // set parameters for this subview according to page number.

        mPage = page;
        NSLog(@"set page: %d", mPage);        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _mLabel.text = [NSString stringWithFormat:@"page: %d", mPage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
