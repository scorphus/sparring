//
//  NSDictionary+DateAdditions.m
//  Music
//
//  Copyright 2012 Thomson Reuters Global Resources. All rights reserved.
//  Proprietary and confidential information of TRGR.  Disclosure, use, or 
//  reproduction without the written authorization of TRGR is prohibited.
//

#import "NSDictionary+DateAdditions.h"

#define DATE_FORMAT @"yyyy-MM-dd'T'HH:mm:ss'Z'"

@implementation NSDictionary (DateAdditions)

- (NSDate *)dateForKey:(id)key {
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
	[formatter setDateFormat:DATE_FORMAT];
	return [formatter dateFromString:[self objectForKey:key]];
}

@end
