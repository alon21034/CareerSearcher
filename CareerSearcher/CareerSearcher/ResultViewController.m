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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    pageNum = 4;
    pageWidth = 280;
    pageHeight = 420;
    
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
    self.mScrollView.showsHorizontalScrollIndicator = NO;
    self.mScrollView.showsVerticalScrollIndicator = NO;
    self.mScrollView.scrollsToTop = NO;
    self.mScrollView.delegate = self;
    
    [self loadScrollViewWithPage:0];
    [self loadScrollViewWithPage:1];
    
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

#pragma mark onClick

- (IBAction)onBackButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onNextButtonPressed:(id)sender {
    SearchViewController *searchView = [self.storyboard instantiateViewControllerWithIdentifier:@"search_view"];
    [self presentViewController:searchView animated:YES completion:nil];
}

- (IBAction)onTabButtonClicked:(id)sender {
    [mPageControl setCurrentPage:[sender tag]];
    [self gotoPage:YES];
}
@end
