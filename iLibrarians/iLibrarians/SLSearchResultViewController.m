//
//  SLSearchResultViewController.m
//  iLibrarians
//
//  Created by Hahn.Chan on 7/15/14.
//  Copyright (c) 2014 Apple Club. All rights reserved.
//

#import "SLSearchResultViewController.h"
#import "SLBookDetailViewController.h"
#import "SLBookItemCell.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD.h"


@implementation SLSearchResultViewController

@synthesize iLibEngine = _iLibEngine;

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
    [self setTitle:@"检索结果"];
    //self.view.backgroundColor = [UIColor redColor];
    
    self.resultTableView                 = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                                         0,
                                                                                         320,
                                                                                         self.view.frame.size.height )];
    self.resultTableView.backgroundColor = [UIColor whiteColor];
    self.resultTableView.dataSource      = self;
    self.resultTableView.delegate        = self;
    [self.view addSubview:_resultTableView];
    
    _bookCount            = 0;
    _cellCount            = 0;
    _pageIndex            = 1;
    _pageCount            = 0;
    _didFinishedSearching = NO;
    _didFinishLoadingMore = YES;
    self.iLibEngine       = [[iLIBEngine alloc]initWithHostName:kHostUrl customHeaderFields:nil];
    
    MBProgressHUD *hud    = [[MBProgressHUD alloc]initWithView:self.view];
    hud.dimBackground     = YES;
    hud.labelText         = @"努力查询中...";
    [self.view addSubview:hud];
    [hud show:YES];
	
    
    [self.iLibEngine getSetNumberWithBookName:self.searchString
                                 onCompletion:^(NSString *bookNumber,int bookCount){
                                     self.bookNumber = bookNumber;
                                     self.bookCount = bookCount;
                                     if(self.bookCount % 10 == 0){
                                         self.pageCount = self.bookCount / 10;
                                     }
                                     else{
                                         self.pageCount = (self.bookCount / 10) + 1;
                                     }
                                     NSLog(@"%@ has %d",self.bookNumber,self.bookCount);
                                     if(bookCount != 0)
                                     {
                                         [self.iLibEngine searchBooksWithBookNumberAndPage:self.bookNumber
                                                                                      page:self.pageIndex
                                                                              onCompletion:^(NSMutableArray *searchedBooks){
                                                                                  //
                                                                                  self.searchedBooks        = searchedBooks;
                                                                                  self.cellCount            = [self.searchedBooks count];
                                                                                  self.didFinishedSearching = YES;
                                                                                  [self.resultTableView reloadData];
                                                                                  [hud removeFromSuperview];
                                                                              }onError:^(NSError *error){
                                                                                  //
                                                                                  [hud removeFromSuperview];
                                                                                  UIAlertView *alert = [[UIAlertView alloc ]initWithTitle:@"出错了" message:@"网络不太给力呀~" delegate:self cancelButtonTitle:@"寡人知道了" otherButtonTitles:nil];
                                                                                  [alert show];
                                                                              }];
                                     }
                                     else{
                                         self.didFinishedSearching = YES;
                                         [self.resultTableView reloadData];
                                         UIAlertView *alert        = [[UIAlertView alloc ]initWithTitle:@"出错了" message:@"找不到这样的书呀~" delegate:self cancelButtonTitle:@"寡人知道了" otherButtonTitles:nil];
                                         [alert show];
                                         [hud removeFromSuperview];
                                         
                                     }
									 
                                 }onError:^(NSError *error){
                                     //
                                     [hud removeFromSuperview];
                                     UIAlertView *alert = [[UIAlertView alloc ]initWithTitle:@"出错了" message:@"网络不太给力呀~" delegate:self cancelButtonTitle:@"寡人知道了" otherButtonTitles:nil];
                                     [alert show];
                                 }];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - datasource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_didFinishedSearching == YES){
        if(_bookCount == 0)
        {
            UITableViewCell *cell = [_resultTableView dequeueReusableCellWithIdentifier:@"Cell"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                [cell.textLabel setBackgroundColor:[UIColor clearColor]];
            }
            else{
                while ([cell.contentView.subviews lastObject] != nil) {
                    [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
                }
            }
            [cell.textLabel setText:@"找不到这样的书呀~"];
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            return cell;
        }
        
        
		
        
        static NSString *CellIdentifier = @"SLBookItemCell";
        
        if(indexPath.row < _cellCount)
        {
            SLBookItemCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (!cell) {
                cell = [[SLBookItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                [cell.textLabel setBackgroundColor:[UIColor clearColor]];
            }else{
                while ([cell.contentView.subviews lastObject] != nil) {
                    [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
                }
            }
            //NSLog(@"%ld",(long)indexPath.row);
            cell.bookTitleLabel.text  = [[_searchedBooks objectAtIndex:indexPath.row] objectForKey:@"title"];
            cell.bookAuthorLabel.text = [[_searchedBooks objectAtIndex:indexPath.row] objectForKey:@"author"];
            
            NSURL *coverUrl = [NSURL URLWithString:[[_searchedBooks objectAtIndex:indexPath.row] objectForKey:@"cover"]];
            [cell.bookCoverImage setImageWithURL:coverUrl];
            return cell;
        }
        else{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
            cell = nil;
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
                
                [cell.textLabel setBackgroundColor:[UIColor whiteColor]];
            }else{
                while ([cell.contentView.subviews lastObject] != nil) {
                    [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
                }
            }
            
            cell.backgroundColor = [UIColor whiteColor];
            cell.textLabel.text          = @"load more";
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            return cell;
        }
    }
    else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
            
            [cell.textLabel setBackgroundColor:[UIColor clearColor]];
        }else{
            while ([cell.contentView.subviews lastObject] != nil) {
                [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
            }
        }
        
        cell.textLabel.text          = @"";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        return cell;
    }
}

#pragma mark - delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.didFinishedSearching == YES){
        if(self.bookCount != 0){
            return self.cellCount + 1;
        }
        else
            return 1;
    }
    else{
        return 1;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 67;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
    if(_bookCount != 0 && indexPath.row != self.cellCount)
    {
        SLBookItemCell *cell                           = (SLBookItemCell*)[tableView cellForRowAtIndexPath:indexPath];
        SLBookDetailViewController *detailViewController = [[SLBookDetailViewController alloc]init];
        
        detailViewController.title                                 = cell.bookTitleLabel.text;
        detailViewController.bookTitle                             = cell.bookTitleLabel.text;
        detailViewController.bookIndex                             = [NSString stringWithFormat:@"%@",[[_searchedBooks objectAtIndex:indexPath.row] objectForKey:@"index"]] ;
        detailViewController.author                                = cell.bookAuthorLabel.text;
        detailViewController.publish                               = [NSString stringWithFormat:@"%@",[[_searchedBooks objectAtIndex:indexPath.row] objectForKey:@"press"]] ;
        detailViewController.bookCover                             = cell.bookCoverImage.image;
        detailViewController.docNumber                             = [[self.searchedBooks objectAtIndex:indexPath.row] objectForKey:@"doc_number"];
        [self.navigationController pushViewController:detailViewController animated:YES];
    }
    if(indexPath.row == self.cellCount && self.didFinishLoadingMore == YES){
        self.pageIndex            += 1;
        self.didFinishLoadingMore = NO;
        [self loadMoreBooks];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
	
}

#pragma mark - footer for load more books
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    UIView* footerView                = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
//
//    footerView.autoresizesSubviews    = YES;
//
//    footerView.autoresizingMask       = UIViewAutoresizingFlexibleWidth;
//
//    footerView.userInteractionEnabled = YES;
//
//    footerView.hidden                 = YES;
//
//    footerView.multipleTouchEnabled   = NO;
//
//    footerView.opaque                 = NO;
//
//    footerView.contentMode            = UIViewContentModeScaleToFill;
//
//    footerView.backgroundColor        = [UIColor whiteColor];
//
//    return footerView;
//}

- (void)loadMoreBooks
{
    if(self.pageIndex <= self.pageCount){
        [self.iLibEngine searchBooksWithBookNumberAndPage:self.bookNumber page:self.pageIndex onCompletion:^(NSMutableArray *searchedBooks){
            NSMutableArray *newArr    = [[NSMutableArray alloc]initWithArray:self.searchedBooks];
            [newArr addObjectsFromArray:searchedBooks];
            self.searchedBooks        = newArr;
            self.cellCount            = [newArr count];
            self.didFinishLoadingMore = YES;
            [self.resultTableView reloadData];
            NSLog(@"book in display now is %d",[newArr count]);
        }onError:^(NSError *error){
            //
        }];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"木有更多的书啦~" message:@"你已经遍历了所有的书~" delegate:self cancelButtonTitle:@"寡人知道了" otherButtonTitles: nil];
        [alert show];
    }
    
    
}

@end
