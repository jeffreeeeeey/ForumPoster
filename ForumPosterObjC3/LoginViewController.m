//
//  LoginViewController.m
//  ForumPosterObjC3
//
//  Created by mac on 7/18/14.
//  Copyright (c) 2014 mac. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@property (nonatomic) NSURLSession *session;

@end

@implementation LoginViewController

{
    NSURLConnection *connection;
    UIWebView *webView;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
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
    self.navigationItem.title = @"登录账户";
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonPressed:)];
    [self.navigationItem setLeftBarButtonItem:cancelButton];

}

- (void)cancelButtonPressed:(UIButton *)selector
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)loginPressed:(id)sender
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Authentication Challenges

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSString *source = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    [webView loadHTMLString:source baseURL:_url];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
