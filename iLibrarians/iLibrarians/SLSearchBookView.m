//
//  SLSearchBookView.m
//  iLibrarians
//
//  Created by Hahn.Chan on 7/16/14.
//  Copyright (c) 2014 Apple Club. All rights reserved.
//

#import "SLSearchBookView.h"
#import "SLSearchResultViewController.h"

@interface SLSearchBookView ()

@property (nonatomic, strong) UITextField *searchTextField;
@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;

@end

@implementation SLSearchBookView

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
    self.searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(60., 160., 200., 30.)];
    [self.searchTextField setPlaceholder:@"书名/作者/ISBN"];
    [self.searchTextField setTextAlignment:NSTextAlignmentCenter];
    [self.searchTextField setReturnKeyType:UIReturnKeySearch];
    [self.searchTextField setAutocapitalizationType:UITextAutocapitalizationTypeWords];
    [self.searchTextField setAutocorrectionType:UITextAutocorrectionTypeNo];
    [self.searchTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [self addSubview:self.searchTextField];
    
    
     [self.searchTextField addTarget:self action:@selector(SearchTextFieldDidEndOnExit:) forControlEvents:UIControlEventEditingDidEndOnExit];
     [self.searchTextField addTarget:self action:@selector(SearchTextFieldEditBegin:) forControlEvents:UIControlEventEditingDidBegin];
     [self.searchTextField addTarget:self action:@selector(SearchTextFieldEditEnd:) forControlEvents:UIControlEventEditingDidEnd];
     
     self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRecognizer:)];
     [self addGestureRecognizer:self.tapGestureRecognizer];
}

- (void)tapRecognizer:(UITapGestureRecognizer*)tapGestureRecognizer
{
    [self.searchTextField resignFirstResponder];
}

#pragma mark - TextField Delegate

//click return to start search
- (void)SearchTextFieldDidEndOnExit:(id)sender {
    
    SLSearchResultViewController *resultViewController = [[SLSearchResultViewController alloc] init];
    [self.vc.navigationController pushViewController:resultViewController animated:YES];
    
    [self.searchTextField resignFirstResponder];
}

- (void)SearchTextFieldEditBegin:(id)sender {
}

- (void)SearchTextFieldEditEnd:(id)sender {
}

@end
