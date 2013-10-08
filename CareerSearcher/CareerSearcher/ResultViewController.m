//
//  ResultViewController.m
//  CareerSearcher
//
//  Created by MD631 on 13/9/28.
//  Copyright (c) 2013年 MD631. All rights reserved.
//

#import "ResultViewController.h"
#import "SearchContentViewController.h"
#import "EditStringViewController.h"
#import "JobDetailViewController.h"

@interface ResultViewController ()

@end

@implementation ResultViewController

@synthesize mTabNum;
@synthesize lineView;
@synthesize mTabButtonArray;
@synthesize mPageControll;
@synthesize mSearchTermList;
@synthesize mSearchIndexList;

int mTabButtonWidth;
int mTabButtonHeight;
const int PADDING = 5;
const int MAX_NUM = 4;
const int BAR_HEIGHT = 44;

const int PAGE_WIDTH = 320;
const int PAGE_HEIGHT = 472;

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
    
    // init search term array
    mSearchTermList = [[NSMutableArray alloc] init];
    mSearchIndexList = [[NSMutableArray alloc] init];
    
    for (int i = 0 ; i < MAX_NUM; i++) {
        [mSearchTermList addObject:[NSNull null]];
        [mSearchIndexList addObject:[NSNull null]];
    }
    
    NSLog(@"start search: %@", _stringFromHomePage);
    if (_stringFromHomePage != NULL) {
        [mSearchTermList replaceObjectAtIndex:0 withObject:_stringFromHomePage];
        [mSearchIndexList replaceObjectAtIndex:0 withObject:_indexFromHomePage];
    }
    
    // create viewcontroller for each page.
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    mTabButtonArray = [[NSMutableArray alloc] init];

    for (NSUInteger i = 0; i < mTabNum; i++)
    {
		[controllers addObject:[NSNull null]];
        [mTabButtonArray addObject:[NSNull null]];
    }
    self.mControllerArray = controllers;
    
    // a page is the width of the scroll view
    self.mScrollView.pagingEnabled = YES;
    
    // (TODO) shouldn't use const here.
    self.mScrollView.contentSize = CGSizeMake(PAGE_WIDTH * mTabNum, PAGE_HEIGHT);
    mTabButtonWidth = 120;
    mTabButtonHeight = 30;
    
    self.mScrollView.showsHorizontalScrollIndicator = YES;
    self.mScrollView.showsVerticalScrollIndicator = NO;
    self.mScrollView.scrollsToTop = NO;
    self.mScrollView.delegate = self;
    
    self.mPageControll.numberOfPages = mTabNum;
    self.mPageControll.currentPage = 0;
    
    // start to draw tab button and bottom line
    NSLog(@"tab num: %d", mTabNum);
    
    for (int i = 0 ; i < mTabNum ; i++) {
        [self addButton:[mSearchTermList objectAtIndex:i]
                       :PADDING+i*(mTabButtonWidth + PADDING) :BAR_HEIGHT + PADDING
                       :mTabButtonWidth :mTabButtonHeight :i];
    }
    
    // bottom line
    lineView = [[UIView alloc] initWithFrame:
                CGRectMake(PADDING, BAR_HEIGHT + mTabButtonHeight, mTabButtonWidth, PADDING)];
    lineView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:lineView];
    
    
    [self loadScrollViewWithPage:0 :[mSearchTermList objectAtIndex:0] :[mSearchIndexList objectAtIndex:0]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addButton:(NSString*)title :(float)x :(float)y :(float)width :(float)height :(int)index{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self action:@selector(onTabButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [button setTitle:title forState:UIControlStateNormal];
    button.frame = CGRectMake(x, y, width, height);
    button.tag = index;
    
    [self.view addSubview:button];
    [mTabButtonArray replaceObjectAtIndex:index withObject:button];
    
}

- (void) onTabButtonClicked:(UIButton*) sender {
    NSLog(@"tab button %d is pressed", sender.tag);
}

#pragma mark ScrollViewDelegate

- (void)loadScrollViewWithPage:(NSUInteger)page :(NSString*) str :(NSString*) index;
{
    if (page >= mTabNum)
        return;
    
    // replace the placeholder if necessary
    SearchContentViewController *controller = [self.mControllerArray objectAtIndex:page];
    if ((NSNull *)controller == [NSNull null])
    {
        controller = [[SearchContentViewController alloc] initWithString:str :index];
        controller.jobIndex = index;
        [self.mControllerArray replaceObjectAtIndex:page withObject:controller];
    }
    
    // add the controller's view to the scroll view
    if (controller.view.superview == nil)
    {
        CGRect frame = self.mScrollView.frame;
        frame.origin.x = PAGE_WIDTH * page;
        frame.origin.y = 0;
        controller.view.frame = frame;
        controller.mDelegate = self;
        
        [self addChildViewController:controller];
        [self.mScrollView addSubview:controller.view];
        [controller didMoveToParentViewController:self];
        
        //controller.mLabel.text = [NSString stringWithFormat:@"PAGE %d", page];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = CGRectGetWidth(self.mScrollView.frame);
    NSUInteger page = floor((self.mScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    //    self.mPageControl.currentPage = page;
    
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    if (page > 0)
        [self loadScrollViewWithPage:page - 1 :[mSearchTermList objectAtIndex:page-1] :[mSearchIndexList objectAtIndex:page-1]];
    
    [self loadScrollViewWithPage:page :[mSearchTermList objectAtIndex:page] :[mSearchIndexList objectAtIndex:page]];
    
    if (page < mTabNum)
        [self loadScrollViewWithPage:page + 1 :[mSearchTermList objectAtIndex:page+1] :[mSearchIndexList objectAtIndex:page+1]];
    
    // a possible optimization would be to unload the views+controllers which are no longer visible
}

- (IBAction)onNextButtonClicked:(id)sender {
    EditStringViewController *view = [[EditStringViewController alloc] initWithNibName:@"EditStringViewController" bundle:nil];
    
    if([mSearchTermList objectAtIndex:0] != [NSNull null]) {
        view.str1 = [mSearchTermList objectAtIndex:0];
    } else {
        view.str1 = @"";
    }
    if([mSearchTermList objectAtIndex:1] != [NSNull null]) {
        view.str2 = [mSearchTermList objectAtIndex:1];
    } else {
        view.str2 = @"";
    }
    if([mSearchTermList objectAtIndex:2] != [NSNull null]) {
        view.str3 = [mSearchTermList objectAtIndex:2];
    } else {
        view.str3 = @"";
    }
    if([mSearchTermList objectAtIndex:3] != [NSNull null]) {
        view.str4 = [mSearchTermList objectAtIndex:3];
    } else {
        view.str4 = @"";
    }
    
    view.index1 = [mSearchIndexList objectAtIndex:0];
    view.index2 = [mSearchIndexList objectAtIndex:1];
    view.index3 = [mSearchIndexList objectAtIndex:2];
    view.index4 = [mSearchIndexList objectAtIndex:3];
    
    view.mDelegate = self;
    [self presentViewController:view animated:YES completion:nil];
}

- (void) onFinished:(NSMutableArray *)arr :(NSMutableArray*) indexList{
    mTabNum = 0;
    for (int i = 0 ; i < arr.count ; i++) {
        if ([[arr objectAtIndex:i] length] == 0) {
            [arr replaceObjectAtIndex:i withObject:[NSNull null]];
        }
        [mSearchTermList replaceObjectAtIndex:i withObject:[arr objectAtIndex:i]];
        [mSearchIndexList replaceObjectAtIndex:i withObject:[indexList objectAtIndex:i]];
        if ([mSearchTermList objectAtIndex:i] != [NSNull null])
            mTabNum++;
    }
    
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    mTabButtonArray = [[NSMutableArray alloc] init];
    
    for (NSUInteger i = 0; i < mTabNum; i++)
    {
		[controllers addObject:[NSNull null]];
        [mTabButtonArray addObject:[NSNull null]];
    }
    self.mControllerArray = controllers;
    
    // a page is the width of the scroll view
    self.mScrollView.pagingEnabled = YES;
    
    // (TODO) shouldn't use const here.
    self.mScrollView.contentSize = CGSizeMake(PAGE_WIDTH * mTabNum, PAGE_HEIGHT);
    mTabButtonWidth = 120;
    mTabButtonHeight = 30;
    
    self.mScrollView.showsHorizontalScrollIndicator = YES;
    self.mScrollView.showsVerticalScrollIndicator = NO;
    self.mScrollView.scrollsToTop = NO;
    self.mScrollView.delegate = self;
    
    self.mPageControll.numberOfPages = mTabNum;
    self.mPageControll.currentPage = 0;
    
    // start to draw tab button and bottom line
    NSLog(@"tab num: %d", mTabNum);
    
    for (int i = 0 ; i < mTabNum ; i++) {
        [self addButton:[mSearchTermList objectAtIndex:i]
                       :PADDING+i*(mTabButtonWidth + PADDING) :BAR_HEIGHT + PADDING
                       :mTabButtonWidth :mTabButtonHeight :i];
    }

    // bottom line
    lineView = [[UIView alloc] initWithFrame:
                CGRectMake(PADDING, BAR_HEIGHT + mTabButtonHeight, mTabButtonWidth, PADDING)];
    lineView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:lineView];

    [self loadScrollViewWithPage:0 :[mSearchTermList objectAtIndex:0] :[mSearchIndexList objectAtIndex:0]];
    
}

#pragma mark SearchContentDelegate

- (void) onItemSelected:(NSData *)data :(int) index {
    NSArray *jobList = [NSJSONSerialization JSONObjectWithData:data options:nil error:nil];
    
    
    NSDictionary *item = [jobList objectAtIndex:index];
    
    JobDetailViewController *view = [[JobDetailViewController alloc] initWithNibName:@"JobDetailViewController" bundle:nil];
    
    view.data = item;
    view.jobList = jobList;
    
    [self presentViewController:view animated:YES completion:nil];
}


@end
