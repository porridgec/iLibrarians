//
//  SLBookExchangeView.m
//  iLibrarians
//
//  Created by billy.ho on 7/16/14.
//  Copyright (c) 2014 Apple Club. All rights reserved.
//

#import "SLAppDelegate.h"
#import "SLBookExchangeView.h"
#import "SLPublishViewController.h"
#import "MJRefresh.h"
#import "iLIBEngine.h"
#import "SLBookExchangeCell.h"
#import "SLMyInfoViewController.h"
#import "SLBookExchangeDetailViewController.h"
#import "SLBookExchangePublishViewController.h"
#import "IQKeyboardManager.h"

#define NAVIGATONBAR_HEIGHT 32
#define SEGMENT_HEIGHT 29
#define PUBLISH_BUTTON_WIDTH 200
#define PUBLISH_BUTTON_HEIGHT 20

#define cellBackGroundColor [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5]
#define segmentedControlColor [UIColor colorWithRed:0.4784 green:0.9255 blue:0.7098 alpha:1.0]


@interface SLBookExchangeView ()
{
    MJRefreshHeaderView *_header;
    MJRefreshFooterView *_footer;
}

@property(nonatomic,assign) int pageCount;
@property(nonatomic,strong) iLIBEngine *iLibEngine;
@property(nonatomic,strong) NSMutableArray *booksArray;

@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) UITableView *exchangeTableView;

@end

@implementation SLBookExchangeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        CGFloat width = self.frame.size.width;
        CGFloat height = self.frame.size.height;
        NSArray *segmentItems = @[@"闲置", @"求借"];
        self.segmentedControl = [[UISegmentedControl alloc] initWithItems:segmentItems];
        [self.segmentedControl setFrame:CGRectMake(0., 0., width, SEGMENT_HEIGHT)];
        self.segmentedControl.selectedSegmentIndex = 0;
        [self.segmentedControl addTarget:self action:@selector(mySegmentValueChanged:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:self.segmentedControl];
        
        
        self.exchangeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0., SEGMENT_HEIGHT, width, height - PUBLISH_BUTTON_HEIGHT - 69. - NAVIGATONBAR_HEIGHT)];
        [self addSubview:self.exchangeTableView];
        
        self.publishButton = [[UIButton alloc] initWithFrame:CGRectMake((width - PUBLISH_BUTTON_WIDTH) / 2, height - PUBLISH_BUTTON_HEIGHT - 69., PUBLISH_BUTTON_WIDTH,PUBLISH_BUTTON_HEIGHT)];
        [self.publishButton setTitle:@"发布消息" forState:UIControlStateNormal];
        [self.publishButton setBackgroundColor:segmentedControlColor];
		[self.publishButton addTarget:self action:@selector(publishBook) forControlEvents:UIControlEventTouchUpInside];
        
        
        [self addSubview:self.publishButton];
        [self.exchangeTableView reloadData];
    }
    
    self.segmentedControl.tintColor = segmentedControlColor;
    _header = [[MJRefreshHeaderView alloc] init];
    _header.delegate = (id)self;
    _header.scrollView = self.exchangeTableView;
    _footer = [[MJRefreshFooterView alloc] init];
    _footer.delegate = (id)self;
    _footer.scrollView = self.exchangeTableView;
    _pageCount = 1;
    
    self.exchangeTableView.delegate = self;
    self.exchangeTableView.dataSource = self;
    self.iLibEngine = [SLAppDelegate sharedDelegate].iLibEngine;
    
    
    [_header beginRefreshing];
	
	[IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
	[IQKeyboardManager sharedManager].shouldShowTextFieldPlaceholder = NO;
    return self;
}



#pragma mark - Table View DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.booksArray) {
        return  [self.booksArray count];
    }
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SLCommentCell";
    SLBookExchangeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[SLBookExchangeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [cell configureForCell:[self.booksArray objectAtIndex:indexPath.row]];
    return cell;
}

#pragma mark - Table View Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 88;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLBookExchangeDetailViewController *detailViewController = [[SLBookExchangeDetailViewController alloc] init];
    [detailViewController setBook:[_booksArray objectAtIndex:indexPath.row]];
    [self.controller.navigationController pushViewController:detailViewController animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Refresh View delegate

- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if ([refreshView isMemberOfClass:[MJRefreshFooterView class]]) {
        NSLog(@"加载更多");
        _pageCount ++;
        NSLog(@"pageCount:%d",_pageCount);
        [self.iLibEngine getFloatBooksWithType:[NSString stringWithFormat:@"%d",self.segmentedControl.selectedSegmentIndex] page:_pageCount onSuccess:^(NSArray *bookArray) {
            NSLog(@"count:%d",bookArray.count);
            [_booksArray addObjectsFromArray:bookArray];
            [_footer endRefreshing];
            [self.exchangeTableView reloadData];
        } onError:^(NSError *engineError) {
            [_footer endRefreshing];
            [UIAlertView showWithTitle:@"获取漂流图书数据错误" message:@"请检查你的网络设置"];
        }];
    }
    else if ([refreshView isMemberOfClass:[MJRefreshHeaderView class]])
    {
        _pageCount = 1;
        [self.iLibEngine getFloatBooksWithType:[NSString stringWithFormat:@"%d",self.segmentedControl.selectedSegmentIndex] page:_pageCount onSuccess:^(NSArray *bookArray) {
            self.booksArray = (id)bookArray;
            [_header endRefreshing];
            [self.exchangeTableView reloadData];
        } onError:^(NSError *engineError) {
            [_header endRefreshing];
            [UIAlertView showWithText:@"获取漂流图书数据失败，请重试"];
        }];
    }
}


#pragma mark - Segment Delegate

- (void)mySegmentValueChanged:(id)sender {
    _pageCount = 1;
    [_iLibEngine getFloatBooksWithType:[NSString stringWithFormat:@"%d",self.segmentedControl.selectedSegmentIndex] page:_pageCount onSuccess:^(NSArray *bookArray) {
        _booksArray = (id)bookArray;
        [self.exchangeTableView reloadData];
    } onError:^(NSError *engineError) {
        [UIAlertView showWithText:@"获取漂流图书数据失败，请重试"];
    }];
}

#pragma mark - PublishBook
- (void)publishBook
{
	SLBookExchangePublishViewController *publish = [[SLBookExchangePublishViewController alloc] init];
	[self.controller.navigationController pushViewController:publish animated:YES];
}

@end
