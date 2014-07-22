//
//  TopicDetailViewController.m
//  ForumPosterObjC3
//
//  Created by mac on 7/18/14.
//  Copyright (c) 2014 mac. All rights reserved.
//

#import "TopicDetailViewController.h"

@interface TopicDetailViewController () <UIScrollViewDelegate>

@end

@implementation TopicDetailViewController

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
    // Do any additional setup after loading the view.
    
    // Config the scrollView
    CGRect scrollViewRect = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64);
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:scrollViewRect];
    scrollView.delegate = self;
    scrollView.backgroundColor = [UIColor grayColor];
    
    [scrollView addSubview:self.topicDetailView];
    [self.view addSubview:scrollView];
    scrollView.contentSize = self.view.bounds.size;
    
    // Config the content
    self.topicTitleLabel.text = [self.topicItem objectForKey:@"topicTitle"];
    self.contentTextView.text = [self.topicItem objectForKey:@"topicContent"];
    self.imageView.image = [UIImage imageWithContentsOfFile:[self.topicItem objectForKey:@"image_filepath"]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
