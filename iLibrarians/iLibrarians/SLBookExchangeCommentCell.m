//
//  SLBookExchangeCommentCell.m
//  iLibrarians
//
//  Created by billy.ho on 7/18/14.
//  Copyright (c) 2014 Apple Club. All rights reserved.
//

#import "SLBookExchangeCommentCell.h"
#import "iLIBComment.h"

#define contentFont [UIFont systemFontOfSize:13]

@implementation SLBookExchangeCommentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(7, -340, 1, 750)];
        _lineImageView.image = [UIImage imageNamed:@"line"];
        [self addSubview:_lineImageView];
        
        _dotImageView = [[UIImageView alloc] initWithFrame:CGRectMake(1, 11, 17, 17)];
        _dotImageView.image = [UIImage imageNamed:@"dot"];
        [self addSubview:_dotImageView];
        
        _userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 7, 142, 21)];
        _userNameLabel.textColor = [UIColor greenColor];
        _userNameLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:_userNameLabel];
        
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(209, 11, 113, 16)];
        _dateLabel.textColor = [UIColor lightGrayColor];
        _dateLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:_dateLabel];
        
        _commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(26, 26, 232, 71)];
        _commentLabel.textColor = [UIColor greenColor];
        _commentLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:_commentLabel];
        
        _replyButton = [[UIButton alloc] initWithFrame:CGRectMake(259, 20, 42, 32)];
        _replyButton.titleLabel.text = @"回复";
        //[self addSubview:_replyButton];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureForCell:(iLIBComment *)aComment
{
    UIFont *font = [UIFont systemFontOfSize:13];
    CGRect rect = [aComment.content boundingRectWithSize:CGSizeMake(238, MAXFLOAT)
                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                              attributes:@{NSFontAttributeName:contentFont}
                                                 context:nil];
    [self.commentLabel setFrame:CGRectMake(26,26, 238,rect.size.height+20)];
    self.commentLabel.text = aComment.content;
    self.commentLabel.font = font;
    self.userNameLabel.text = aComment.replyName;
    self.dateLabel.text = [aComment.time substringFromIndex:5];
}

@end
