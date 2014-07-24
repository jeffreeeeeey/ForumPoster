//
//  AddPersonViewController.m
//  Introduction to Core Data
//
//  Created by mac on 7/24/14.
//  Copyright (c) 2014 mac. All rights reserved.
//

#import "AddPersonViewController.h"
#import "AppDelegate.h"
#import "Person.h"

@interface AddPersonViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textFieldFirstName;
@property (weak, nonatomic) IBOutlet UITextField *textFieldLastName;
@property (weak, nonatomic) IBOutlet UITextField *textFieldAge;

@end

@implementation AddPersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createNewPerson {
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *managedObjectContext = appDelegate.managedObjectContext;
    
    Person *newPerson = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:managedObjectContext];
    
    if (newPerson != nil) {
        newPerson.firstName = self.textFieldFirstName.text;
        newPerson.lastName = self.textFieldLastName.text;
        newPerson.age = @([self.textFieldAge.text integerValue]);
        
        NSError *savingError = nil;
        if ([managedObjectContext save:&savingError]) {
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            NSLog(@"Failed to save the managed object context");
        }
    } else {
        NSLog(@"Failed to create the new person object");
    }
}
- (IBAction)cancelButtonPressed:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveButtonPressed:(id)sender {
    [self createNewPerson];
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
