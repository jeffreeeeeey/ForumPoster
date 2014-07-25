//
//  Topic.h
//  ForumPoster4
//
//  Created by mac on 7/25/14.
//  Copyright (c) 2014 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Topic : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSDate * postDate;
@property (nonatomic, retain) NSNumber * posterID;
@property (nonatomic, retain) NSSet *images;
@end

@interface Topic (CoreDataGeneratedAccessors)

- (void)addImagesObject:(NSManagedObject *)value;
- (void)removeImagesObject:(NSManagedObject *)value;
- (void)addImages:(NSSet *)values;
- (void)removeImages:(NSSet *)values;

@end
