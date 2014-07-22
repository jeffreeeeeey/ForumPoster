//
//  ViewController.m
//  ForumPosterObjC3
//
//  Created by mac on 7/18/14.
//  Copyright (c) 2014 mac. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
            

@end

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    self.loginStatus = YES;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addNewPostPressed:(id)sender
{
    if (self.loginStatus == NO) {
        LoginViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"login"];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
        [self.navigationController presentViewController:nav animated:YES completion:nil];
    } else {
        AddNewPostViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"AddNewPost"];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
        [self.navigationController presentViewController:nav animated:YES completion:nil];
    }
}

- (IBAction)topicListPressed:(id)sender
{
    TopicListTableViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"TopicList"];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
