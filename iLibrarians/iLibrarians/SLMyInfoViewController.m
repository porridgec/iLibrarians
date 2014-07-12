//
//  SLMyInfoViewController.m
//  iLibrarians
//
//  Created by johnsonpuning on 14-7-12.
//  Copyright (c) 2014年 Apple Club. All rights reserved.
//

#import "SLMyInfoViewController.h"

@interface SLMyInfoViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *myInfoTable;
@property (nonatomic, strong) NSArray *tableCellContent;

@end

@implementation SLMyInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initView];
    
    NSArray *content = [[NSArray alloc] initWithObjects:@"关于iLibrarian",@"关于SYSU AppleClub",@"反馈意见",@"去评分",nil];
    self.tableCellContent = content;
}

- (void)initView
{
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    
    self.myInfoTable = [[UITableView alloc] initWithFrame:CGRectMake(0., 0., width, height - 64.)];
    [self.myInfoTable setDelegate:self];
    [self.myInfoTable setDataSource:self];
    
    [self.view addSubview:self.myInfoTable];
    
}


#pragma mark - Table view data source & delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tableCellContent count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    [cell.textLabel setText:[self.tableCellContent objectAtIndex:indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 14;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
