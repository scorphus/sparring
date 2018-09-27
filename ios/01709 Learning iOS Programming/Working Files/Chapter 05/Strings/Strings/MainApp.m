//
//  MainApp.m
//  Objective-C
//
//  Created by Bob McCune.
//  Copyright (c) 2012 TapHarmonic, LLC. All rights reserved.
//

#import "MainApp.h"

@implementation MainApp

- (void)run {

	// Object Literals
	logh(@"Object Literals", ^{
		
		NSString *firstname = [[NSString alloc] initWithString:@"Paul"];
		NSString *lastname = @"McCartney";
		
		logs(firstname);
		logs(lastname);
	});
	
	// Format Strings
    logh(@"Format Strings", ^{

		NSString *firstname = @"John";
		NSString *lastname = @"Lennon";

        NSString *fullname = [NSString stringWithFormat:@"%@ %@", firstname, lastname];
		
		logs(fullname);
    });
	
	// Concatenating Strings
	logh(@"Concatenating Strings", ^{

		NSString *aaa = @"AAA";
		NSString *bbb = @"BBB";
		NSString *ccc = @"CCC";
		
		// Append String
		logs(aaa);
		logs([aaa stringByAppendingString:bbb]);
		logs([[aaa stringByAppendingString:bbb] stringByAppendingString:ccc]);
		
	});
	
	// Sub Strings
	logh(@"Substrings", ^{

		NSString *usa = @"United States of America";
		
		logs([usa substringToIndex:6]);
		
		NSRange range = [usa rangeOfString:@"States"];
		logs([usa substringWithRange:range]);
		
		logs([usa substringFromIndex:17]);
		
	});
	
	// Changing Case
	logh(@"Changing Case", ^{
		
		NSString *message = @"iOS Development Rocks!";
		
		logs([message lowercaseString]);
		logs([message uppercaseString]);
	});
	
	// Test Equality
	logh(@"Testing Equality", ^{
		
		NSString *theBeatles = @"The Beatles";
		NSString *ledZeppelin = @"Led Zeppelin";

		NSString *result = [theBeatles isEqualToString:ledZeppelin] ? @"Yes" : @"No";
		
		logs([NSString stringWithFormat: @"Are '%@' and '%@' equal? %@.", theBeatles, ledZeppelin, result]);

		
	});

}

@end
