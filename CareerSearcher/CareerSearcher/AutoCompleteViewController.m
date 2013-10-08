//
//  AutoCompleteViewController.m
//  CareerSearcher
//
//  Created by MD631 on 13/9/28.
//  Copyright (c) 2013年 MD631. All rights reserved.
//

#import "AutoCompleteViewController.h"

@interface AutoCompleteViewController ()

@end

@implementation AutoCompleteViewController

@synthesize mTextField;
@synthesize mTableView;
@synthesize mListData;
@synthesize mIndexData;
@synthesize mDelegate;


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
    
    mTableView.hidden = YES;
    [mDelegate isTableView:(YES)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark TextField
- (IBAction)onTextChanged:(id)sender {
    
    NSLog(@"on text changed");
    
    NSString *myUrlString = @"http://54.251.103.118/MobileJobSearchAPI/FreeKeyReturnJobCat.do";
    NSString *body =  [NSString stringWithFormat:@"jobTitle=%@", mTextField.text];
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
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:nil error:nil];
    
    mListData = dic.allKeys;
    mIndexData = dic.allValues;
    
    [mTableView reloadData];
    
    if (mTextField.text.length == 0) {
        NSLog(@"0");
        mTableView.hidden = YES;
    } else {
        if (mListData.count == 0) {
            mTableView.hidden = YES;
            [mDelegate isTableView:YES];
        } else {
            mTableView.hidden = NO;
            [mDelegate isTableView:NO];
        }
    }
    
}

- (void) setText:(NSString *)str {
    mTextField.text = str;
}

- (void) setHint:(NSString *)str {
    mTextField.placeholder = str;
}

- (NSString*) getText {
    return mTextField.text;
}

- (NSString*) getIndex {
    return _jobIndex;
}

# pragma mark TableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSLog(@"num of rows: %d", [mListData count]);
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",(long)indexPath.row);
    [mTextField setText:[mListData objectAtIndex:indexPath.row]];
    _jobIndex = [mIndexData objectAtIndex:indexPath.row];
    mTableView.hidden = YES;
    [mDelegate isTableView:YES];
}

@end
