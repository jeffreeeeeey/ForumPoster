//
//  TopicListTableViewController.m
//  ForumPoster4
//
//  Created by mac on 7/25/14.
//  Copyright (c) 2014 mac. All rights reserved.
//

#import "TopicListTableViewController.h"
#import "AppDelegate.h"
#import "AddTopicViewController.h"
#import "TopicDetailViewController.h"
#import "TopicDetail2ViewController.h"
#import "Topic.h"
#import "Images.h"

@interface TopicListTableViewController ()<NSFetchedResultsControllerDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *addTopicBarButton;
@property (nonatomic, strong)NSFetchedResultsController *frc;

@end

@implementation TopicListTableViewController

- (NSManagedObjectContext *)managedObjectContext
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    return appDelegate.managedObjectContext;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"topicListCell"];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]initWithEntityName:@"Topic"];
    
    
    NSSortDescriptor *dateSort = [[NSSortDescriptor alloc]initWithKey:@"title" ascending:YES];
    
    fetchRequest.sortDescriptors = @[dateSort];
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

- (IBAction)addTopic:(id)sender {
    AddTopicViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"addTopic"];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    [self.navigationController presentViewController:nav animated:YES completion:nil];
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
        [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
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
    //NSLog(@"rows:%d",sectionInfo.numberOfObjects);
    return sectionInfo.numberOfObjects;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"topicListCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    Topic *topic = [self.frc objectAtIndexPath:indexPath];
    cell.textLabel.text = topic.title;
    
    
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"showTopicDetail"]) {
        //NSLog(@"showTopicDetail");
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        Topic *topic = [self.frc objectAtIndexPath:indexPath];
        
        [[segue destinationViewController] setTopic:topic];
        
    }
    
}



/*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TopicDetailViewController *vc = [[TopicDetailViewController alloc]init];
    vc.view.backgroundColor = [UIColor whiteColor];
    //Topic *topic = [self.frc objectAtIndexPath:indexPath];
    //vc.topic = topic;
    
    [self.navigationController pushViewController:vc animated:YES];
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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





@end
