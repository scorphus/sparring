//
//  Artist.h
//  iMusic
//
//  Created by Bob McCune.
//  Copyright (c) 2012 TapHarmonic, LLC. All rights reserved.
//

@interface Artist : NSObject <NSCoding>

@property (nonatomic, assign) NSUInteger artistID;
@property (nonatomic, copy) NSString *artistName;

+ (id)artistWithID:(NSUInteger)artistID name:(NSString *)artistName;
- (id)initWithID:(NSUInteger)artistID name:(NSString *)artistName;

@end
