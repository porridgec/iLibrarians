//
//  SLBooksExchangeViewController.m
//  iLibrarians
//
//  Created by johnsonpuning on 14-7-12.
//  Copyright (c) 2014年 Apple Club. All rights reserved.
//

#import "SLBooksExchangeViewController.h"

@interface SLBooksExchangeViewController ()

@property (nonatomic, strong) UISegmentedControl *segmentedControl;

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
    [self.segmentedControl setFrame:CGRectMake(0., 0., width, 29.)];
    [self.view addSubview:self.segmentedControl];
}
@end
