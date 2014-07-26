//
//  ViewController.m
//  ForumPoster4
//
//  Created by mac on 7/25/14.
//  Copyright (c) 2014 mac. All rights reserved.
//

#import "TopicDetailViewController.h"


@interface TopicDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UITextView *textViewContent;


@end

@implementation TopicDetailViewController


- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.title = @"帖子详情";
    
    CGRect labelRect = CGRectMake(30.0, 30.0, 100.0, 50.0);
    UILabel *alabel = [[UILabel alloc]initWithFrame:labelRect];
    alabel.text = @"a label";
    alabel.textColor = [UIColor blackColor];
    [self.view addSubview:alabel];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
