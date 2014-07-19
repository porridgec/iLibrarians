//
//  SLBookDetailViewController.h
//  iLibrarians
//
//  Created by Hahn.Chan on 7/15/14.
//  Copyright (c) 2014 Apple Club. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLSearchResultViewController.h"

@interface SLBookDetailViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic)  UILabel *bookTitleLabel;
@property (strong, nonatomic)  UIImageView *bookCoverImage;
@property (strong, nonatomic)  UILabel *bookIndexLabel;
@property (strong, nonatomic)  UILabel *authorLabel;
@property (strong, nonatomic)  UILabel *publishLabel;
@property (strong, nonatomic)  UITableView *statusTableView;

@property (strong, nonatomic) NSString *bookTitle;
@property (strong, nonatomic) NSString *bookIndex;
@property (strong, nonatomic) NSString *publish;
@property (strong, nonatomic) NSString *author;
@property (strong, nonatomic) NSString *docNumber;
@property (strong, nonatomic) UIImage *bookCover;
@property (strong, nonatomic) NSMutableArray *status;

@property (strong, nonatomic) iLIBEngine *iLibEngine;

@end
