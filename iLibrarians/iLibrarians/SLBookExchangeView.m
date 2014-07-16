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
#import "ArrayDataSource.h"
#import "iLIBEngine.h"

#define NAVIGATONBAR_HEIGHT 32
#define SEGMENT_HEIGHT 29
#define PUBLISH_BUTTON_WIDTH 200
#define PUBLISH_BUTTON_HEIGHT 20

#define cellBackGroundColor [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5]
#define segmentedControlColor [UIColor colorWithRed:0.4784 green:0.9255 blue:0.7098 alpha:1.0]


@interface SLBookExchangeView ()
{
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
        [self addSubview:self.segmentedControl];
        
        
        self.exchangeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0., SEGMENT_HEIGHT, width, height - PUBLISH_BUTTON_HEIGHT - 69. - NAVIGATONBAR_HEIGHT)];
        [self addSubview:self.exchangeTableView];
        
        self.publishButton = [[UIButton alloc] initWithFrame:CGRectMake((width - PUBLISH_BUTTON_WIDTH) / 2, height - PUBLISH_BUTTON_HEIGHT - 69., PUBLISH_BUTTON_WIDTH,PUBLISH_BUTTON_HEIGHT)];
        [self.publishButton setTitle:@"发布消息" forState:UIControlStateNormal];
        [self.publishButton setBackgroundColor:[UIColor blueColor]];
        
        
        [self addSubview:self.publishButton];
        [self.exchangeTableView reloadData];
    }
    
    self.segmentedControl.tintColor = segmentedControlColor;
    _footer = [[MJRefreshFooterView alloc] init];
    _footer.delegate = (id)self;
    _footer.scrollView = self.exchangeTableView;
    _pageCount = 1;
    

    _iLibEngine = [SLAppDelegate sharedDelegate].iLibEngine;
    [_iLibEngine getFloatBooksWithType:@"0" page:_pageCount onSuccess:^(NSArray *bookArray) {
        bookArray = (id)bookArray;
        [self setupTableView];
    } onError:^(NSError *engineError) {
        [UIAlertView showWithText:@"获取漂流图书数据失败，请重试"];
    }];
    
    return self;
}



#pragma mark - Table View DataSource


- (void)setupTableView
{
    TableViewConfigureBlock configureBlock = ^(iLIBBookFloatCell *cell,iLIBFloatBookItem *bookItem)
    {
        [cell configureForCell:bookItem];
    };
    _booksDataSource = [[ArrayDataSource alloc] initWithItems:_booksArray cellIndetifier:@"iLIBBookFloatCell" configureCellBlock:configureBlock];
    _booksDataSource.items = _booksArray;
    _tableView.delegate = (id)self;
    _tableView.dataSource = _booksDataSource;
    [_tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SLCommentCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"Row %d", indexPath.row];
    return cell;
}

#pragma mark - Table View Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
