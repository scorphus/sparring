//
//  Artist.m
//  iMusic
//
//  Created by Bob McCune.
//  Copyright (c) 2012 TapHarmonic, LLC. All rights reserved.
//

#import "Artist.h"

@implementation Artist

@synthesize artistID = _artistID;
@synthesize artistName = _artistName;

+ (id)artistWithID:(NSUInteger)artistID name:(NSString *)artistName {
	return [[[self class] alloc] initWithID:artistID name:artistName];
}

- (id)initWithID:(NSUInteger)artistID name:(NSString *)artistName {
	self = [super init];
	if (self) {
		self.artistID = artistID;
		self.artistName = artistName;
	}
	return self;
}

- (NSString *)description {
	return [NSString stringWithFormat:@"%lu - %@", self.artistID, self.artistName];
}

@end
