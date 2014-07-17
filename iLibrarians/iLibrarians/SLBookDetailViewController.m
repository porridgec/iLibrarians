//
//  SLBookDetailViewController.m
//  iLibrarians
//
//  Created by Hahn.Chan on 7/15/14.
//  Copyright (c) 2014 Apple Club. All rights reserved.
//

#import "SLBookDetailViewController.h"

@interface SLBookDetailViewController ()

@end

@implementation SLBookDetailViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, 320, 463)];
        self.textFieldBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 528, 320, 40)];
        
    }
    return self;
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


@end
