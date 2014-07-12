//
//  SLLogInViewController.m
//  iLibrarians
//
//  Created by johnson on 14-7-8.
//  Copyright (c) 2014年 Apple Club. All rights reserved.
//

#import "SLLogInViewController.h"
#import "SLMainViewController.h"

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
    UIButton *loginButton = [[UIButton alloc] initWithFrame:CGRectMake(20., 100., 44., 44.)];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self setTitle:@"登陆"];
    [self initView];
}

- (void)login
{
    SLMainViewController *mainViewController = [[SLMainViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:mainViewController];

    [self presentViewController:navigationController animated:YES  completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


@end
