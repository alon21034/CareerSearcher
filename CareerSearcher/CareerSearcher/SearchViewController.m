//
//  SearchViewController.m
//  CareerSearcher
//
//  Created by MD631 on 13/8/18.
//  Copyright (c) 2013年 MD631. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

@synthesize mDelegate;
@synthesize mTableView;
@synthesize listData;

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
    
    _mCareerTextField.placeholder = @"職務名稱";
    _mLocationTextField.placeholder = @"所在地區";
    
    mTableView.hidden = YES;
    
    if ([_mCareerTermArr objectAtIndex:0] == [NSNull null]) {
        _mButton1.hidden = YES;
    } else {
        _mButton1.hidden = NO;
        [_mButton1 setTitle:[_mCareerTermArr objectAtIndex:0] forState:UIControlStateNormal];
    }
    
    if ([_mCareerTermArr objectAtIndex:1] == [NSNull null]) {
        _mButton2.hidden = YES;
    } else {
        _mButton2.hidden = NO;
        [_mButton2 setTitle:[_mCareerTermArr objectAtIndex:1] forState:UIControlStateNormal];
    }
    
    if ([_mCareerTermArr objectAtIndex:2] == [NSNull null]) {
        _mButton3.hidden = YES;
    } else {
        _mButton3.hidden = NO;
        [_mButton3 setTitle:[_mCareerTermArr objectAtIndex:2] forState:UIControlStateNormal];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onFinishedButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    [mDelegate searchViewDismissed:_mCareerTextField.text];
}
- (IBAction)onAddButtonClicked:(id)sender {

}

- (void) updateSearchTerm {
    
}

#pragma mark TextField
- (IBAction)onTextChanged:(id)sender {
    
    NSString *myUrlString = @"http://54.251.103.118/MobileJobSearchAPI/FreeKeyReturnJobCat.do";
    NSString *body =  [NSString stringWithFormat:@"jobTitle=%@", _mCareerTextField.text];
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
    
    listData = dic.allKeys;
    [mTableView reloadData];
    
    if (_mCareerTextField.text.length == 0) {
        NSLog(@"0");
        mTableView.hidden = YES;
    } else {
        if (listData.count == 0) {
            mTableView.hidden = YES;
        } else {
            mTableView.hidden = NO;
        }
    }
    
}

# pragma mark TableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSLog(@"num of rows");
    return [listData count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *tableIdentifier = @"Simple table";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }
    
    NSUInteger row = [indexPath row];
    cell.textLabel.text = [listData objectAtIndex:row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",(long)indexPath.row);
    [_mCareerTextField setText:[listData objectAtIndex:indexPath.row]];
    mTableView.hidden = YES;
}

@end
