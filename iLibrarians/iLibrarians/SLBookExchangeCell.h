//
//  SLBookExchangeCell.h
//  iLibrarians
//
//  Created by billy.ho on 7/17/14.
//  Copyright (c) 2014 Apple Club. All rights reserved.
//

#import <UIKit/UIKit.h>
@class iLIBFloatBookItem;

@interface SLBookExchangeCell : UITableViewCell

@property (nonatomic,strong) UILabel *usernameLabel;
@property (nonatomic,strong) UILabel *dataLabel;
@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,strong) UILabel *stateLabel;
@property (nonatomic,strong) UIView *backGroundView;
@property (nonatomic,strong) UIImageView *dotImage;
@property (nonatomic,strong) UIImageView *lineImage;

- (void)configureForCell:(iLIBFloatBookItem *)bookItem;

@end
