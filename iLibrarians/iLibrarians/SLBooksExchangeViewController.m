//
//  SLBooksExchangeViewController.m
//  iLibrarians
//
//  Created by johnsonpuning on 14-7-12.
//  Copyright (c) 2014年 Apple Club. All rights reserved.
//

#import "SLBooksExchangeViewController.h"
#import "SLPublishViewController.h"

#define SEGMENT_HEIGHT 29
#define PUBLISH_BUTTON_WIDTH 200
#define PUBLISH_BUTTON_HEIGHT 20

@interface SLBooksExchangeViewController ()

@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) UITableView *exchangeTableView;
@property (nonatomic, strong) UIButton *publishButton;

@end

@implementation SLBooksExchangeViewController

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initView];
}

- (void)initView
{
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    NSArray *segmentItems = @[@"闲置", @"求借"];
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:segmentItems];
    [self.segmentedControl setFrame:CGRectMake(0., 0., width, SEGMENT_HEIGHT)];
    [self.view addSubview:self.segmentedControl];
    
    self.exchangeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0., SEGMENT_HEIGHT, width, height - PUBLISH_BUTTON_HEIGHT - 69.)];
    [self.view addSubview:self.exchangeTableView];
    
    self.publishButton = [[UIButton alloc] initWithFrame:CGRectMake((width - PUBLISH_BUTTON_WIDTH) / 2, height - PUBLISH_BUTTON_HEIGHT - 69., PUBLISH_BUTTON_WIDTH,PUBLISH_BUTTON_HEIGHT)];
    [self.publishButton setTitle:@"发布消息" forState:UIControlStateNormal];
    [self.publishButton setBackgroundColor:[UIColor blueColor]];
    [self.publishButton addTarget:self action:@selector(publishInfo) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:self.publishButton];
}


- (void)publishInfo
{
    SLPublishViewController *publishViewController = [[SLPublishViewController alloc] init];
    [self.navigationController pushViewController:publishViewController animated:YES];
}

@end
