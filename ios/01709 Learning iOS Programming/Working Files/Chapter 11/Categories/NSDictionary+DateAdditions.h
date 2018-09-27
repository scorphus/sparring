//
//  NSDictionary+DateAdditions.h
//  Music
//
//  Created by Bob McCune on 5/25/12.
//  Copyright (c) 2012 TapHarmonic, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (DateAdditions)

- (NSDate *)dateForKey:(NSString *)key;

@end
