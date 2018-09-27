//
//  Album.m
//  Objective-C
//
//  Created by Bob McCune.
//  Copyright (c) 2012 TapHarmonic, LLC. All rights reserved.
//

#import "Album.h"

@implementation Album {
    NSString *_name;
}

- (void)markAsFavorite {
    NSLog(@"Marked %@ as favorite", _name);
}

- (NSString *)name {
    return _name;
}

- (void)setName:(NSString *)name {
	if (_name != name) {
        [_name release];
        _name = [name copy];
    }
}

- (NSString *)description {
    return _name;
}

- (void)dealloc {
	[_name release];
	[super dealloc];
}

@end
