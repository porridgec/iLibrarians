//
//  SLBookItemCell.m
//  iLibrarians
//
//  Created by Hahn.Chan on 7/17/14.
//  Copyright (c) 2014 Apple Club. All rights reserved.
//

#import "SLBookItemCell.h"

@implementation SLBookItemCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self setupSelf];
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

- (void)setupSelf
{
    self.bookCoverImage  = [[UIImageView alloc] initWithFrame:CGRectMake(9, 9, 48, 48)];
    self.bookTitleLabel  = [[UILabel alloc] initWithFrame:CGRectMake(74, 0, 220, 50)];
    self.bookAuthorLabel = [[UILabel alloc] initWithFrame:CGRectMake(74, 44, 220, 21)];
    
    [self.bookTitleLabel setFont:  [UIFont systemFontOfSize:17]];
    [self.bookAuthorLabel setFont: [UIFont italicSystemFontOfSize:12]];
    [self.bookAuthorLabel setTextColor:[UIColor grayColor]];
    
    
    [self addSubview:self.bookCoverImage];
    [self addSubview:self.bookTitleLabel];
    [self addSubview:self.bookAuthorLabel];
}

@end
