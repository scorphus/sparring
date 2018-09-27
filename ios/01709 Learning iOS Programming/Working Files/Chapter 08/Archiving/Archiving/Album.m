//
//  Album.m
//  iMusic
//
//  Created by Bob McCune.
//  Copyright (c) 2012 TapHarmonic, LLC. All rights reserved.
//

#import "Album.h"

@implementation Album

@synthesize albumID = _albumID;
@synthesize albumName = _albumName;
@synthesize imageURLString = _imageURLString;
@synthesize price = _price;
@synthesize iTunesURLString = _iTunesURLString;
@synthesize releaseDate = _releaseDate;
@synthesize genre = _genre;
@synthesize artist = _artist;

- (NSString *)description {
	return [NSString stringWithFormat:@"%lu - %@", self.albumID, self.albumName];
}

@end
