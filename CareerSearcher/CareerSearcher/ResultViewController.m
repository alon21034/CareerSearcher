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

@interface ResultViewController ()

@end

@implementation ResultViewController

@synthesize mTabNum;
@synthesize lineView;
@synthesize mTabButtonArray;
@synthesize mPageControll;
@synthesize mSearchTermList;

int mTabButtonWidth;
int mTabButtonHeight;
const int PADDING = 5;
const int MAX_NUM = 4;
const int BAR_HEIGHT = 44;

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
    
    for (int i = 0 ; i < MAX_NUM; i++) {
        [mSearchTermList addObject:[NSNull null]];
    }
    
    NSLog(@"start search: %@", _stringFromHomePage);
    if (_stringFromHomePage != NULL)
        [mSearchTermList replaceObjectAtIndex:0 withObject:_stringFromHomePage];
    
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
    self.mScrollView.contentSize = CGSizeMake(280 * mTabNum, 420);
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

- (void)loadScrollViewWithPage:(NSUInteger)page :(NSString*) str;
{
    if (page >= mTabNum)
        return;
    
    // replace the placeholder if necessary
    SearchContentViewController *controller = [self.mControllerArray objectAtIndex:page];
    if ((NSNull *)controller == [NSNull null])
    {
        controller = [[SearchContentViewController alloc] initWithString:str];
        [self.mControllerArray replaceObjectAtIndex:page withObject:controller];
    }
    
    // add the controller's view to the scroll view
    if (controller.view.superview == nil)
    {
        CGRect frame = self.mScrollView.frame;
        frame.origin.x = 280 * page;
        frame.origin.y = 0;
        controller.view.frame = frame;
        
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
        [self loadScrollViewWithPage:page - 1 :[mSearchTermList objectAtIndex:page-1]];
    
    [self loadScrollViewWithPage:page :[mSearchTermList objectAtIndex:page]];
    
    if (page < mTabNum)
        [self loadScrollViewWithPage:page + 1 :[mSearchTermList objectAtIndex:page+1]];
    
    // a possible optimization would be to unload the views+controllers which are no longer visible
}

- (IBAction)onNextButtonClicked:(id)sender {
    EditStringViewController *view = [[EditStringViewController alloc] initWithNibName:@"EditStringViewController" bundle:nil];
    view.mStringArray = mSearchTermList;
    view.mDelegate = self;
    [self presentViewController:view animated:YES completion:nil];
}

- (void) onFinished:(NSMutableArray *)arr {
    mTabNum = 0;
    for (int i = 0 ; i < arr.count ; i++) {
        [mSearchTermList replaceObjectAtIndex:i withObject:[arr objectAtIndex:i]];
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
    self.mScrollView.contentSize = CGSizeMake(280 * mTabNum, 420);
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

}

@end
