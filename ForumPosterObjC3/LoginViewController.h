//
//  LoginViewController.h
//  ForumPosterObjC3
//
//  Created by mac on 7/18/14.
//  Copyright (c) 2014 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController <UIWebViewDelegate>

+ (id) controllerWithURL: (NSURL *)aURL;
@property (nonatomic) NSURL *url;
@property (nonatomic) BOOL shouldFail;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;



@end
