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
    self.navigationController.title = @"帖子详情";
    
    self.labelTitle.text = self.topic.title;
    self.textViewContent.text = self.topic.content;
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
