//
//  TopicDetailViewController.h
//  ForumPosterObjC3
//
//  Created by mac on 7/18/14.
//  Copyright (c) 2014 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopicDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *topicDetailView;
@property (weak, nonatomic) IBOutlet UILabel *topicTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *topicContentLabel;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) NSDictionary *topicItem;

@end
