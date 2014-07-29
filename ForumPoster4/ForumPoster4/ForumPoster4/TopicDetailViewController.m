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

@property (strong, nonatomic)UIScrollView *scrollViewContent;
//@property (strong, nonatomic) UILabel *labelTitle;
//@property (strong, nonatomic) UITextView *textViewContent;
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
    self.navigationItem.title = @"帖子详情";
    
    CGRect titleRect = CGRectMake(10, 70, self.view.bounds.size.width - 20, 30);
    CGRect contentRect = CGRectZero;
    
    UILabel *labelTitle = [[UILabel alloc]initWithFrame:titleRect];
    UITextView *textViewContent = [[UITextView alloc]initWithFrame:contentRect];
    
    labelTitle.text = self.topic.title;
    textViewContent.text = self.topic.content;
    
    
    
    self.scrollViewContent = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    _scrollViewContent.delegate = self;
    //_scrollViewContent.backgroundColor = [UIColor lightGrayColor];
    
    
    
    labelTitle.frame = titleRect;
    textViewContent.frame = contentRect;
    
    [_scrollViewContent addSubview:labelTitle];
    [_scrollViewContent addSubview:textViewContent];
    
    

    
    [self.view addSubview:_scrollViewContent];
    
    textViewContent.frame = CGRectMake(10, 120, self.view.bounds.size.width - 20, 500);
    CGFloat fixedWidth = self.view.bounds.size.width - 20.0;
    CGSize newSize = [textViewContent sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
    CGRect newFrame = textViewContent.frame;
    newFrame.size = CGSizeMake(fixedWidth, newSize.height);
    textViewContent.frame = newFrame;
    
    _scrollViewContent.contentSize = CGSizeMake(self.view.bounds.size.width, 100 + textViewContent.frame.size.height);
    
    
    
    
    // Config images
    if (self.topic.images.count > 0) {
        //move content view down 170
        
        CGRect newFrame = textViewContent.frame;
        newFrame.origin = CGPointMake(10, 290);
        textViewContent.frame = newFrame;
        
        
        NSArray *imagesEntityArray = [self.topic.images allObjects];
        //NSLog(@"There are %lu pictures in this topic.", (unsigned long)imagesEntityArray.count);
        self.imagesScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(10, 120, 300, 170)];
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
        [self.scrollViewContent addSubview:_imagesScrollView];
    }
    
    //NSLog(@"content height:%f\n", textViewContent.frame.size.height);
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
