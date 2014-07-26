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

@interface AddTopicViewController ()<UITextFieldDelegate, UITextViewDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textFieldTitle;
@property (weak, nonatomic) IBOutlet UITextView *textViewContent;
@property (strong, nonatomic) UIScrollView *imagesScrollView;
@property (strong, nonatomic) NSMutableArray *imagesArray;


@end

@implementation AddTopicViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"发表新帖";
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelButtonPressed:)];
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]initWithTitle:@"发布" style:UIBarButtonItemStyleBordered target:self action:@selector(saveButtonPressed:)];
    [self.navigationItem setLeftBarButtonItem:cancelButton];
    [self.navigationItem setRightBarButtonItem:saveButton];
    
    self.textViewContent.delegate = self;
    self.textFieldTitle.delegate = self;
    
    self.textViewContent.layer.borderWidth = 1.0;
    self.textViewContent.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    
    UIToolbar *keyboardToolbar = [[UIToolbar alloc]init];
    [keyboardToolbar setBarStyle:UIBarStyleDefault];
    [keyboardToolbar sizeToFit];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleBordered target:self action:@selector(endEditing:)];
    NSArray *itemArray = [NSArray arrayWithObjects:doneButton, nil];
    [keyboardToolbar setItems:itemArray];
    
    [self.textViewContent setInputAccessoryView:keyboardToolbar];
    [self.textFieldTitle setInputAccessoryView:keyboardToolbar];
    
    self.imagesArray = [[NSMutableArray alloc]init];
    self.imagesScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(10, 300, 300, 170)];
    self.imagesScrollView.delegate = self;
    self.imagesScrollView.contentSize = CGSizeMake(320, 170);
    self.imagesScrollView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.imagesScrollView];
    
    
    //CGSize windowSize = self.view.frame.size;
    //NSLog(@"width:%f, height:%f", windowSize.width, windowSize.height);

}

- (void)viewWillAppear:(BOOL)animated
{
    //[self.textFieldTitle becomeFirstResponder];
}

- (void)saveButtonPressed:(id)selector {
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *managedObjectContext = appDelegate.managedObjectContext;
    
    Topic *topic = [NSEntityDescription insertNewObjectForEntityForName:@"Topic" inManagedObjectContext:appDelegate.managedObjectContext];
    
    if (topic != nil) {
        topic.title = self.textFieldTitle.text;
        topic.content = self.textViewContent.text;
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsPath = [paths firstObject];
        
        NSString *imagePath = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"image-%@", [self stringForCurrentDateTime]]];
        for (int i = 0; i < self.imagesArray.count; i++) {
            UIImage *image = [self.imagesArray objectAtIndex:i];
            NSData *data = UIImagePNGRepresentation(image);
            [data writeToFile:imagePath atomically:YES];
        }
        topic.images
        
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

- (NSString *)stringForCurrentDateTime
{
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"yyyyMMddHHmmSS"];
    NSDate *now = [NSDate date];
    NSString *dateString = [format stringFromDate:now];
    
    return dateString;
}

- (void)cancelButtonPressed:(id)selector {
    
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




- (IBAction)endEditing:(id)sender {
    [self.view endEditing:YES];
}

#pragma mark - handle pictures

- (IBAction)takePicture:(id)sender {
    
    [[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册选取", nil]showInView:self.view];
}

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
        UIImageView *imageView = [self addImageView];
        [imageView setImage:pic];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIImageView *)addImageView
{
    
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.imagesArray.count * 160 , 10 , 150, 150)];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.layer.masksToBounds = YES;
    [self.imagesScrollView addSubview:imageView];
    
    [self.imagesArray addObject:imageView];
    
    [self.imagesScrollView setContentSize:CGSizeMake((50 + self.imagesArray.count * 150), 170)];
    //NSLog(@"scrollView width:%f height:%f", self.imagesScrollView.contentSize.width, self.imagesScrollView.contentSize.height);
    //NSLog(@"items in array:%d",self.imagesArray.count);
    return imageView;
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
