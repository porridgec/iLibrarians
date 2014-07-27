//
//  SLMyInfoViewController.m
//  iLibrarians
//
//  Created by johnsonpuning on 14-7-12.
//  Copyright (c) 2014年 Apple Club. All rights reserved.
//

#import "SLMyInfoViewController.h"
#import "iLIBEngine.h"

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
    
    NSArray *content = [[NSArray alloc] initWithObjects:@"退出登录",nil];
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
    [self didTouchOnLogoutItem];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didTouchOnLogoutItem{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"确定退出?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    [alert show];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != 0){
        [[iLIBEngine sharedInstance] logout:^(void){
            NSLog(@"log out success!");
        }onError:^(NSError *errorEngine){
            NSLog(@"Engine error!Failed to logout!");
        }];
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
 //       [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}
@end
