//
//  Person.h
//  Introduction to Core Data
//
//  Created by mac on 7/25/14.
//  Copyright (c) 2014 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Manager;

@interface Person : NSManagedObject

@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) Manager *manager;

@end
