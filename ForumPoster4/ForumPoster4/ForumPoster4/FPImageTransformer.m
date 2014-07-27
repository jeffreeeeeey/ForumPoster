//
//  FPImageTransformer.m
//  ForumPoster4
//
//  Created by mac on 7/27/14.
//  Copyright (c) 2014 mac. All rights reserved.
//
#import "UIKit/UIKit.h"
#import "FPImageTransformer.h"

@implementation FPImageTransformer

+ (Class)transformedValueClass
{
    return [NSData class];
}

- (id)transformedValue:(id)value
{
    if (!value) {
        return nil;
    }
    if ([value isKindOfClass:[NSData class]]) {
        return value;
    }
    return UIImagePNGRepresentation(value);
}

- (id)reverseTransformedValue:(id)value
{
    return [UIImage imageWithData:value];
}

@end
