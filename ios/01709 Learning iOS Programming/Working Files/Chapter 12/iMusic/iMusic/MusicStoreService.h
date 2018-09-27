//
//  MusicStoreService.h
//  iMusic
//
//  Created by Bob McCune.
//  Copyright (c) 2012 TapHarmonic, LLC. All rights reserved.
//

@class Artist;
@class Album;

typedef void(^ServiceCompletionBlock)(id result, NSError *error);

@interface MusicStoreService : NSObject

- (void)findArtistsByArtistName:(NSString *)artistName completionBlock:(ServiceCompletionBlock)completionBlock;

- (void)loadAlbumsForArtist:(Artist *)artist completionBlock:(ServiceCompletionBlock)completionBlock;

- (void)fetchArtworkForAlbum:(Album *)album completionBlock:(ServiceCompletionBlock)completionBlock;

@end
