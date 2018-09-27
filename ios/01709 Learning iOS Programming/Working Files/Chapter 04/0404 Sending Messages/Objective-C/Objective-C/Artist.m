//
//  Artist.m
//  Objective-C
//
//  Created by Bob McCune.
//  Copyright (c) 2012 TapHarmonic, LLC. All rights reserved.
//

#import "Artist.h"

@implementation Artist {
	NSString *_name;
}

- (NSString *)name {
    return nil;
}

- (void)setName:(NSString *)name {

}

- (void)orderAlbum:(Album *)album quantity:(NSUInteger)quantity {
    NSString *str = quantity == 1 ? @"copy" : @"copies";
	NSLog(@"Ordered %lu %@ of '%@'", quantity, str, album);
}

- (void)dealloc {
	[_name release];
	[super dealloc];
}

@end
