//
//  SLMyLibraryViewController.m
//  iLibrarians
//
//  Created by johnsonpuning on 14-7-12.
//  Copyright (c) 2014年 Apple Club. All rights reserved.
//

#import "SLMyLibraryView.h"

@interface SLMyLibraryView ()

@property (nonatomic, strong) UISegmentedControl *segmentControl;
@property (nonatomic, strong) UITableView *myLibraryTableView;

@end

@implementation SLMyLibraryView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    [self initView];
    return self;
}

- (void)initView
{
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    NSArray *segmentItems = @[@"借阅查询", @"图书荐购", @"个人信息"];
    self.segmentControl = [[UISegmentedControl alloc] initWithItems:segmentItems];
    [self.segmentControl setFrame:CGRectMake(0., 0., width, 29.)];
    [self addSubview:self.segmentControl];
    
    self.myLibraryTableView = [[UITableView alloc] initWithFrame:CGRectMake(0., 29., width, height - 29.)];
    [self addSubview:self.myLibraryTableView];
    
}


@end
