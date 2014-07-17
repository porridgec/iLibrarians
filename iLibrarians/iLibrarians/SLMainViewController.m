//
//  SLMainViewController.m
//  iLibrarians
//
//  Created by johnsonpuning on 14-7-12.
//  Copyright (c) 2014年 Apple Club. All rights reserved.
//

#import "SLMainViewController.h"
#import "SLMyLibraryViewController.h"
#import "SLBooksExchangeViewController.h"
#import "SLMyInfoViewController.h"

#import "SLSearchBookView.h"

#define NAVIGATION_BAR_HEIGHT 64

@interface SLMainViewController ()

@property (nonatomic, strong) UIScrollView *mainScrollView;

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

    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0., 0., width, height)];
    [self.mainScrollView setContentSize:CGSizeMake(width * 3, 0.)];
    [self.mainScrollView setPagingEnabled:YES];
    [self.mainScrollView setScrollEnabled:YES];
    [self.mainScrollView setAlwaysBounceHorizontal:YES];
    [self.mainScrollView setAlwaysBounceVertical:NO];
    [self.mainScrollView setContentOffset:CGPointMake(320, 0)];
    [self.view addSubview:self.mainScrollView];
    
    SLMyLibraryViewController *myLibraryViewController = [[SLMyLibraryViewController alloc] init];
    SLBooksExchangeViewController *booksExchangeViewController = [[SLBooksExchangeViewController alloc] init];
    
    SLSearchBookView *searchBookView = [[SLSearchBookView alloc] initWithFrame:CGRectMake(0.+ width, 0., width, height)];
    searchBookView.vc = self;
    
    [myLibraryViewController.view setFrame:CGRectMake(0., 0., width, height)];
    [booksExchangeViewController.view setFrame:CGRectMake(0.+ width + width, 0., width, height)];
    
    [self.mainScrollView addSubview:myLibraryViewController.view];
    [self.mainScrollView addSubview:searchBookView];
    [self.mainScrollView addSubview:booksExchangeViewController.view];
    
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

@end
