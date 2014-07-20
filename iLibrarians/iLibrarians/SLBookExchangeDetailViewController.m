//
//  SLBookExchangeDetailViewController.m
//  iLibrarians
//
//  Created by BILLY HO on 7/19/14.
//  Copyright (c) 2014 Apple Club. All rights reserved.
//

#import "SLBookExchangeDetailViewController.h"

#import "MJRefresh.h"
#import "iLIBEngine.h"
#import "SLBookExchangeDetailCell.h"
#import "SLBookExchangeCommentCell.h"
#import "iLIBFloatBookItem.h"
#import "iLIBComment.h"
#import "SLAppDelegate.h"
#import "IQKeyboardManager.h"

#define MAX_HEIGHT 500
#define contentFont [UIFont systemFontOfSize:13]
#define textFieldBackgroundColor [UIColor colorWithRed:0.4784 green:0.9255 blue:0.7098 alpha:1.0]

@interface SLBookExchangeDetailViewController ()
{
    MJRefreshHeaderView *_header;
    MJRefreshFooterView *_footer;
}

@property(nonatomic,assign) int pageCount;
@property(nonatomic,strong) iLIBEngine *iLibEngine;
@property(nonatomic,strong) iLIBComment *comment;
@property(nonatomic,strong) NSMutableArray *commentArray;
@end

@implementation SLBookExchangeDetailViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
		self.title = @"评论";
		
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, 320, self.view.frame.size.height-40-64)];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        [self.view addSubview:self.tableView];
        
        self.textFieldBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-35, 320, 35)];
        self.textFieldBackgroundView.backgroundColor = textFieldBackgroundColor;
        [self.view addSubview:self.textFieldBackgroundView];
        
        self.textField = [[UITextField alloc] initWithFrame:CGRectMake(9, 5, 259, 25)];
        self.textField.placeholder = @"我也来说两句";
        [self.textField setBorderStyle:UITextBorderStyleRoundedRect];
		self.textField.inputAccessoryView = [[UIView alloc]init];
		self.textField.returnKeyType = UIReturnKeyDone;
		self.textField.delegate = self;
		[self.textFieldBackgroundView addSubview:self.textField];
        
        self.publishButton = [[UIButton alloc] initWithFrame:CGRectMake(276, 2, 35, 30)];
        [self.publishButton setTitle:@"发表" forState:UIControlStateNormal];
        self.publishButton.titleLabel.font = [UIFont systemFontOfSize:16];
        self.publishButton.titleLabel.textColor = [UIColor darkGrayColor];
        [self.publishButton addTarget:self action:@selector(publishComment) forControlEvents:UIControlEventTouchUpInside];
        [self.textFieldBackgroundView addSubview:self.publishButton];
        
        _header = [[MJRefreshHeaderView alloc] init];
        _header.delegate = (id)self;
        _header.scrollView = self.tableView;
        _footer = [[MJRefreshFooterView alloc] init];
        _footer.delegate = (id)self;
        _footer.scrollView = self.tableView;
		[_header beginRefreshing];
		
		
        self.iLibEngine = [SLAppDelegate sharedDelegate].iLibEngine;
		_pageCount = 1;
		
        
        
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

#pragma mark - Table View DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_commentArray count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        SLBookExchangeDetailCell *cell = [[SLBookExchangeDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BookDetailCell"];
        [cell configureForCell:_book];
        cell.countLabel.text = [NSString stringWithFormat:@"评论 :%d",_commentArray.count];
        return cell;
    }
    
    static NSString *CellIdentifier = @"iLIBCommentCell";
    SLBookExchangeCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[SLBookExchangeCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [cell configureForCell:[_commentArray objectAtIndex:indexPath.row-1]];
    return cell;
}

#pragma mark - Table View Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        CGRect rect = [_book.content boundingRectWithSize:CGSizeMake(278, MAXFLOAT)
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                               attributes:@{NSFontAttributeName:contentFont}
                                                  context:nil];
        return 50 + (rect.size.height>80?rect.size.height:80);
    }
    iLIBComment* comment = [_commentArray objectAtIndex:indexPath.row-1];
    CGRect rect = [comment.content boundingRectWithSize:CGSizeMake(232, MAXFLOAT)
                                                options:NSStringDrawingUsesLineFragmentOrigin
                                             attributes:@{NSFontAttributeName:contentFont}
                                                context:nil];
    return 40+rect.size.height;
}

#pragma mark - Refresh View Delegate

- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if (_header == refreshView)
	{
		_pageCount = 1;
		[self.iLibEngine getCommentWithId:self.book.resId page:_pageCount onSucceeded:^(NSArray *bookArray) {
			_commentArray = (id)bookArray;
			[_tableView reloadData];
		} onError:^(NSError *engineError) {
			NSLog(@"Get Comments Error");
		}];
        NSLog(@"刷新");
    }
    else
	{
        NSLog(@"加载更多");
        _pageCount ++;
        NSLog(@"pageCount:%d",_pageCount);
        [self.iLibEngine getCommentWithId:self.book.resId page:_pageCount onSucceeded:^(NSArray *bookArray) {
            [_commentArray addObjectsFromArray:bookArray];
        } onError:^(NSError *engineError) {
            NSLog(@"Get Comments Error");
        }];
    }
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(reloadTableView) userInfo:nil repeats:NO];
}

- (void)reloadTableView
{
    [_tableView reloadData];
    [_header endRefreshing];
    [_footer endRefreshing];
}
#pragma mark - Selector

- (void)publishComment
{
	[_textField resignFirstResponder];
    if (_comment == nil) {
        _comment = [[iLIBComment alloc] init];
    }
    _comment.userId = _book.userId;
    _comment.userName = _book.userName;
    _comment.replyId = _iLibEngine.studentId;
    _comment.replyName = _iLibEngine.studentName;
    _comment.resId = _book.resId;
    _comment.content = _textField.text;
    [_iLibEngine writeCommentWithId:_comment onSucceeded:^{
        [UIAlertView showWithText:@"评论成功"];
        _comment.content = @"";
        _textField.text = @"";
        [self performSelector:@selector(refresh) withObject:nil];
    } onError:^(NSError *engineError) {
        [UIAlertView showWithTitle:@"评论失败" message:@"请检查你的网络设置"];
    }];
}

- (void)refresh
{
    _pageCount = 1;
    [self.iLibEngine getCommentWithId:self.book.resId page:_pageCount onSucceeded:^(NSArray *bookArray) {
        _commentArray = (id)bookArray;
        [_tableView reloadData];
    } onError:^(NSError *engineError) {
        NSLog(@"Get Comments Error");
    }];
}

#pragma mark - TextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	NSLog(@"return");
	[self publishComment];
	return YES;
}


@end
