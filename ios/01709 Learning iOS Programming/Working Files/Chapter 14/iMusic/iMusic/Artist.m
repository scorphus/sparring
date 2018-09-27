//
//  Artist.m
//  iMusic
//
//  Created by Bob McCune.
//  Copyright (c) 2012 TapHarmonic, LLC. All rights reserved.
//

#import "Artist.h"

#define ARTIST_ID_KEY	@"artistID"
#define ARTIST_NAME_KEY @"artistName"

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

- (id)initWithCoder:(NSCoder *)decoder {
	self = [super init];
	if (self) {
		self.artistID = [decoder decodeIntegerForKey:ARTIST_ID_KEY];
		self.artistName = [decoder decodeObjectForKey:ARTIST_NAME_KEY];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
	[coder encodeInteger:self.artistID forKey:ARTIST_ID_KEY];
	[coder encodeObject:self.artistName forKey:ARTIST_NAME_KEY];
}

- (NSString *)description {
	return [NSString stringWithFormat:@"%lu - %@", self.artistID, self.artistName];
}

@end
