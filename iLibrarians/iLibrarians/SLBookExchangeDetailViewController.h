//
//  SLBookExchangeDetailViewController.h
//  iLibrarians
//
//  Created by BILLY HO on 7/19/14.
//  Copyright (c) 2014 Apple Club. All rights reserved.
//

#import <UIKit/UIKit.h>

@class iLIBFloatBookItem;

@interface SLBookExchangeDetailViewController : UIViewController<UITableViewDelegate,UITableViewDataSource, UITextFieldDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIView *textFieldBackgroundView;
@property (nonatomic,strong) UITextField *textField;
@property (nonatomic,strong) UIButton *publishButton;
@property (nonatomic,strong) iLIBFloatBookItem *book;

- (void)publishComment;
- (void)textFieldDidEndEditing;


@end
