//
//  NSString+Additions.m
//  Music
//
//  Copyright 2012 Thomson Reuters Global Resources. All rights reserved.
//  Proprietary and confidential information of TRGR.  Disclosure, use, or 
//  reproduction without the written authorization of TRGR is prohibited.
//

#import "NSString+Additions.h"

@implementation NSString (Additions)

- (NSString *)urlEncodedString {
	NSString *encodedForm = (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
																								  (__bridge CFStringRef)self,
																								  NULL, CFSTR(":/?#[]@!$&’()*+,;="),
																								  kCFStringEncodingUTF8);
	return encodedForm;
}

@end
