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
@synthesize mJobDetailArr;
@synthesize mDelegate;
@synthesize data;

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
    
    mListData = [[NSMutableArray alloc] init];
    mJobDetailArr = [[NSMutableArray alloc] init];
    NSString *myUrlString = @"http://54.251.103.118/MobileJobSearchAPI/JobCatAreaReturnJob.do?jobCat=2002001012&area=%E5%8F%B0%E5%8C%97%E5%B8%82";
    //NSString *body =  [NSString stringWithFormat:@"jobCat=%@&area=%@", @"2002001012", @"%E5%8F%B0%E5%8C%97%E5%B8%82"];
    NSURL *myUrl = [NSURL URLWithString:myUrlString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:myUrl];
    [request setTimeoutInterval:30.0f];
    [request setHTTPMethod:@"POST"];
    //[request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSError *error = nil;
    NSHTTPURLResponse *response = nil;
    data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSString *ret = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"Json = %@", ret);
    
    NSArray *jobList = [NSJSONSerialization JSONObjectWithData:data options:nil error:nil];
    
    for (NSDictionary *item in jobList) {
        NSLog(@"Item: %@", [item valueForKey:@"JOB"]);
        [mListData addObject:[item valueForKey:@"JOB"]];
        [mJobDetailArr addObject:[item valueForKey:@"DESCRIPTION"]];
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:tableIdentifier];
    }
    
    NSUInteger row = [indexPath row];
    cell.textLabel.text = [mListData objectAtIndex:row];
    cell.detailTextLabel.text = [mJobDetailArr objectAtIndex:row];
    [cell.imageView setFrame:CGRectMake(0, 0, 30, 30)];
    [cell.imageView setImage:[self imageFromColor:[UIColor blueColor]]];
    
    cell.backgroundColor = [UIColor greenColor];

    
    return cell;
}

- (UIImage *)imageFromColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 30, 30);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"select: %d", indexPath.row);
    [mDelegate selectJob:data :indexPath.row];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
