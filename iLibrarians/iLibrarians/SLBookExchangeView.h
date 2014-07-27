//
//  SLBookExchangeView.h
//  iLibrarians
//
//  Created by billy.ho on 7/16/14.
//  Copyright (c) 2014 Apple Club. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLMainViewController.h"

@class iLIBFloatBookItem;

@protocol BookExchangeDelegate <NSObject>

- (void)showBookExchangeDetailViewControllerWithBook:(iLIBFloatBookItem*)book;

@end

@interface SLBookExchangeView : UIView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) id<BookExchangeDelegate> delegate;

@end
