//
//  Album.h
//  Objective-C
//
//  Created by Bob McCune.
//  Copyright (c) 2012 TapHarmonic, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Album : NSObject

- (void)markAsFavorite;

- (NSString *)name;
- (void)setName:(NSString *)name;

@end
