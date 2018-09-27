//
//  AlbumIntTests.m
//  iMusic
//
//  Created by Bob McCune.
//  Copyright (c) 2012 TapHarmonic, LLC. All rights reserved.
//

#import "AlbumIntTests.h"
#import "Album.h"

@implementation AlbumIntTests

- (void)setUp {
	NSString *path = [[NSBundle mainBundle] pathForResource:@"iMusic" ofType:@"data"];
	NSURL *sourceURL = [NSURL fileURLWithPath:path];
	NSArray *urls = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
	NSURL *destinationURL = [[urls lastObject] URLByAppendingPathComponent:@"iMusic.data"];
	[[NSFileManager defaultManager] removeItemAtURL:destinationURL error:nil];
	[[NSFileManager defaultManager] copyItemAtURL:sourceURL toURL:destinationURL error:nil];
}

- (void)testFindAll {
	NSArray *albums = [Album findAllAlbums];
	NSUInteger expectedCount = 12;
	STAssertEquals([albums count], expectedCount, nil);
}

- (void)testSaveAlbum {
	NSUInteger origAlbumCount = [[Album findAllAlbums] count];
	
	Artist *theBeatles = [Artist artistWithID:1000 name:@"The Beatles"];
	
	Album *abbeyRoad = [[Album alloc] init];
	abbeyRoad.albumID = 2000;
	abbeyRoad.albumName = @"Abbey Road";
	abbeyRoad.artist = theBeatles;
	
	[abbeyRoad saveAlbum];
	
	NSArray *albums = [Album findAllAlbums];
	NSArray *albumNames = [albums valueForKeyPath:@"albumName"];
	STAssertTrue([albumNames containsObject:@"Abbey Road"], nil);
	STAssertEquals([albums count], origAlbumCount + 1, nil);
}

- (void)testDeleteAlbum {
	NSArray *albums = [Album findAllAlbums];
	NSUInteger origAlbumCount = [albums count];
	
	Album *album = [albums objectAtIndex:0];
	NSNumber *deletedAlbumID = [NSNumber numberWithUnsignedInteger:album.albumID];
	
	[album deleteAlbum];
	
	albums = [Album findAllAlbums];
	STAssertEquals([albums count], origAlbumCount - 1, nil);
	NSArray *albumIDs = [albums valueForKeyPath:@"albumID"];
	STAssertFalse([albumIDs containsObject:deletedAlbumID], nil);
}



@end
