//
//  Images.h
//  ForumPoster4
//
//  Created by mac on 7/27/14.
//  Copyright (c) 2014 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Topic;

@interface Images : NSManagedObject

@property (nonatomic, retain) id image;
@property (nonatomic, retain) NSString * path;
@property (nonatomic, retain) NSString * label;
@property (nonatomic, retain) NSString * summary;
@property (nonatomic, retain) Topic *topic;

@end
