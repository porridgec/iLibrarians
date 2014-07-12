//
//  SLSearchBookViewController.m
//  iLibrarians
//
//  Created by johnsonpuning on 14-7-12.
//  Copyright (c) 2014年 Apple Club. All rights reserved.
//

#import "SLSearchBookViewController.h"

@interface SLSearchBookViewController ()

@property (nonatomic, strong) UITextField *searchTextField;
@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;

@end

@implementation SLSearchBookViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
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
    [self.view addSubview:self.searchTextField];
    
    /*
    [self.searchTextField addTarget:self action:@selector(SearchTextFieldDidEndOnExit:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.searchTextField addTarget:self action:@selector(SearchTextFieldEditBegin:) forControlEvents:UIControlEventEditingDidBegin];
    [self.searchTextField addTarget:self action:@selector(SearchTextFieldEditEnd:) forControlEvents:UIControlEventEditingDidEnd];
    
    self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRecognizer:)];
    [self.view addGestureRecognizer:self.tapGestureRecognizer];*/
}

- (void)tapRecognizer:(UITapGestureRecognizer*)tapGestureRecognizer
{
    [self.searchTextField resignFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initView];
}

#pragma mark - TextField Delegate

//click return to start search
- (void)SearchTextFieldDidEndOnExit:(id)sender {
    [self.searchTextField resignFirstResponder];
}

- (void)SearchTextFieldEditBegin:(id)sender {
}

- (void)SearchTextFieldEditEnd:(id)sender {
}

@end
