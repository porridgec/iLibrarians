//
//  SLBookDetailViewController.h
//  iLibrarians
//
//  Created by Hahn.Chan on 7/15/14.
//  Copyright (c) 2014 Apple Club. All rights reserved.
//

#import <UIKit/UIKit.h>

@class iLIBFloatBookItem;

@interface SLBookDetailViewController : UIViewController<UITableViewDelegate,UITableViewDataSource, UITextFieldDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIView *textFieldBackgroundView;
@property (nonatomic,strong) UITextField *textField;
@property (nonatomic,strong) UIButton *publishButton;
@property (nonatomic,strong) iLIBFloatBookItem *book;

- (void)publishComment:(id)sender;
- (void)textFieldDidEndEditing:(id)sender;


@end
