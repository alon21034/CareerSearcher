//
//  ViewController.m
//  CareerSearcher
//
//  Created by MD631 on 13/8/18.
//  Copyright (c) 2013年 MD631. All rights reserved.
//

#import "ViewController.h"
#import "ResultViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize listData;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _mCareerTextField.placeholder = @"職務名稱";
    _mLocationField.placeholder = @"所在地區";
    
    _mTableView.hidden = YES;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Button
- (IBAction)onButtonClicked:(id)sender {
    ResultViewController *view= [self.storyboard instantiateViewControllerWithIdentifier:@"result_view"];
    if (view.mCareerList == NULL) {
        view.mCareerList = [[NSMutableArray alloc] init];
        for (NSUInteger i = 0; i < 3 ; i++) {
            [view.mCareerList addObject:[NSNull null]];
        }
        [view.mCareerList replaceObjectAtIndex:0 withObject:_mCareerTextField.text];
    } else {
        [view.mCareerList replaceObjectAtIndex:0 withObject:_mCareerTextField.text];
    }

    [self presentViewController:view animated:YES completion:nil];
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
    [_mTableView reloadData];
    
    if (_mCareerTextField.text.length == 0) {
        NSLog(@"0");
        _mTableView.hidden = YES;
    } else {
        if (listData.count == 0) {
            _mTableView.hidden = YES;
        } else {
            _mTableView.hidden = NO;
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
    _mTableView.hidden = YES;
}

@end
