//
//  AddNewPostViewController.m
//  ForumPosterObjC3
//
//  Created by mac on 7/18/14.
//  Copyright (c) 2014 mac. All rights reserved.
//

#import "AddNewPostViewController.h"

@interface AddNewPostViewController ()

@end

@implementation AddNewPostViewController

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
    
    self.navigationItem.title = @"发新帖";
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonPressed:)];
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveButtonPressed:)];
    [self.navigationItem setLeftBarButtonItem:cancelButton];
    [self.navigationItem setRightBarButtonItem:saveButton];
    
    self.topicTitle.delegate = self;
    self.topicContent.delegate = self;
    self.contentTextView.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    self.contentTextView.layer.borderWidth = 1.0;
    self.contentTextView.layer.cornerRadius = 5.0;
}

- (void)cancelButtonPressed:(UIButton *)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)saveButtonPressed:(UIButton *)sender
{
    if (self.topicTitle.text.length > 0) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsPath = [paths firstObject];
        
        NSString *imagePath = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"image-%@", [self stringForCurrentDateTime]]];
        
        NSData *data = UIImagePNGRepresentation(self.imageView.image);
        [data writeToFile:imagePath atomically:YES];
        
        NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"Data.plist"];
        
        NSMutableArray *plistDataArray;
        NSFileManager *defaultManager = [NSFileManager defaultManager];
        if ([defaultManager fileExistsAtPath:plistPath]) {
            plistDataArray = [NSMutableArray arrayWithContentsOfFile:plistPath];
        } else {
            NSMutableArray *array = [NSMutableArray array];
            [array writeToFile:plistPath atomically:YES];
            plistDataArray = [NSMutableArray arrayWithContentsOfFile:plistPath];
        }
        
        NSMutableDictionary *topicItem = [[NSMutableDictionary alloc]init];
        [topicItem setValue:self.topicTitle.text forKey:@"topicTitle"];
        [topicItem setValue:self.contentTextView.text forKey:@"topicContent"];
        [topicItem setValue:imagePath forKey:@"image_filepath"];
        [topicItem setValue:[NSDate date] forKey:@"date"];
        
        [plistDataArray addObject:topicItem];
        
        if ([plistDataArray writeToFile:plistPath atomically:YES]) {
            NSLog(@"Data saved");
        } else {
            NSLog(@"Fail to save data");
        }
        
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [[[UIAlertView alloc]initWithTitle:@"内容填写不全" message:@"请填写标题" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil]show];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Date Helper Method

- (NSString *)stringForCurrentDateTime
{
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"yyyyMMddHHmmSS"];
    
    NSDate *now = [NSDate date];
    NSString *dateString = [format stringFromDate:now];
    return dateString;
}

#pragma mark -Text Field Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}

#pragma mark - User Interaction Methods

- (IBAction)takePic:(id)sender {
    [[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册中选择", nil] showInView:self.view];
    
}

#pragma mark - Action Sheet Delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0 && [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = NO;
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
    if (buttonIndex == 1) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = NO;
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if ([info objectForKey:UIImagePickerControllerOriginalImage]) {
        UIImage *pic = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        [self.imageView setImage:pic];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
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
