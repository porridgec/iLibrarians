//
//  SLLogInViewController.h
//  iLibrarians
//
//  Created by johnson on 14-7-8.
//  Copyright (c) 2014年 Apple Club. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "iLIBEngine.h"

@class iLIBEngine;

@interface SLLogInViewController : UIViewController<UITabBarControllerDelegate>

@property (strong, nonatomic) IBOutlet UITextField *usernameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;

- (IBAction)usernameDidEndOnExit:(id)sender;
- (IBAction)passwordDidEndOnExit:(id)sender;
- (IBAction)loginTouchUpInside:(id)sender;
- (IBAction)backgroundTouchUpInside:(id)sender;

@end
