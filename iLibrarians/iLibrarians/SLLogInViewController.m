#import "SLAppDelegate.h"
#import "SLLoginViewController.h"
#import "SLMyInfoViewController.h"
#import "SLMainViewController.h"
#import "MBProgressHUD.h"

#define tabbarTintColor [UIColor colorWithRed:0.4157 green:0.9216 blue:0.6784 alpha:1.0]

@interface SLLogInViewController ()

@end

@implementation SLLogInViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"登陆"];
    self.usernameTextField.placeholder        = @"默认为学号";
    self.usernameTextField.returnKeyType      = UIReturnKeyNext;
    self.usernameTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.passwordTextField.placeholder        = @"默认为身份证后六位";
    self.passwordTextField.returnKeyType      = UIReturnKeyDone;
    self.passwordTextField.secureTextEntry    = YES;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    self.usernameTextField.text               = [userDefault objectForKey:@"username"];
    self.passwordTextField.text               = [userDefault objectForKey:@"password"];
}



- (IBAction)backgroundTouchUpInside:(id)sender
{
    [self.usernameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

- (IBAction)usernameDidEndOnExit:(id)sender
{
    [self.passwordTextField becomeFirstResponder];
}

- (IBAction)passwordDidEndOnExit:(id)sender
{
    [self resignFirstResponder];
    [self login];
}

- (IBAction)loginTouchUpInside:(id)sender
{
    [self resignFirstResponder];
    [self login];
    
}

- (void)login
{
    if (self.usernameTextField.text == nil || self.passwordTextField.text == nil || [self.usernameTextField.text isEqualToString:@""] || [self.passwordTextField.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"完善信息" message:@"用户名和密码不完整" delegate:nil cancelButtonTitle:@"寡人知道了" otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
    hud.labelText      = @"登录中...";
    [hud show:YES];
    hud.dimBackground  = YES;
    [self.view addSubview:hud];
    
    [[iLIBEngine sharedInstance] loginWithName:self.usernameTextField.text password:self.passwordTextField.text onSucceeded:^{
        NSLog(@"%@ loggin",self.usernameTextField.text);
        NSUserDefaults *userDefaut = [NSUserDefaults standardUserDefaults];
        [userDefaut setObject:self.usernameTextField.text forKey:@"username"];
        [userDefaut setObject:self.passwordTextField.text forKey:@"password"];
        [userDefaut synchronize];
        [hud removeFromSuperview];
        [self goToMainViewController];
    }onError:^(NSError *engineError){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"登陆失败" message:@"请检查用户名密码或网络设置" delegate:self cancelButtonTitle:@"寡人知道了" otherButtonTitles:nil];
        [hud removeFromSuperview];
        [alert show];
        
        [self goToMainViewController];
        NSLog(@"%@ login failed\n",self.usernameTextField.text);
    }];
}

- (void)goToMainViewController
{
    SLMainViewController *mainViewController = [[SLMainViewController alloc] init];
    UINavigationController *mainNavigationController = [[UINavigationController alloc] initWithRootViewController:mainViewController];
    [self presentViewController:mainNavigationController animated:YES completion:nil];
}
@end
