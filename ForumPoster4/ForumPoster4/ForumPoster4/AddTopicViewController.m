//
//  AddTopicViewController.m
//  ForumPoster4
//
//  Created by mac on 7/25/14.
//  Copyright (c) 2014 mac. All rights reserved.
//

#import "AddTopicViewController.h"
#import "AppDelegate.h"
#import "Topic.h"
#import "Images.h"

@interface AddTopicViewController ()<UITextFieldDelegate, UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textFieldTitle;
@property (weak, nonatomic) IBOutlet UITextView *textViewContent;

@end

@implementation AddTopicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.textViewContent.delegate = self;
    self.textFieldTitle.delegate = self;

}

- (void)viewWillAppear:(BOOL)animated
{
    [self.textFieldTitle becomeFirstResponder];
}

- (IBAction)saveButtonPressed:(id)sender {
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *managedObjectContext = appDelegate.managedObjectContext;
    
    Topic *topic = [NSEntityDescription insertNewObjectForEntityForName:@"Topic" inManagedObjectContext:appDelegate.managedObjectContext];
    
    if (topic != nil) {
        topic.title = self.textFieldTitle.text;
        topic.content = self.textViewContent.text;
        
        NSError *savingError = nil;
        if ([managedObjectContext save:&savingError]) {
            [self.navigationController popViewControllerAnimated:YES];
            [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
        } else {
            NSLog(@"Failed to save the managed object context");
        }
    } else {
        NSLog(@"Failed to create the new Topic object");
    }
    
    
}
- (IBAction)cancelButtonPressed:(id)sender {
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
