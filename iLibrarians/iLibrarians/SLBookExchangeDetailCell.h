//
//  SLBookExchangeDetailCell.h
//  iLibrarians
//
//  Created by billy.ho on 7/18/14.
//  Copyright (c) 2014 Apple Club. All rights reserved.
//

#import <UIKit/UIKit.h>

@class iLIBFloatBookItem;

@interface SLBookExchangeDetailCell : UITableViewCell

@property (nonatomic,strong) UILabel *usernameLabel;
@property (nonatomic,strong) UILabel *dateLabel;
@property (nonatomic,strong) UILabel *countLabel;
@property (nonatomic,strong) UITextView *contentTextView;
@property (nonatomic,strong) UIImageView *dotImageView;
@property (nonatomic,strong) UIImageView *lineImageView;

- (void)configureForCell:(iLIBFloatBookItem *)bookItem;

@end
