//
//  SLBookExchangePublishViewController.m
//  iLibrarians
//
//  Created by BILLY HO on 7/19/14.
//  Copyright (c) 2014 Apple Club. All rights reserved.
//

#import "SLBookExchangePublishViewController.h"
#import "SLAppDelegate.h"
#import "iLIBEngine.h"
#import "iLIBFloatBookItem.h"
#import "IQKeyboardManager.h"

#define labelColor [UIColor colorWithRed:0.4784 green:0.9255 blue:0.7098 alpha:1.0]
#define borrowColor [UIColor colorWithRed:255/255.0 green:202/255.0 blue:110/255.0 alpha:1];
#define lendColor [UIColor colorWithRed:136/255.0 green:216/255.0 blue:231/255.0 alpha:1];

@interface SLBookExchangePublishViewController ()

@property(nonatomic,strong)iLIBEngine *iLibEngine;
@property(nonatomic,strong)iLIBFloatBookItem *book;

@property(nonatomic,strong)UITextField *titleTextField;
@property(nonatomic,strong)UITextField *autherTextField;
@property(nonatomic,strong)UITextView *descriptionTextView;

@end

@implementation SLBookExchangePublishViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
		[self setTitle:@"发布消息"];
		self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
		
		UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(43, 76, 39, 21)];
		titleLabel.text = @"书名";
		titleLabel.font = [UIFont systemFontOfSize:14];
		titleLabel.textColor = labelColor;
		[self.view addSubview:titleLabel];
		
		_titleTextField = [[UITextField alloc] initWithFrame:CGRectMake(44, 100, 215, 30)];
		[_titleTextField setBorderStyle:UITextBorderStyleRoundedRect];
		_titleTextField.placeholder = @"请填写书名";
		_titleTextField.font = [UIFont systemFontOfSize:14];
		_titleTextField.returnKeyType = UIReturnKeyNext;
		[self.view addSubview:_titleTextField];
		
		
		UILabel *authorLabel = [[UILabel alloc] initWithFrame:CGRectMake(43, 141, 39, 21)];
		authorLabel.text = @"作者";
		authorLabel.font = [UIFont systemFontOfSize:14];
		authorLabel.textColor = labelColor;
		[self.view addSubview:authorLabel];
		
		_autherTextField = [[UITextField alloc]initWithFrame:CGRectMake(45, 170, 214, 30)];
		[_autherTextField setBorderStyle:UITextBorderStyleRoundedRect];
		_autherTextField.placeholder = @"请填写作者名字";
		_autherTextField.font = [UIFont systemFontOfSize:14];
		[self.view addSubview:_autherTextField];
		
		
		UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 213, 34, 21)];
		descriptionLabel.text = @"描述";
		descriptionLabel.font = [UIFont systemFontOfSize:14];
		descriptionLabel.textColor = labelColor;
		[self.view addSubview:descriptionLabel];
		
		_descriptionTextView = [[UITextView alloc] initWithFrame:CGRectMake(45, 242, 216, 161)];
		_descriptionTextView.backgroundColor = [UIColor whiteColor];
		_descriptionTextView.alpha = 1.0f;
		_descriptionTextView.layer.cornerRadius = 5.0f;
		_descriptionTextView.font = [UIFont systemFontOfSize:14];
		[self.view addSubview:_descriptionTextView];
		
		UIButton *borrowButton = [[UIButton alloc] initWithFrame:CGRectMake(45, 419, 103, 30)];
		[borrowButton setTitle:@"求借" forState:UIControlStateNormal];
		borrowButton.titleLabel.textColor = [UIColor whiteColor];
		borrowButton.titleLabel.font = [UIFont systemFontOfSize:15];
		borrowButton.backgroundColor = borrowColor;
		[borrowButton addTarget:self action:@selector(publishBegBook:) forControlEvents:UIControlEventTouchUpInside];
		[self.view addSubview:borrowButton];
		
		UIButton *lendButton = [[UIButton alloc] initWithFrame:CGRectMake(156, 419, 103, 30)];
		[lendButton setTitle:@"闲置" forState:UIControlStateNormal];
		lendButton.titleLabel.textColor = [UIColor whiteColor];
		lendButton.titleLabel.font = [UIFont systemFontOfSize:15];
		lendButton.backgroundColor = lendColor;
		[lendButton addTarget:self action:@selector(publishIdleBook:) forControlEvents:UIControlEventTouchUpInside];
		[self.view addSubview:lendButton];
		
		_book = [[iLIBFloatBookItem alloc] init];
		_iLibEngine = [SLAppDelegate sharedDelegate].iLibEngine;
	}
    return self;
}

- (void)viewDidLoadr
{
    [super viewDidLoad];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [_iLibEngine cancelAllOperations];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - TextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
	NSLog(@"return");
	return YES;
}

#pragma mark - TextView Delegate


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

#pragma mark - Publish FloatBook Selector

- (void)publishIdleBook:(id)sender
{
    _book.type = 0;
    [self performSelector:@selector(publishFloatBook) withObject:nil];
}

- (void)publishBegBook:(id)sender
{
    _book.type = 1;
    [self performSelector:@selector(publishFloatBook) withObject:nil];
}

- (void)publishFloatBook
{
    [_descriptionTextView resignFirstResponder];
    _book.booktitle = _titleTextField.text;
    _book.bookAuthor = _autherTextField.text;
    _book.content = _descriptionTextView.text;
    _book.userId = _iLibEngine.studentId;
    _book.userName = _iLibEngine.studentName;
    [_iLibEngine publishFloatBooks:self.book onSuccess:^{
		[UIAlertView showWithText:@"发布消息成功"];
		_titleTextField.text = @"";
		_autherTextField.text = @"";
		_descriptionTextView.text = @"";
		NSLog(@"发布消息成功");
	} onError:^(NSError *engineError) {
		[UIAlertView showWithTitle:@"发布消息失败" message:@"请检查你的网络设置"];
		NSLog(@"发布消息失败");
	}];
}


@end
