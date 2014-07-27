//
//  ViewController.m
//  ForumPoster4
//
//  Created by mac on 7/25/14.
//  Copyright (c) 2014 mac. All rights reserved.
//

#import "TopicDetailViewController.h"
#import "Images.h"


@interface TopicDetailViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UITextView *textViewContent;
@property (strong, nonatomic) UIScrollView *imagesScrollView;


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
    
    
    
    if (self.topic.images.count > 0) {
        NSArray *imagesEntityArray = [self.topic.images allObjects];
        NSLog(@"There are %lu pictures in this topic.", (unsigned long)imagesEntityArray.count);
        
        // Config images
        self.imagesScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(10, 300, 300, 170)];
        self.imagesScrollView.delegate = self;
        self.imagesScrollView.contentSize = CGSizeMake(320, 170);
        self.imagesScrollView.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:self.imagesScrollView];
        
        for (int i = 0; i < imagesEntityArray.count; i++) {
            [self.imagesScrollView setContentSize:CGSizeMake(160 * imagesEntityArray.count, 150)];
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(160 * i, 10, 150, 150)];
            Images *imageEntity = [imagesEntityArray objectAtIndex:i];
            UIImage *image = imageEntity.image;
            imageView.image = image;
            
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.layer.masksToBounds = YES;
            [self.imagesScrollView addSubview:imageView];
        }
        
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
