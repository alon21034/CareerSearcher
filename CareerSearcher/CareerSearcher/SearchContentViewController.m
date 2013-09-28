//
//  SearchContentViewController.m
//  CareerSearcher
//
//  Created by MD631 on 13/9/28.
//  Copyright (c) 2013年 MD631. All rights reserved.
//

#import "SearchContentViewController.h"

@interface SearchContentViewController ()

@end

@implementation SearchContentViewController

- (id)initWithString:(NSString*) str
{
    if (self = [super initWithNibName:@"SearchContentViewController" bundle:nil])
    {
        // set parameters for this subview according to page number.
        NSLog(@"search term is: %@", str);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
