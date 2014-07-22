//
//  SLBookItemCell.h
//  iLibrarians
//
//  Created by Hahn.Chan on 7/17/14.
//  Copyright (c) 2014 Apple Club. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLBookItemCell : UITableViewCell

@property (strong, nonatomic)  UIImageView *bookCoverImage;
@property (strong, nonatomic)  UILabel *bookTitleLabel;
@property (strong, nonatomic)  UILabel *bookAuthorLabel;

@end
