//
//  main.m
//  Objective-C
//
//  Created by Bob McCune.
//  Copyright (c) 2012 TapHarmonic, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainApp.h"

int main(int argc, const char * argv[]) {

	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	MainApp *app = [[MainApp alloc] init];
	[app run];
	[app release];
	
	[pool drain];

	// Delay exiting main function by 1 minute
    sleep(60);
	
	return 0;
}

