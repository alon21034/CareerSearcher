//
//  EditStringViewController.m
//  CareerSearcher
//
//  Created by MD631 on 13/9/29.
//  Copyright (c) 2013年 MD631. All rights reserved.
//

#import "EditStringViewController.h"

@interface EditStringViewController ()

@end

@implementation EditStringViewController

@synthesize mStringArray;
@synthesize mLabelArray;
@synthesize mDelegate;
@synthesize mTextField;
@synthesize mTableView;
@synthesize mListData;

CGPoint startPoint;

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
    // Do any additional setup after loading the view from its nib.
    
    if (mStringArray == nil) {
        NSLog(@"arr is null");
    }

    mTableView.hidden = YES;

    mLabelArray = [[NSMutableArray alloc] init];
    [mLabelArray addObject:_mLabel1];
    [mLabelArray addObject:_mLabel2];
    [mLabelArray addObject:_mLabel3];
    [mLabelArray addObject:_mLabel4];
    
    _mLabel1.tag = 0;
    _mLabel2.tag = 1;
    _mLabel3.tag = 2;
    _mLabel4.tag = 3;

    _mLabel1.numberOfLines = 2;
    
    for (int i = 0 ; i < 1 ; i++) {
        if ([mStringArray objectAtIndex:i] != nil) {
            [[mLabelArray objectAtIndex:i] setText:[mStringArray objectAtIndex:i]];
        }
    }


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onBackButtonClicked:(id)sender {
    
    [mDelegate onFinished:mStringArray];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onAddButtonClicked:(id)sender {
    [self addString:mTextField.text];
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


- (IBAction)handlePan:(UIPanGestureRecognizer*)sender {
    [self moveLabel:sender];
}

- (IBAction)handlePan2:(UIPanGestureRecognizer*)sender {
    [self moveLabel:sender];
}

- (IBAction)handlePan3:(UIPanGestureRecognizer*)sender {
    [self moveLabel:sender];
}

- (IBAction)handlePan4:(UIPanGestureRecognizer*)sender {
    [self moveLabel:sender];
}

- (void) addString:(NSString*) str {
    if ([mStringArray objectAtIndex:0] == [NSNull null]) {
        _mLabel1.text = str;
        [mStringArray replaceObjectAtIndex:0 withObject:str];
    } else if ([mStringArray objectAtIndex:1] == [NSNull null]) {
        _mLabel2.text = str;
        [mStringArray replaceObjectAtIndex:1 withObject:str];
    } else if ([mStringArray objectAtIndex:2] == [NSNull null]) {
        _mLabel3.text = str;
        [mStringArray replaceObjectAtIndex:2 withObject:str];
    } else {
        _mLabel4.text = str;
        [mStringArray replaceObjectAtIndex:3 withObject:str];
    }
}

- (void) moveLabel:(UIPanGestureRecognizer*) sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        startPoint.x = sender.view.center.x;
        startPoint.y = sender.view.center.y;
        
        NSLog(@"%d", sender.view.tag);
    }
    
    CGPoint point = [sender translationInView:sender.view];
    
    sender.view.center = CGPointMake(startPoint.x + point.x, startPoint.y + point.y);
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        
        startPoint.x += point.x;
        startPoint.y += point.y;
        
        [self arrangeLabel];
    }
}

- (void) arrangeLabel {
    NSLog(@"re-arrange");
    
//    for (int i = 0 ; i < 4 ; i++) {
//        for (int j = 0 ; j < 4 ; j++) {
//            UILabel *label1 = [mLabelArray objectAtIndex:i];
//            UILabel *label2 = [mLabelArray objectAtIndex:j];
//            
//            if (label1.center.x > label2.center.x) {
//                NSString *temp = [mStringArray objectAtIndex:i];
//                [mStringArray replaceObjectAtIndex:i withObject:[mStringArray objectAtIndex:j]];
//                [mStringArray replaceObjectAtIndex:j withObject:temp];
//            }
//        }
//    }
    
    for (int i = 0 ; i < 4 ; i++) {
        UILabel *label = [mLabelArray objectAtIndex:i];
        label.center = CGPointMake(60+90*i, 120);
    }
    
    [self setText];
}

- (void) setText {
    for (int i = 0 ; i < 4 ; i++) {
        UILabel *label = [mLabelArray objectAtIndex:i];
        
        if ([mStringArray objectAtIndex:i] != [NSNull null]) {
            label.text = [mStringArray objectAtIndex:i];
            label.hidden = NO;
        } else {
            label.text = @"";
            label.hidden = YES;
        }
        
    }
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
