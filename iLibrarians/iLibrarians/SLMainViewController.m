//
//  SLMainViewController.m
//  iLibrarians
//
//  Created by johnsonpuning on 14-7-12.
//  Copyright (c) 2014年 Apple Club. All rights reserved.
//

#import "SLMainViewController.h"
#import "SLMyLibraryViewController.h"
#import "SLSearchBookViewController.h"
#import "SLBooksExchangeViewController.h"

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
}

- (void)initView
{
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0., NAVIGATION_BAR_HEIGHT, width * 3 , height)];
    [self.view addSubview:self.mainScrollView];
    
    SLMyLibraryViewController *myLibraryViewController = [[SLMyLibraryViewController alloc] init];
    SLSearchBookViewController *searchBookViewController = [[SLSearchBookViewController alloc] init];
    SLBooksExchangeViewController *booksExchangeViewController = [[SLBooksExchangeViewController alloc] init];
    
    [myLibraryViewController.view setFrame:CGRectMake(0., 0., width, height)];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
