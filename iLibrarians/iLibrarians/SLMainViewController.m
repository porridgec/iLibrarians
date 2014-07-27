//
//  SLMainViewController.m
//  iLibrarians
//
//  Created by johnsonpuning on 14-7-12.
//  Copyright (c) 2014年 Apple Club. All rights reserved.
//

#import "SLMainViewController.h"
#import "SLMyInfoViewController.h"
#import "iLIBBorrowedBookDetailViewController.h"

#import "SLSearchBookView.h"
#import "SLBookExchangeView.h"
#import "SLMyLibraryView.h"
#import "SLBookExchangePublishViewController.h"
#import "SLBookExchangeDetailViewController.h"

#define NAVIGATION_BAR_HEIGHT 64
#define PAGE_CONTROL_BAR_HEIGHT 10
#define NUMBER_OF_PAGE 3

@interface SLMainViewController () <UIScrollViewDelegate, BorrowBookDelegate, BookExchangeDelegate>

@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) UIPageControl *mainPageControl;
@property (nonatomic, strong) iLIBBorrowedBookDetailViewController *iLibBorrowedBookDetailViewController;

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
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation_bar.png"] forBarMetrics:UIBarMetricsDefault];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"publishMsg"] style:UIBarButtonItemStylePlain target:self action:@selector(publishBook)];
    [leftBarButtonItem setTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"publishMsg"]]];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"myInfo"] style:UIBarButtonItemStylePlain target:self action:@selector(goToMyInfo)];
    [rightBarButtonItem setTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"myInfo"]]];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

- (void)initView
{
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0., 0., width, height)];
    [self.mainScrollView setContentSize:CGSizeMake(width * 3, 0.)];
    [self.mainScrollView setPagingEnabled:YES];
    [self.mainScrollView setScrollEnabled:YES];
    [self.mainScrollView setAlwaysBounceHorizontal:YES];
    [self.mainScrollView setAlwaysBounceVertical:NO];
    [self.mainScrollView setShowsHorizontalScrollIndicator:NO];
    [self.mainScrollView setDelegate:self];
    [self.view addSubview:self.mainScrollView];

    SLMyLibraryView *myLibraryView = [[SLMyLibraryView alloc] initWithFrame:CGRectMake(0., 0., width, height)];
    myLibraryView.delegate = self;
    
    SLSearchBookView *searchBookView = [[SLSearchBookView alloc] initWithFrame:CGRectMake(0.+ width, 0., width, height)];
    searchBookView.vc = self;
    
    SLBookExchangeView *bookExchangeView = [[SLBookExchangeView alloc] initWithFrame:CGRectMake(0.+ width + width, 0., width, height)];
    bookExchangeView.delegate = self;
        
    [self.mainScrollView addSubview:myLibraryView];
    [self.mainScrollView addSubview:searchBookView];
    [self.mainScrollView addSubview:bookExchangeView];
    
    self.mainPageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0., height - PAGE_CONTROL_BAR_HEIGHT - 67,
                                                                           width, PAGE_CONTROL_BAR_HEIGHT)];
    [self.mainPageControl setNumberOfPages:NUMBER_OF_PAGE];
    [self.mainPageControl setPageIndicatorTintColor:[UIColor lightGrayColor]];
    [self.mainPageControl setCurrentPageIndicatorTintColor:[UIColor blackColor]];
    [self.mainPageControl setBackgroundColor:[UIColor whiteColor]];
    [self.mainPageControl setEnabled:NO];
    [self.mainPageControl setCurrentPage:self.mainScrollView.contentOffset.x / self.mainScrollView.frame.size.width];
    [self.view addSubview:self.mainPageControl];
}

- (void)setPageOfScrollView:(NSInteger)page
{
    if (page <= NUMBER_OF_PAGE) {
        CGFloat contentOffset = (page - 1) * self.view.frame.size.width;
        [self.mainScrollView setContentOffset:CGPointMake(contentOffset, 0)];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initView];
}

#pragma mark - NavigationItem Action
- (void)goToMyInfo
{
    SLMyInfoViewController *myInfoViewController = [[SLMyInfoViewController alloc] init];
    [self.navigationController pushViewController:myInfoViewController animated:YES];
}

- (void)publishBook
{
    SLBookExchangePublishViewController *publish = [[SLBookExchangePublishViewController alloc] init];
	[self.navigationController pushViewController:publish animated:YES];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger currentPage = scrollView.contentOffset.x / scrollView.frame.size.width;
    [self.mainPageControl setCurrentPage:currentPage];
    
    switch (currentPage) {
        case 0:
            [self setTitle:@"借阅记录"];
            self.navigationItem.leftBarButtonItem.enabled = NO;
            break;
        case 1:
            [self setTitle:@"图书查询"];
            self.navigationItem.leftBarButtonItem.enabled = NO;
            break;
        case 2:
            [self setTitle:@"图书漂流"];
            self.navigationItem.leftBarButtonItem.enabled = YES;
            break;
        default:
            break;
    }
}

#pragma mark - BorrowBookDelegate

- (void)showBorrowBookDetailViewControllerWithCoverImage:(UIImage *)coverImage BookItem:(iLIBBookItem *)bookItem
{
    _iLibBorrowedBookDetailViewController = [[iLIBBorrowedBookDetailViewController alloc] initWithNibName:@"iLIBBorrowedBookDetailViewController" bundle:nil];
    _iLibBorrowedBookDetailViewController.coverView.image = coverImage;
    [_iLibBorrowedBookDetailViewController setBookItem:bookItem];
    [self.navigationController pushViewController:_iLibBorrowedBookDetailViewController animated:YES];
}

#pragma mark - BookExchangeDelegate

- (void)showBookExchangeDetailViewControllerWithBook:(iLIBFloatBookItem*)book
{
    
    SLBookExchangeDetailViewController *detailViewController = [[SLBookExchangeDetailViewController alloc] init];
    [detailViewController setBook:book];
    [self.navigationController pushViewController:detailViewController animated:YES];
    
}
@end
