//
//  MainApp.m
//  Objective-C
//
//  Created by Bob McCune.
//  Copyright (c) 2012 TapHarmonic, LLC. All rights reserved.
//

#import "MainApp.h"
#import "NSString+Additions.h"

@implementation MainApp

- (void)run {

	logh(@"Contains String", ^{
		
		NSString *sgtPepper = @"Sgt. Pepper's Lonely Hearts Club Band";
		NSString *containsResult = [sgtPepper containsString:@"Club"] ? @"YES" : @"NO";
		NSLog(@"Contains string? %@", containsResult);

	});
	
	logh(@"Case Insensitive Equality", ^{
		
		NSString *rubberSoul = @"Rubber Soul";
		BOOL equalsResult = [rubberSoul isEqualToString:@"RUBBER soUl" ignoringCase:YES];
		NSLog(@"Are strings equal? %@", equalsResult ? @"YES" : @"NO");
		
	});

}

@end
