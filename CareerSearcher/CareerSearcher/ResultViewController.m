//
//  ResultViewController.m
//  CareerSearcher
//
//  Created by MD631 on 13/8/18.
//  Copyright (c) 2013年 MD631. All rights reserved.
//

#import "ResultViewController.h"

@interface ResultViewController ()

@end

@implementation ResultViewController

@synthesize mResults;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    mResults = [[NSMutableArray alloc] init];
    NSString *myUrlString = @"http://54.251.103.118/MobileJobSearchAPI/JobCatAreaReturnJob.do";
    NSString *body =  [NSString stringWithFormat:@"jobTitle=%@&area=%@", _mCareer, _mLocation];
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
        [mResults addObject:[item valueForKey:@"JOB"]];
    }
    
    [_mTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onBackButtonPressed:(id)sender {
    
}

# pragma mark TableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSLog(@"num of rows: %ld", (unsigned long)[mResults count]);
    return [mResults count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *tableIdentifier = @"Simple table";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }
    
    NSUInteger row = [indexPath row];
    cell.textLabel.text = [mResults objectAtIndex:row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",(long)indexPath.row);
}

@end
