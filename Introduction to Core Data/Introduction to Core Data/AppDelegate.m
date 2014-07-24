//
//  AppDelegate.m
//  Introduction to Core Data
//
//  Created by mac on 7/23/14.
//  Copyright (c) 2014 mac. All rights reserved.
//

#import "AppDelegate.h"
#import "Person.h"
#import "PersonsListTableViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
            
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

/*
- (BOOL)createNewPersonWithFirstName:(NSString *)paramFirstName lastName:(NSString *)paramLastName age:(NSNumber *)paramAge
{
    BOOL result = NO;
    
    if ([paramFirstName length] == 0 || [paramLastName length] == 0) {
        NSLog(@"First and last names are mandatory");
        return NO;
    }
    
    Person *newPerson = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:self.managedObjectContext];
    if (newPerson == nil) {
        NSLog(@"Fail to create the new person");
        return NO;
    }
    
    newPerson.firstName = paramFirstName;
    newPerson.lastName = paramLastName;
    newPerson.age = paramAge;
    
    NSError *savingError = nil;
    
    if ([self.managedObjectContext save:&savingError]) {
        return YES;
    }else {
        NSLog(@"Failed to save the new person, Error = %@", savingError);
    }
    
    return result;
}
 */

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    /*
    [self createNewPersonWithFirstName:@"Tony" lastName:@"Blar" age:[NSNumber numberWithInt:78]];
    [self createNewPersonWithFirstName:@"Machol" lastName:@"Zhang" age:[NSNumber numberWithInt:5]];
    
    
    //Tell the request that we want to read the contents of the Person entity
    //Create the fetch request first
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]initWithEntityName:@"Person"];
    
    NSSortDescriptor *ageSort = [[NSSortDescriptor alloc]initWithKey:@"age" ascending:YES];
    NSSortDescriptor *firstNameSort = [[NSSortDescriptor alloc]initWithKey:@"firstName" ascending:YES];
    fetchRequest.sortDescriptors = @[firstNameSort, ageSort];
    
    NSError *requestError = nil;
    
    // And execute the fetch request on the context
    
    NSArray *persons = [self.managedObjectContext executeFetchRequest:fetchRequest error:&requestError];
    
    if ([persons count] > 0) {
        NSUInteger counter = 1;
        for (Person *thisPerson in persons) {
            NSLog(@"Person %lu FirstName: = %@", (unsigned long)counter, thisPerson.firstName);
            NSLog(@"Person %lu LastName: = %@", (unsigned long)counter, thisPerson.lastName);
            NSLog(@"Person %lu Age = %ld \n ================", (unsigned long)counter, (unsigned long)[thisPerson.age unsignedIntegerValue]);
            
            counter++;
        }
    }else {
        NSLog(@"Could not find any Person entities in the context");
    }
    /*
    if ([persons count] > 0) {
        Person *lastPerson = [persons lastObject];
        [self.managedObjectContext deleteObject:lastPerson];
        
        if ([lastPerson isDeleted]) {
            NSLog(@"Successfully deleted the last person in the array");
        }
        
        NSError *savingError = nil;
        if ([self.managedObjectContext save:&savingError]) {
            NSLog(@"Successfully saved the context");
        } else {
            NSLog(@"Failed to delete the last person in the array");
        }
    } else {
        NSLog(@"Could not find any Person entities in the context");
    }
    
    NSLog(@"There are %lu person now.", (unsigned long)[persons count]);
    
    
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    PersonsListTableViewController *vc = [[PersonsListTableViewController alloc]init];
    self.window.rootViewController = vc;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    */
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext {
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext {
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Introduction_to_Core_Data" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Introduction_to_Core_Data.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
