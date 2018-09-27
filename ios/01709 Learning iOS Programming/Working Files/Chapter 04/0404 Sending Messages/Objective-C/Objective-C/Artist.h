//
//  Artist.h
//  Objective-C
//
//  Created by Bob McCune
//  Copyright (c) 2012 TapHarmonic, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Album;

@interface Artist : NSObject

- (NSString *)name;
- (void)setName:(NSString *)name;

- (void)orderAlbum:(Album *)album quantity:(NSUInteger)quantity;

@end
