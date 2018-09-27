//
//  Album.h
//  iMusic
//
//  Created by Bob McCune.
//  Copyright (c) 2012 TapHarmonic, LLC. All rights reserved.
//

#import "Artist.h"

@interface Album : NSObject

@property (nonatomic, assign) NSUInteger albumID;
@property (nonatomic, copy) NSString *albumName;
@property (nonatomic, copy) NSString *imageURLString;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *iTunesURLString;
@property (nonatomic, strong) NSDate *releaseDate;
@property (nonatomic, copy) NSString *genre;
@property (nonatomic, strong) Artist *artist;

@end
