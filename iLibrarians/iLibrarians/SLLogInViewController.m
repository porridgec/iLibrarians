//
//  SLLogInViewController.m
//  iLibrarians
//
//  Created by johnson on 14-7-8.
//  Copyright (c) 2014年 Apple Club. All rights reserved.
//

#import "SLLogInViewController.h"

@interface SLLogInViewController ()

@end

@implementation SLLogInViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)initView
{

}

- (void)viewWillAppear:(BOOL)animated
{
    [self setTitle:@"登陆"];
    [self initView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


@end
