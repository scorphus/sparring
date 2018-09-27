//
//  ArtistTests.m
//  iMusic
//
//  Created by Bob McCune.
//  Copyright (c) 2012 TapHarmonic, LLC. All rights reserved.
//

#import "ArtistTests.h"
#import "Artist.h"
#import <OCMock/OCMock.h>

@implementation ArtistTests {
	NSUInteger artistID;
	NSString *artistName;
}

- (void)setUp {
	artistID = 100;
	artistName = @"Metallica";
}

- (void)testInitWithIDName {
	
	Artist *artist = [[Artist alloc] initWithID:artistID name:artistName];
	
	STAssertEquals(artist.artistID, artistID, nil);
	STAssertEqualObjects(artist.artistName, artistName, nil);
}

- (void)testArtistConvenienceInitializer {
	Artist *artist = [Artist artistWithID:artistID name:artistName];
	STAssertEquals(artist.artistID, artistID, nil);
	STAssertEqualObjects(artist.artistName, artistName, nil);
}

- (void)testAdoptsNSCoding {
	Artist *artist = [[Artist alloc] initWithID:artistID name:artistName];
	STAssertTrue([artist conformsToProtocol:@protocol(NSCoding)], @"Artist does not adopt NSCoding");
}

- (void)testInitWithCoder {
	id stubCoder = [OCMockObject mockForClass:[NSCoder class]];
	NSInteger localArtistID = (NSInteger)artistID;
	[[[stubCoder stub] andReturnValue:OCMOCK_VALUE(localArtistID)] decodeIntegerForKey:@"artistID"];
	[[[stubCoder stub] andReturn:artistName] decodeObjectForKey:@"artistName"];
	
	Artist *artist = [[Artist alloc] initWithCoder:stubCoder];
	
	STAssertEquals(artist.artistID, artistID, nil);
	STAssertEqualObjects(artist.artistName, artistName, nil);
}

- (void)testEncodeWithCoder {
	id mockCoder = [OCMockObject mockForClass:[NSCoder class]];
	[[mockCoder expect] encodeInteger:artistID forKey:@"artistID"];
	[[mockCoder expect] encodeObject:artistName forKey:@"artistName"];
	
	Artist *artist = [Artist artistWithID:artistID name:artistName];
	[artist encodeWithCoder:mockCoder];
	
	[mockCoder verify];
}

@end
