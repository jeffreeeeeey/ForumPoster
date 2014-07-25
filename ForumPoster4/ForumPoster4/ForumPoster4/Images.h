//
//  Images.h
//  ForumPoster4
//
//  Created by mac on 7/25/14.
//  Copyright (c) 2014 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Topic;

@interface Images : NSManagedObject

@property (nonatomic, retain) NSString * path;
@property (nonatomic, retain) Topic *topic;

@end
