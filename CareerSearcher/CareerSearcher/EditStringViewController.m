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
@synthesize mIndexArray;
@synthesize mItemIndex;
@synthesize mIndexData;

CGPoint startPoint;
int selectedItem;
int releasePlace;

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
    
    mStringArray = [[NSMutableArray alloc] init];
    [mStringArray addObject:_str1];
    [mStringArray addObject:_str2];
    [mStringArray addObject:_str3];
    [mStringArray addObject:_str4];
    
    mIndexArray = [[NSMutableArray alloc] init];
    [mIndexArray addObject:_index1];
    [mIndexArray addObject:_index2];
    [mIndexArray addObject:_index3];
    [mIndexArray addObject:_index4];
    
    [self arrangeLabel];
    [self arrangeText];
    [self setText];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) moveLabel:(UIPanGestureRecognizer*) sender {
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        startPoint.x = sender.view.center.x;
        startPoint.y = sender.view.center.y;
    }
    
    CGPoint point = [sender translationInView:sender.view];
    
    sender.view.center = CGPointMake(startPoint.x + point.x, startPoint.y + point.y);
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        
        startPoint.x += point.x;
        startPoint.y += point.y;
        
        
        [self arrangeText];
        [self setText];
        [self arrangeLabel];
        
    }
}

- (void) arrangeLabel {
    [self setLabelLocation:_mLabel1 :20 :120];
    [self setLabelLocation:_mLabel2 :100 :120];
    [self setLabelLocation:_mLabel3 :180 :120];
    [self setLabelLocation:_mLabel4 :260 :120];
}

- (void) setLabelLocation:(UILabel*)label :(float)x :(float)y {
    label.center = CGPointMake(x, y);
}

- (void) arrangeText {
    float arr[4];
    int res[4] = {0,0,0,0};
    
    arr[0] = _mLabel1.center.x;
    arr[1] = _mLabel2.center.x;
    arr[2] = _mLabel3.center.x;
    arr[3] = _mLabel4.center.x;
    
    res[0] = 0;
    
    for (int i = 0 ; i < 4 ; i++) {
        if (i == 0) {
            res[0] = 0;
        } else {
            res[i] = 0;
            for (int j = 0 ; j < i ; j++) {
                if (arr[i] < arr[j]) {
                    res[j]++;
                } else {
                    res[i]++;
                }
            }
        }
    }
    
    NSLog(@"%f %f %f %f", arr[0], arr[1], arr[2], arr[3]);
    NSLog(@"%d %d %d %d", res[0], res[1], res[2], res[3]);
    
    NSString* a = [mStringArray objectAtIndex:0];
    NSString* b = [mStringArray objectAtIndex:1];
    NSString* c = [mStringArray objectAtIndex:2];
    NSString* d = [mStringArray objectAtIndex:3];
    
    [mStringArray replaceObjectAtIndex:res[0] withObject:a];
    [mStringArray replaceObjectAtIndex:res[1] withObject:b];
    [mStringArray replaceObjectAtIndex:res[2] withObject:c];
    [mStringArray replaceObjectAtIndex:res[3] withObject:d];
    
    a = [mIndexArray objectAtIndex:0];
    b = [mIndexArray objectAtIndex:1];
    c = [mIndexArray objectAtIndex:2];
    d = [mIndexArray objectAtIndex:3];
    
    [mIndexArray replaceObjectAtIndex:res[0] withObject:a];
    [mIndexArray replaceObjectAtIndex:res[1] withObject:b];
    [mIndexArray replaceObjectAtIndex:res[2] withObject:c];
    [mIndexArray replaceObjectAtIndex:res[3] withObject:d];
    
}

- (void) setText {
    [self setLabelText:_mLabel1 :0];
    [self setLabelText:_mLabel2 :1];
    [self setLabelText:_mLabel3 :2];
    [self setLabelText:_mLabel4 :3];
}

- (void) setLabelText :(UILabel*)label :(int)index {
    if ([[mStringArray objectAtIndex:index] length] != 0) {
        NSLog(@"set text%d:%@", index, [mStringArray objectAtIndex:index]);
        label.text = [mStringArray objectAtIndex:index];
    }
}

- (void) addString:(NSString*)str :(NSString*) index {
    for (int i = 0 ; i < 4 ; i++ ) {
        if ([[mStringArray objectAtIndex:i] length] == 0) {
            [mStringArray replaceObjectAtIndex:i withObject:str];
            [mIndexArray replaceObjectAtIndex:i withObject:index];
            break;
        }
    }
    [self setText];
}

#pragma mark listeners

- (IBAction)handlePan:(UIPanGestureRecognizer *)sender {
    [self moveLabel:sender];
}

- (IBAction)handlePan2:(UIPanGestureRecognizer *)sender {
    [self moveLabel:sender];
}

- (IBAction)handlePan3:(UIPanGestureRecognizer *)sender {
    [self moveLabel:sender];
}

- (IBAction)handlePan4:(UIPanGestureRecognizer *)sender {
    [self moveLabel:sender];
}

- (IBAction)onAddButtonClicked:(id)sender {
    [self addString:mTextField.text :mItemIndex];
}

- (IBAction)onBackButtonClicked:(id)sender {
    [mDelegate onFinished:mStringArray :mIndexArray];
    [self dismissViewControllerAnimated:YES completion:nil];
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
        } else {
            mTableView.hidden = NO;
        }
    }
    
    [self arrangeLabel];
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
    mItemIndex = [mIndexData objectAtIndex:indexPath.row];
    mTableView.hidden = YES;
}

@end
