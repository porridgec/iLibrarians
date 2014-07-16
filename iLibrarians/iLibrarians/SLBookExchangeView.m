//
//  SLBookExchangeView.m
//  iLibrarians
//
//  Created by billy.ho on 7/16/14.
//  Copyright (c) 2014 Apple Club. All rights reserved.
//

#import "SLBookExchangeView.h"
#import "SLPublishViewController.h"

#define NAVIGATONBAR_HEIGHT 32
#define SEGMENT_HEIGHT 29
#define PUBLISH_BUTTON_WIDTH 200
#define PUBLISH_BUTTON_HEIGHT 20


@interface SLBookExchangeView ()

@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) UITableView *exchangeTableView;

@end

@implementation SLBookExchangeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat width = self.frame.size.width;
        CGFloat height = self.frame.size.height;
        NSArray *segmentItems = @[@"闲置", @"求借"];
        self.segmentedControl = [[UISegmentedControl alloc] initWithItems:segmentItems];
        [self.segmentedControl setFrame:CGRectMake(0., 0., width, SEGMENT_HEIGHT)];
        [self addSubview:self.segmentedControl];
        
        
        self.exchangeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0., SEGMENT_HEIGHT, width, height - PUBLISH_BUTTON_HEIGHT - 69. - NAVIGATONBAR_HEIGHT)];
        self.exchangeTableView.delegate = self;
        self.exchangeTableView.dataSource = self;
        [self addSubview:self.exchangeTableView];
        
        self.publishButton = [[UIButton alloc] initWithFrame:CGRectMake((width - PUBLISH_BUTTON_WIDTH) / 2, height - PUBLISH_BUTTON_HEIGHT - 69., PUBLISH_BUTTON_WIDTH,PUBLISH_BUTTON_HEIGHT)];
        [self.publishButton setTitle:@"发布消息" forState:UIControlStateNormal];
        [self.publishButton setBackgroundColor:[UIColor blueColor]];
        
        
        [self addSubview:self.publishButton];
        [self.exchangeTableView reloadData];
    }
    return self;
}



#pragma mark - Table View DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SLCommentCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"Row %d", indexPath.row];
    return cell;
}

#pragma mark - Table View Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
