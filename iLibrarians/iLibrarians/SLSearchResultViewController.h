//
//  SLSearchResultViewController.h
//  iLibrarians
//
//  Created by Hahn.Chan on 7/15/14.
//  Copyright (c) 2014 Apple Club. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iLIBEngine.h"

#define kHostUrl @"libapi.insysu.com"

@interface SLSearchResultViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>


@property (strong,nonatomic) iLIBEngine *iLibEngine;
@property (strong,nonatomic) UITableView *resultTableView;
@property (strong,nonatomic) NSMutableArray *searchedBooks;
@property (strong,nonatomic) NSString *searchString;
@property (strong,nonatomic) NSString *bookNumber;
@property BOOL didFinishedSearching;
@property BOOL didFinishLoadingMore;
@property int bookCount ;
@property int pageCount;
@property int cellCount;
@property int pageIndex;

@end
