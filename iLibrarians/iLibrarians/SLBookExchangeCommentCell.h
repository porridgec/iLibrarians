//
//  SLBookExchangeCommentCell.h
//  iLibrarians
//
//  Created by billy.ho on 7/18/14.
//  Copyright (c) 2014 Apple Club. All rights reserved.
//

#import <UIKit/UIKit.h>
@class iLIBComment;

@interface SLBookExchangeCommentCell : UITableViewCell

@property (nonatomic,strong) UILabel *commentLabel;
@property (nonatomic,strong) UILabel *userNameLabel;
@property (nonatomic,strong) UILabel *dateLabel;
@property (nonatomic,strong) UIButton *replyButton;
@property (nonatomic,strong) UIImageView *dotImageView;
@property (nonatomic,strong) UIImageView *lineImageView;

- (void)configureForCell:(iLIBComment *)aComment;
@end
