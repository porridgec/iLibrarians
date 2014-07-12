//
//  SLMyLibraryViewController.m
//  iLibrarians
//
//  Created by johnsonpuning on 14-7-12.
//  Copyright (c) 2014年 Apple Club. All rights reserved.
//

#import "SLMyLibraryViewController.h"

@interface SLMyLibraryViewController ()

@property (nonatomic, strong) UISegmentedControl *segmentControl;
@property (nonatomic, strong) UITableView *myLibraryTableView;

@end

@implementation SLMyLibraryViewController

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
}

- (void)initView
{
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    NSArray *segmentItems = @[@"借阅查询", @"图书荐购", @"个人信息"];
    self.segmentControl = [[UISegmentedControl alloc] initWithItems:segmentItems];
    [self.segmentControl setFrame:CGRectMake(0., 0., width, 29.)];
    [self.view addSubview:self.segmentControl];
    
    self.myLibraryTableView = [[UITableView alloc] initWithFrame:CGRectMake(0., 29., width, height - 29.)];
    [self.view addSubview:self.myLibraryTableView];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self initView];
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
