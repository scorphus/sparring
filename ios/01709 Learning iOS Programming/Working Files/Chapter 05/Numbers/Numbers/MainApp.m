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
	
	BOOL validated = NO;
	CGFloat width = 12.3;
	NSInteger index = 2;
	
	NSNumber *boxedBool = [NSNumber numberWithBool:validated];
	NSNumber *boxedFloat = [NSNumber numberWithFloat:width];
	NSNumber *boxedInteger = [NSNumber numberWithInteger:index];
	
	NSLog(@"%@", boxedBool);
	NSLog(@"%@", boxedFloat);
	NSLog(@"%@", boxedInteger);
	
	BOOL unboxedBool = [boxedBool boolValue];
	CGFloat unboxedFloat = [boxedFloat floatValue];
	NSInteger unboxedInteger = [boxedInteger integerValue];
	
	NSLog(@"%@", unboxedBool ? @"YES" : @"NO");
	NSLog(@"%f", unboxedFloat);
	NSLog(@"%li", unboxedInteger);
	
	NSNumber *num = [NSNumber numberWithInteger:-12345];
	NSLog(@"%@", num);
	
	NSUInteger unsignedInt = [num unsignedIntegerValue];
	NSLog(@"%lu", unsignedInt);
	
}

@end
