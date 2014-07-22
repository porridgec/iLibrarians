//
//  SLMainViewController.m
//  iLibrarians
//
//  Created by johnsonpuning on 14-7-12.
//  Copyright (c) 2014年 Apple Club. All rights reserved.
//

#import "SLMainViewController.h"
#import "SLMyInfoViewController.h"

#import "SLSearchBookView.h"
#import "SLBookExchangeView.h"
#import "SLMyLibraryView.h"

#define NAVIGATION_BAR_HEIGHT 64
#define PAGE_CONTROL_BAR_HEIGHT 10
#define NUMBER_OF_PAGE 3

@interface SLMainViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) UIPageControl *mainPageControl;
@end

@implementation SLMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self setTitle:@"图书馆"];
    
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"个人" style:UIBarButtonItemStylePlain target:self action:@selector(goToMyInfo)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;

}

- (void)initView
{
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0., 0., width, height - PAGE_CONTROL_BAR_HEIGHT)];
    [self.mainScrollView setContentSize:CGSizeMake(width * 3, 0.)];
    [self.mainScrollView setPagingEnabled:YES];
    [self.mainScrollView setScrollEnabled:YES];
    [self.mainScrollView setAlwaysBounceHorizontal:YES];
    [self.mainScrollView setAlwaysBounceVertical:NO];
    [self.mainScrollView setShowsHorizontalScrollIndicator:NO];
    [self.mainScrollView setDelegate:self];
    [self.view addSubview:self.mainScrollView];
    
    SLMyLibraryView *myLibraryView = [[SLMyLibraryView alloc] initWithFrame:CGRectMake(0., 0., width, height)];
    
    SLSearchBookView *searchBookView = [[SLSearchBookView alloc] initWithFrame:CGRectMake(0.+ width, 0., width, height)];
    searchBookView.vc = self;
    
    SLBookExchangeView *bookExchangeView = [[SLBookExchangeView alloc] initWithFrame:CGRectMake(0.+ width + width, 0., width, height)];
    bookExchangeView.controller = self;
        
    [self.mainScrollView addSubview:myLibraryView];
    [self.mainScrollView addSubview:searchBookView];
    [self.mainScrollView addSubview:bookExchangeView];
    
    self.mainPageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0., height - PAGE_CONTROL_BAR_HEIGHT - 3,
                                                                           width, PAGE_CONTROL_BAR_HEIGHT)];
    [self.mainPageControl setNumberOfPages:NUMBER_OF_PAGE];
    [self.mainPageControl setPageIndicatorTintColor:[UIColor lightGrayColor]];
    [self.mainPageControl setCurrentPageIndicatorTintColor:[UIColor blackColor]];
    [self.mainPageControl setBackgroundColor:[UIColor whiteColor]];
    [self.mainPageControl setEnabled:NO];
    [self.mainPageControl setCurrentPage:self.mainScrollView.contentOffset.x / self.mainScrollView.frame.size.width];
    [self.view addSubview:self.mainPageControl];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initView];
}

- (void)goToMyInfo
{
    SLMyInfoViewController *myInfoViewController = [[SLMyInfoViewController alloc] init];
    [self.navigationController pushViewController:myInfoViewController animated:YES];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.mainPageControl setCurrentPage:scrollView.contentOffset.x / scrollView.frame.size.width];
}

@end
