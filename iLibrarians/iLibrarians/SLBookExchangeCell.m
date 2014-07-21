//
//  SLBookExchangeCell.m
//  iLibrarians
//
//  Created by billy.ho on 7/17/14.
//  Copyright (c) 2014 Apple Club. All rights reserved.
//

#import "SLBookExchangeCell.h"
#import "iLIBFloatBookItem.h"
#import <QuartzCore/QuartzCore.h>

@implementation SLBookExchangeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(7, -298, 1, 750)];
        _lineImage.image = [UIImage imageNamed:@"line"];
        [self addSubview:_lineImage];
        
        _dotImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 8, 20, 20)];
        [self addSubview:_dotImage];
        
        _usernameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 6, 68, 21)];
        _usernameLabel.font = [UIFont systemFontOfSize:12.0];
        [self addSubview:_usernameLabel];
        
        _dataLabel = [[UILabel alloc] initWithFrame:CGRectMake(174, 6, 137, 21)];
        _dataLabel.textColor = [UIColor lightGrayColor];
        _dataLabel.font = [UIFont systemFontOfSize:12.0];
        [self addSubview:_dataLabel];
        
        _backGroundView = [[UIView  alloc] initWithFrame:CGRectMake(20, 28, 280, 56)];
        [self addSubview:_backGroundView];
        
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 6, 240, 35)];
        _contentLabel.textColor = [UIColor whiteColor];
        _contentLabel.font = [UIFont systemFontOfSize:12.0];
        _contentLabel.numberOfLines = 2;
        [_backGroundView addSubview:_contentLabel];
       
        _stateLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 35, 64, 21)];
        _stateLabel.text = @"未匹配";
        _stateLabel.textColor = [UIColor darkGrayColor];
        _stateLabel.font = [UIFont systemFontOfSize:12.0];
        [_backGroundView addSubview:_stateLabel];
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureForCell:(iLIBFloatBookItem *)bookItem
{
    if (bookItem.type == 0) {
        _usernameLabel.textColor = [UIColor colorWithRed:136/255.0 green:216/255.0 blue:231/255.0 alpha:1];
        _backGroundView.backgroundColor = [UIColor colorWithRed:136/255.0 green:216/255.0 blue:231/255.0 alpha:1];
        _dotImage.image = [UIImage imageNamed:@"dot_b.png"];
    }
    else if(bookItem.type == 1){
        _usernameLabel.textColor = [UIColor colorWithRed:255/255.0 green:202/255.0 blue:110/255.0 alpha:1];
        _backGroundView.backgroundColor = [UIColor colorWithRed:255/255.0 green:202/255.0 blue:110/255.0 alpha:1];
        _dotImage.image = [UIImage imageNamed:@"dot_o.png"];
    }
    _usernameLabel.text = bookItem.userName;
    _backGroundView.layer.cornerRadius = 8;
    _contentLabel.text = bookItem.content;
    _dataLabel.text = bookItem.date;
    _stateLabel.text = @"";
}

@end
