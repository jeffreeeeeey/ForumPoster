//
//  PersonsListTableViewController.m
//  Introduction to Core Data
//
//  Created by mac on 7/24/14.
//  Copyright (c) 2014 mac. All rights reserved.
//

#import "PersonsListTableViewController.h"
#import "AppDelegate.h"
#import "AddPersonViewController.h"
#import "Person.h"

static NSString *PersonTableViewCell = @"PersonTableViewCell";

@interface PersonsListTableViewController ()<NSFetchedResultsControllerDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *addPerson;
@property (nonatomic, strong)UIBarButtonItem *barButtonAddPerson;
@property (nonatomic, strong)NSFetchedResultsController *frc;

@end

@implementation PersonsListTableViewController

- (NSManagedObjectContext *)managedObjectContext {
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    return appDelegate.managedObjectContext;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Create the fetch request first
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:PersonTableViewCell];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]initWithEntityName:@"Person"];
    
    NSSortDescriptor *ageSort = [[NSSortDescriptor alloc]initWithKey:@"age" ascending:YES];
    NSSortDescriptor *firstNameSort = [[NSSortDescriptor alloc]initWithKey:@"firstName" ascending:YES];
    
    fetchRequest.sortDescriptors = @[ageSort, firstNameSort];
    self.frc = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest managedObjectContext:[self managedObjectContext] sectionNameKeyPath:nil cacheName:nil];
    
    self.frc.delegate = self;
    NSError *fetchingError = nil;
    if ([self.frc performFetch:&fetchingError]) {
        NSLog(@"Successfully fetched");
    } else {
        NSLog(@"Failed to fetch");
    }
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - Handle fetchedResults

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    if (type == NSFetchedResultsChangeDelete) {
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }else if (type == NSFetchedResultsChangeInsert) {
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    id <NSFetchedResultsSectionInfo> sectionInfo = self.frc.sections[section];
    
    return sectionInfo.numberOfObjects;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:PersonTableViewCell forIndexPath:indexPath];
    
    Person *person = [self.frc objectAtIndexPath:indexPath];
    cell.textLabel.text = [person.firstName stringByAppendingFormat:@" %@", person.lastName];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Age:%lu", (unsigned long)[person.age unsignedIntegerValue]];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Person *personToDelete = [self.frc objectAtIndexPath:indexPath];
    
    [[self managedObjectContext]deleteObject:personToDelete];
    
    if ([personToDelete isDeleted]) {
        NSError *savingError = nil;
        if ([[self managedObjectContext] save:&savingError]) {
            NSLog(@"Successfully deleted the object");
        }else {
            NSLog(@"Failed to save the context with error = %@", savingError);
        }
    }
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
