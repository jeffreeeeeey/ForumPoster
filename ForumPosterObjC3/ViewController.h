//
//  ViewController.h
//  ForumPosterObjC3
//
//  Created by mac on 7/18/14.
//  Copyright (c) 2014 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddNewPostViewController.h"
#import "TopicListTableViewController.h"
#import "LoginViewController.h"

@interface ViewController : UIViewController

@property (nonatomic) BOOL *loginStatus;

- (IBAction)addNewPostPressed:(id)sender;
- (IBAction)topicListPressed:(id)sender;

@end

