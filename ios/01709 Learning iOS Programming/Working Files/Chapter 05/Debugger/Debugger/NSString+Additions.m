//
//  NSString+Additions.m
//  Debugger
//
//  Created by Bob McCune.
//  Copyright (c) 2012 TapHarmonic, LLC. All rights reserved.
//

#import "NSString+Additions.h"

@implementation NSString (Additions)

- (NSString *)trimmedString {
	NSCharacterSet *whiteSpace = [NSCharacterSet whitespaceCharacterSet];
	return [self stringByTrimmingCharactersInSet:whiteSpace];
}

- (BOOL)containsString:(NSString *)string {
	NSRange range = [self rangeOfString:string];
	BOOL contains = (range.location == NSNotFound);
	return contains;
}

- (BOOL)isEqualToString:(NSString *)string ignoringCase:(BOOL)ignoreCase {
	if (!ignoreCase) {
		return [self localizedCaseInsensitiveCompare:string] == NSOrderedSame;
	} else {
		return [self isEqualToString:string];
	}
}

@end
