//
//  ResultViewController.m
//  CareerSearcher
//
//  Created by MD631 on 13/8/18.
//  Copyright (c) 2013年 MD631. All rights reserved.
//

#import "ResultViewController.h"
#import "JobDetailViewController.h"
#import "SearchViewController.h"
#import "SearchContentViewController.h"

@interface ResultViewController ()
{
    int pageNum;
    int pageWidth;
    int pageHeight;
}

@end

@implementation ResultViewController

@synthesize mScrollView;
@synthesize mPageControl;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)reloadPages
{
    // set scroll view
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    for (NSUInteger i = 0; i < pageNum; i++)
    {
		[controllers addObject:[NSNull null]];
    }
    self.mControllersArray = controllers;
    
    // a page is the width of the scroll view
    self.mScrollView.pagingEnabled = YES;
    self.mScrollView.contentSize =
    CGSizeMake(pageWidth * pageNum, pageHeight);
    self.mScrollView.showsHorizontalScrollIndicator = YES;
    self.mScrollView.showsVerticalScrollIndicator = YES;
    self.mScrollView.scrollsToTop = NO;
    self.mScrollView.delegate = self;
    
    [self loadScrollViewWithPage:0];
    [self loadScrollViewWithPage:1];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    

    // set params
    if  (_mCareerList == NULL) {
        _mCareerList = [[NSMutableArray alloc] init];
        for (NSUInteger i = 0; i < 3 ; i++) {
            [_mCareerList addObject:[NSNull null]];
        }
    }
    
    pageNum = 1;
    pageWidth = 320;
    pageHeight = 452;
    
    [self setButtonTitle];
    
    // set pageControl
    [mPageControl setNumberOfPages:pageNum];
    
    
    [self reloadPages];
    
}

- (void)loadScrollViewWithPage:(NSUInteger)page
{
    if (page >= pageNum)
        return;
    
    NSLog(@"load page: %d", page);
    
    // replace the placeholder if necessary
    SearchContentViewController *controller = [self.mControllersArray objectAtIndex:page];
    if ((NSNull *)controller == [NSNull null])
    {
        controller = [[SearchContentViewController alloc] initWithPageNumber:page];
        [self.mControllersArray replaceObjectAtIndex:page withObject:controller];
        controller.mDelegate = self;
    }
    
    // add the controller's view to the scroll view
    if (controller.view.superview == nil)
    {
        CGRect frame = self.mScrollView.frame;
        frame.origin.x = pageWidth * page;
        frame.origin.y = 0;
        controller.view.frame = frame;
        
        [self addChildViewController:controller];
        [self.mScrollView addSubview:controller.view];
        [controller didMoveToParentViewController:self];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark scrollview

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // switch the indicator when more than 50% of the previous/next page is visible
    CGFloat width = CGRectGetWidth(self.mScrollView.frame);
    NSUInteger page = floor((self.mScrollView.contentOffset.x - width / 2) / width) + 1;
    self.mPageControl.currentPage = page;
    
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    
    // a possible optimization would be to unload the views+controllers which are no longer visible
}

- (void)gotoPage:(BOOL)animated
{
    NSInteger page = self.mPageControl.currentPage;
 
    //[self highlightButton:page];
    
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    
	// update the scroll view to the appropriate page
    CGRect bounds = self.mScrollView.bounds;
    bounds.origin.x = pageWidth * page;
    bounds.origin.y = 0;
    [self.mScrollView scrollRectToVisible:bounds animated:animated];
}

- (IBAction)changePage:(id)sender
{
    [self gotoPage:YES];    // YES = animate
}

#pragma mark change_btns

- (void)setButtonTitle {
    NSLog(@"setButtonTitle");
    pageNum = 1;
    [_mButton1 setTitle:[_mCareerList objectAtIndex:0] forState:UIControlStateNormal];
    
    if ([_mCareerList objectAtIndex:1] == [NSNull null]) {
        [_mButton2 setHidden:YES];
    } else {
        [_mButton2 setTitle:[_mCareerList objectAtIndex:1] forState:UIControlStateNormal];
        [_mButton2 setHidden:NO];
        pageNum++;
    }
    
    if ([_mCareerList objectAtIndex:2] == [NSNull null]) {
        [_mButton3 setHidden:YES];
    } else {
        [_mButton3 setTitle:[_mCareerList objectAtIndex:2] forState:UIControlStateNormal];
        [_mButton3 setHidden:NO];
        pageNum++;
    }
}

#pragma mark onClick

- (IBAction)onBackButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onNextButtonPressed:(id)sender {
    SearchViewController *searchView = [self.storyboard instantiateViewControllerWithIdentifier:@"search_view"];
    searchView.mDelegate = self;
    [self presentViewController:searchView animated:YES completion:nil];
}

- (IBAction)onTabButtonClicked:(id)sender {
    [mPageControl setCurrentPage:[sender tag]];
    [self gotoPage:YES];
}

#pragma mark delegate

- (void)searchViewDismissed:(NSString*)str {
    if ([_mCareerList objectAtIndex:1] == [NSNull null]) {
        // only 1
        [_mCareerList replaceObjectAtIndex:1 withObject:str];
    } else if ([_mCareerList objectAtIndex:2] == [NSNull null]) {
        // 1+2
        [_mCareerList replaceObjectAtIndex:2 withObject:str];
    } else {
        // 1+2+3
        [_mCareerList replaceObjectAtIndex:2 withObject:str];
    }
    
    [self setButtonTitle];
    [mPageControl setNumberOfPages:pageNum];
    [self reloadPages];
}

- (void)selectJob:(NSData*)data :(NSInteger)index {
    JobDetailViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"job_detail"];
    controller.mJobData = data;
    controller.mJobIndex = index;
    [self presentViewController:controller animated:YES completion:nil];
}

@end