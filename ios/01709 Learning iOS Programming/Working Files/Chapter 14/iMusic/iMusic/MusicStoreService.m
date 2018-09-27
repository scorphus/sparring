//
//  MusicStoreService.m
//  iMusic
//
//  Created by Bob McCune.
//  Copyright (c) 2012 TapHarmonic, LLC. All rights reserved.
//

#import "MusicStoreService.h"
#import "Artist.h"
#import "Album.h"
#import "NSString+Additions.h"
#import "HTTPGetRequest.h"
#import "NSDictionary+DateAdditions.h"
#import "AFImageRequestOperation.h"

#define ARTIST_ENDPOINT_FORMAT	@"http://itunes.apple.com/search?term=%@&media=music&entity=musicArtist&attribute=artistTerm&limit=20"
#define ALBUM_URL_FORMAT @"http://itunes.apple.com/lookup?id=%lu&entity=album"

@implementation MusicStoreService

- (void)findArtistsByArtistName:(NSString *)artistName completionBlock:(void(^)(id result, NSError *error))completionBlock {
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:ARTIST_ENDPOINT_FORMAT, [artistName urlEncodedString]]];
	
	SuccessBlock successBlock = ^(NSData *response) {
		NSError *error;
		NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:response options:0 error:&error];
		// Data parsed correctly
		if (jsonDict) {
			NSMutableArray *artists = [NSMutableArray array];
			for (id artistDict in [jsonDict objectForKey:@"results"]) {
				NSInteger artistID = [[artistDict objectForKey:@"artistId"] integerValue];
				NSString *artistName = [artistDict objectForKey:@"artistName"];
				[artists addObject:[Artist artistWithID:artistID name:artistName]];
			}
			completionBlock(artists, nil);
		} else {
			completionBlock(nil, error);
		}		
	};
	
	FailureBlock failureBlock = ^(NSError *error) {
		completionBlock(nil, error);
	};
	
	HTTPGetRequest *request = [[HTTPGetRequest alloc] initWithURL:url successBlock:successBlock failureBlock:failureBlock];
	[request startRequest];
}

- (void)loadAlbumsForArtist:(Artist *)artist completionBlock:(ServiceCompletionBlock)completionBlock {

	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:ALBUM_URL_FORMAT, artist.artistID]];
	
	SuccessBlock successBlock = ^(NSData *responseData) {
		NSError *error;
		id jsonDict = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&error];
		if (jsonDict) {
			NSMutableArray *albums = [NSMutableArray array];
			for (NSDictionary *albumDict in [jsonDict objectForKey:@"results"]) {
				if ([[albumDict objectForKey:@"wrapperType"] isEqualToString:@"collection"]) {
					Album *album = [[Album alloc] init];
					album.albumID = [[albumDict objectForKey:@"collectionId"] integerValue];
					album.albumName = [albumDict objectForKey:@"collectionName"];
					album.imageURLString = [albumDict objectForKey:@"artworkUrl100"];
					album.price = [albumDict objectForKey:@"collectionPrice"];
					album.iTunesURLString = [albumDict objectForKey:@"collectionViewUrl"];
					album.genre = [albumDict objectForKey:@"primaryGenreName"];
					album.releaseDate = [albumDict dateForKey:@"releaseDate"];
					album.artist = artist;
					[albums addObject:album];
				}
			}
			completionBlock(albums, nil);
		} else {
			completionBlock(nil, error);
		}
	};
	
	FailureBlock failureBlock = ^(NSError *error) {
		completionBlock(nil, error);
	};
	
	HTTPGetRequest *request = [[HTTPGetRequest alloc] initWithURL:url successBlock:successBlock failureBlock:failureBlock];
	[request startRequest];	
}

- (void)fetchArtworkForAlbum:(Album *)album completionBlock:(ServiceCompletionBlock)completionBlock {
	NSURL *url = [NSURL URLWithString:album.imageURLString];
	NSURLRequest *request = [NSURLRequest requestWithURL:url];
	AFImageRequestOperation *operation = [AFImageRequestOperation imageRequestOperationWithRequest:request success:^(UIImage *image) {
		completionBlock(image, nil);
	}];
	[operation start];
}
@end
