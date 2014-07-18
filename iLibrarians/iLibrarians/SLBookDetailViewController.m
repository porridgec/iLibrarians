//
//  SLBookDetailViewController.m
//  iLibrarians
//
//  Created by Hahn.Chan on 7/15/14.
//  Copyright (c) 2014 Apple Club. All rights reserved.
//

#import "SLBookDetailViewController.h"
#import "iLIBEngine.h"
#import "iLIBBookItem.h"
#import "MBProgressHUD.h"

#define kHostUrl @"libapi.insysu.com"

#define aRGB(a,r,g,b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a/1.0f]

@interface SLBookDetailViewController ()

@end

@implementation SLBookDetailViewController

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
    // Do any additional setup after loading the view.
    
    [self setTitle:@"图书详情"];
    [self.view setBackgroundColor:aRGB(1, 239, 239, 239)];
    
    self.bookCoverImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 80, 75, 100)];
    self.bookTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(95, 68, 205, 40)];
    self.bookIndexLabel = [[UILabel alloc] initWithFrame:CGRectMake(95, 106, 205, 17)];
    self.authorLabel    = [[UILabel alloc] initWithFrame:CGRectMake(95, 134, 205, 17)];
    self.publishLabel   = [[UILabel alloc] initWithFrame:CGRectMake(95, 162, 205, 17)];
    
    
    self.bookTitleLabel.text        = self.bookTitle;
    self.bookIndexLabel.text        = self.bookIndex;
    self.authorLabel.text           = self.author;
    self.bookCoverImage.image       = self.bookCover;
    self.publishLabel.text          = self.publish;
    self.iLibEngine                 = [[iLIBEngine alloc]initWithHostName:kHostUrl customHeaderFields:nil];
    
    self.statusTableView            = [[UITableView alloc] initWithFrame:CGRectMake(10, 188, 300, 330)];
    self.statusTableView.backgroundColor = aRGB(1, 239, 239, 239);
    self.statusTableView.dataSource = self;
    self.statusTableView.delegate   = self;
    
    [self.bookTitleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    [self.bookIndexLabel setFont:[UIFont systemFontOfSize:15]];
    [self.authorLabel setFont:[UIFont systemFontOfSize:14]];
    [self.publishLabel setFont:[UIFont systemFontOfSize:14]];
    
    self.bookIndexLabel.textColor = [UIColor colorWithRed:0.00 green:0.47 blue:0.68 alpha:1.00];
    self.authorLabel.textColor    = [UIColor grayColor];
    self.publishLabel.textColor   = [UIColor grayColor];
    
    [self.view addSubview:self.bookCoverImage];
    [self.view addSubview:self.bookTitleLabel];
    [self.view addSubview:self.bookIndexLabel];
    [self.view addSubview:self.authorLabel];
    [self.view addSubview:self.publishLabel];
    [self.view addSubview:self.statusTableView];
    
    MBProgressHUD *hud        = [[MBProgressHUD alloc]initWithView:self.view];
    hud.labelText             = @"加载中...";
    [hud show:YES];
    [self.statusTableView addSubview:hud];
    
    [self.iLibEngine getBookStatusWithDocNumber:self.docNumber onCompletion:^(NSMutableArray *status){
        //
        self.status = status;
        [self.statusTableView reloadData];
        [hud removeFromSuperview];
    }onError:^(NSError *error){
        //
    }];

    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    }

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.status count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *CellIdentifier = @"cellIdentifier";
    NSDictionary *curStatus = [self.status objectAtIndex:indexPath.row];
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell==nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [[self.status objectAtIndex:indexPath.row]objectForKey:@"sub-library"];
    if([[curStatus valueForKey:@"sub-library"] isEqualToString:@"业务书"]   ||
       [[curStatus valueForKey:@"sub-library"] isEqualToString:@"调拨临时"] ||
       [[curStatus valueForKey:@"sub-library"] isEqualToString:@"院系保留"]   ){
        cell.detailTextLabel.text = @"不外借";
    }
    else{
        if([[curStatus objectForKey:@"loan-status"] isKindOfClass:[NSNull class]] == NO  && [[curStatus valueForKey:@"loan-status"] isEqualToString:@"A"]){
            NSString *dueDate = [NSString stringWithFormat:@"%@",[curStatus objectForKey:@"loan-due-date"]];
            NSString *year    = [dueDate substringWithRange:NSMakeRange(0, 4)];
            NSString *month   = [dueDate substringWithRange:NSMakeRange(4, 2)];
            NSString *day     = [dueDate substringWithRange:NSMakeRange(6, 2)];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"借出至%@年%@月%@日",year,month,day];
            cell.detailTextLabel.adjustsFontSizeToFitWidth = YES;
        }
        else{
            cell.detailTextLabel.text = @"在馆";
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView* footerView                = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    
    footerView.autoresizesSubviews    = YES;
    
    footerView.autoresizingMask       = UIViewAutoresizingFlexibleWidth;
    
    footerView.userInteractionEnabled = YES;
    
    footerView.hidden                 = YES;
    
    footerView.multipleTouchEnabled   = NO;
    
    footerView.opaque                 = NO;
    
    footerView.contentMode            = UIViewContentModeScaleToFill;
    
    footerView.backgroundColor        = [UIColor whiteColor];
    
    return footerView;
}

@end
