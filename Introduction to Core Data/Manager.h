//
//  Manager.h
//  Introduction to Core Data
//
//  Created by mac on 7/25/14.
//  Copyright (c) 2014 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Person;

@interface Manager : NSManagedObject

@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) NSSet *employees;
@end

@interface Manager (CoreDataGeneratedAccessors)

- (void)addEmployeesObject:(Person *)value;
- (void)removeEmployeesObject:(Person *)value;
- (void)addEmployees:(NSSet *)values;
- (void)removeEmployees:(NSSet *)values;

@end
