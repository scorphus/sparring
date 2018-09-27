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

	NSArray *keys = [NSArray arrayWithObjects:@"rhythm", @"bass", @"lead", @"drums", nil];
	NSArray *names = [NSArray arrayWithObjects:@"John", @"Paul", @"George", @"Ringo", nil];
	NSDictionary *beatles = [NSDictionary dictionaryWithObjects:names forKeys:keys];
	
	NSString *drummer = [beatles objectForKey:@"drums"];
	NSString *leadGuitarist = [beatles objectForKey:@"lead"];
	
	NSLog(@"Drums: %@", drummer);
    NSLog(@"Lead Guitarist: %@", leadGuitarist);

	for (id key in beatles) {
        NSLog(@"Key: %@, Value: %@", key, [beatles objectForKey:key]);
    }
	
	printf("\n");
	
	NSMutableDictionary *mutableBeatles = [NSMutableDictionary dictionaryWithDictionary:beatles];
	[mutableBeatles setObject:@"Brian Epstein" forKey:@"manager"];
    [mutableBeatles setObject:@"George Martin" forKey:@"producer"];
	
	[mutableBeatles removeObjectForKey:@"manager"];
	
	[mutableBeatles setObject:[NSNull null] forKey:@"engineer"];
	
	for (id key in mutableBeatles) {
        NSLog(@"Key: %@, Value: %@", key, [mutableBeatles objectForKey:key]);
    }
	
	NSString *engineer = [mutableBeatles objectForKey:@"engineer"];
	if (engineer == nil || [engineer isKindOfClass:[NSNull class]]) {
		NSLog(@"Engineer was nil");
	} else {
		NSLog(@"Engineer was not nil");
	}

}

@end
