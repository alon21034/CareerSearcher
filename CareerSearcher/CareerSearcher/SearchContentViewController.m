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

@synthesize mListData;

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
    
    mListData = [[NSMutableArray alloc] init];
    NSString *myUrlString = @"http://54.251.103.118/MobileJobSearchAPI/JobCatAreaReturnJob.do";
    NSString *body =  [NSString stringWithFormat:@"jobTitle=%@&area=%@", @"aaa", @"bbb"];
    NSURL *myUrl = [NSURL URLWithString:myUrlString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:myUrl];
    [request setTimeoutInterval:30.0f];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSError *error = nil;
    NSHTTPURLResponse *response = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSString *ret = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"json = %@", ret);
    
    NSArray *jobList = [NSJSONSerialization JSONObjectWithData:data options:nil error:nil];
    
    for (NSDictionary *item in jobList) {
        NSLog(@"Item: %@", [item valueForKey:@"JOB"]);
        [mListData addObject:[item valueForKey:@"JOB"]];
    }
    [_mTableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [mListData count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *tableIdentifier = @"Simple table";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }
    
    NSUInteger row = [indexPath row];
    cell.textLabel.text = [mListData objectAtIndex:row];
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
