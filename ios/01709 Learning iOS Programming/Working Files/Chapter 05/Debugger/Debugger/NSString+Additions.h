//
//  NSString+Additions.h
//  Debugger
//
//  Created by Bob McCune.
//  Copyright (c) 2012 TapHarmonic, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Additions)

- (NSString *)trimmedString;
- (BOOL)containsString:(NSString *)string;
- (BOOL)isEqualToString:(NSString *)string ignoringCase:(BOOL)ignoreCase;

@end
