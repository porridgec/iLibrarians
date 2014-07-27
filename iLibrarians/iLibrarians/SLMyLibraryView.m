//
//  SLMyLibraryViewController.m
//  iLibrarians
//
//  Created by johnsonpuning on 14-7-12.
//  Copyright (c) 2014年 Apple Club. All rights reserved.
//

#import "SLMyLibraryView.h"
#import "MJRefresh.h"
#import "iLIBEngine.h"
#import "iLIBBookItem.h"
#import "iLIBBorrowedBooksCell.h"
#import "ArrayDataSource.h"

@interface SLMyLibraryView () <UITableViewDelegate>
{
    MJRefreshHeaderView *_header;
    MJRefreshFooterView *_footer;
    ArrayDataSource* _bookArrayDataSource;
}

@property (nonatomic, strong) UITableView *borrowBookTableView;
@property (nonatomic, strong) NSArray *borrowedBooks;

@end

@implementation SLMyLibraryView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    [self initView];
    return self;
}

- (void)initView
{
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    self.borrowBookTableView = [[UITableView alloc] initWithFrame:CGRectMake(0., 0., width, height - 29.)];
    [self addSubview:self.borrowBookTableView];
    
    _header = [[MJRefreshHeaderView alloc] init];
    _header.delegate = (id)self;
    _header.scrollView = self.borrowBookTableView;
    _footer = [[MJRefreshFooterView alloc] init];
    _footer.delegate = (id)self;
    _footer.scrollView = self.borrowBookTableView;
    
    TableViewConfigureBlock configureBlock = ^(iLIBBorrowedBooksCell *cell,iLIBBookItem *bookItem)
    {
        [cell configureForCell:bookItem];
    };
    _bookArrayDataSource = [[ArrayDataSource alloc] initWithItems:_borrowedBooks cellIndetifier:@"iLIBBorrowedBooksCell" configureCellBlock:configureBlock];
    self.borrowBookTableView.delegate = self;
    self.borrowBookTableView.dataSource = _bookArrayDataSource;
    [self.borrowBookTableView setRowHeight:66.];
    [_header beginRefreshing];
}

#pragma mark - Table View Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 66;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    iLIBBookItem *book = [_borrowedBooks objectAtIndex:indexPath.row];
    [[iLIBEngine sharedInstance] useCache];
    
    __block UIImage *coverImage = [[UIImage alloc] init];
    
    [[iLIBEngine sharedInstance] imageAtURL:[NSURL URLWithString:book.cover] completionHandler:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache) {
        NSLog(@"%@", fetchedImage);
        coverImage = fetchedImage;
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [UIAlertView showWithError:error];
    }];
    if (coverImage == nil) {
        NSLog(@"really nil");
    }
    NSLog(@"%@",coverImage);
    [_delegate showBorrowBookDetailViewControllerWithCoverImage:coverImage BookItem:book];
}

#pragma mark - Refresh View Delegate

- (void)refreshBorrowedBooksTableView
{
    [[iLIBEngine sharedInstance] requestLoanBooks:^(NSArray *bookArray) {
        self.borrowedBooks = [NSArray arrayWithArray:bookArray];
        _bookArrayDataSource.items = _borrowedBooks;
    } onError:^(NSError *engineError) {

    }];
}

- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if (_header == refreshView) {
        [self performSelector:@selector(refreshBorrowedBooksTableView) withObject:nil];
        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(reloadBorrowedBooksTableView) userInfo:nil repeats:NO];
        NSLog(@"刷新");
    } else {
        // do nothing
    }
}

- (void)reloadBorrowedBooksTableView
{
    [self.borrowBookTableView reloadData];
    [_header endRefreshing];
    [_footer endRefreshing];
}

@end
