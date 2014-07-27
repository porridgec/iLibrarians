//
//  SLMyLibraryViewController.h
//  iLibrarians
//
//  Created by johnsonpuning on 14-7-12.
//  Copyright (c) 2014年 Apple Club. All rights reserved.
//

#import <UIKit/UIKit.h>

@class iLIBBookItem;

@protocol BorrowBookDelegate <NSObject>

- (void)showBorrowBookDetailViewControllerWithCoverImage:(UIImage *)coverImage BookItem:(iLIBBookItem*)bookItem;

@end

@interface SLMyLibraryView : UIView

@property (nonatomic,weak) id<BorrowBookDelegate> delegate;

@end
