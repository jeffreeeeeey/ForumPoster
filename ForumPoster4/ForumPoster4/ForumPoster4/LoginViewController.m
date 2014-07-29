//
//  LoginViewController.m
//  ForumPoster4
//
//  Created by mac on 7/29/14.
//  Copyright (c) 2014 mac. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()<NSURLSessionDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textFieldUserName;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPassWord;
@property NSURLSession *loginSession;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSURLSessionConfiguration *configSession = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSString *cachePath = @"/MyCacheDirectory";
    NSArray *myPathList = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *myPath = [myPathList objectAtIndex:0];
    
    NSString *bundleIdentifier = [[NSBundle mainBundle]bundleIdentifier];
    
    NSString *fullCachePath = [[myPath stringByAppendingPathComponent:bundleIdentifier]stringByAppendingPathComponent:cachePath];
    
    NSLog(@"Cache path: %@\n", fullCachePath);
    
    NSURLCache *myCache = [[NSURLCache alloc]initWithMemoryCapacity:16384 diskCapacity:268435456 diskPath:cachePath];
    configSession.URLCache = myCache;
    configSession.requestCachePolicy = NSURLRequestUseProtocolCachePolicy;
    
    self.loginSession = [NSURLSession sessionWithConfiguration:configSession delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    self.navigationItem.title = @"登录账户";
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelButtonPressed:)];
    [self.navigationItem setLeftBarButtonItem:cancelButton];
}

- (IBAction)loginButtonPressed:(id)sender {
    
    NSString *loginString = [NSString stringWithFormat:@"http://chaoqing.llzg.cn/user/login?accountName=%@&pwd=%@", self.textFieldUserName.text, self.textFieldPassWord.text];
    
    NSURL *url = [NSURL URLWithString:loginString];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)cancelButtonPressed:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
