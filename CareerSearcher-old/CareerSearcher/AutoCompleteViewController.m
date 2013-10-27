//
//  AutoCompleteViewController.m
//  CareerSearcher
//
//  Created by MD631 on 13/9/15.
//  Copyright (c) 2013年 MD631. All rights reserved.
//

#import "AutoCompleteViewController.h"

@interface AutoCompleteViewController ()

@end

@implementation AutoCompleteViewController

@synthesize mTextField;
@synthesize mTableView;
@synthesize mListData;

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
    
    mTextField.placeholder = @"職務名稱";
    mTableView.hidden = YES;
	// Do any additional setup after loading the view.
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
    [mTableView reloadData];
    
    if (mTextField.text.length == 0) {
        NSLog(@"0");
        mTableView.hidden = YES;
    } else {
        if (mListData.count == 0) {
            mTableView.hidden = YES;
        } else {
            mTableView.hidden = NO;
        }
    }
    
}

-(NSString*) getText {
    return mTextField.text;
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
    mTableView.hidden = YES;
}

@end
