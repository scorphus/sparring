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

	NSArray *beatles = [NSArray arrayWithObjects:@"John", @"Paul", @"George", @"Ringo", nil];
	NSLog(@"%@", beatles);
	
	NSString *john = [beatles objectAtIndex:0];
	NSString *paul = [beatles objectAtIndex:1];
	
	NSLog(@"%@", john);
    NSLog(@"%@", paul);
	
	for (int i = 0; i < [beatles count]; i++) {
		NSLog(@"Name: %@", [beatles objectAtIndex:i]);
	}
	
	for (NSString *name in beatles) {
		NSLog(@"Name: %@", name);
	}
	
	NSString *result = [beatles containsObject:@"Ringo"] ? @"YES" : @"NO";
	NSLog(@"Contains string 'Ringo'? %@", result);
	
	NSUInteger index = [beatles indexOfObject:@"George"];
	NSLog(@"George's index is: %lu", index);
	
	
	NSMutableArray *mutableBeatles = [NSMutableArray arrayWithArray:beatles];
	[mutableBeatles addObject:@"Brian Epstein"];
	[mutableBeatles addObject:@"George Martin"];
	[mutableBeatles addObject:@"Stuart Sutcliffe"];
	
	[mutableBeatles removeLastObject];
	
	NSUInteger brianIndex = [mutableBeatles indexOfObject:@"Brian Epstein"];
    [mutableBeatles replaceObjectAtIndex:brianIndex withObject:@"Apple Corps"];
	
	for (id name in mutableBeatles) {
		NSLog(@"Name: %@", name);
	}
}

@end
