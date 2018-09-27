//
//  AboutViewController.m
//  iMusic
//
//  Created by Bob McCune.
//  Copyright (c) 2012 TapHarmonic, LLC. All rights reserved.
//

#import "AboutViewController.h"

@implementation AboutViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
	[super viewDidLoad];
}

- (IBAction)dismissAboutView:(id)sender {
	[self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)resetSampleData:(id)sender {
	NSString *path = [[NSBundle mainBundle] pathForResource:@"iMusic" ofType:@"data"];
	NSURL *sourceURL = [NSURL fileURLWithPath:path];
	NSArray *urls = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
	NSURL *destinationURL = [[urls lastObject] URLByAppendingPathComponent:@"iMusic.data"];
	[[NSFileManager defaultManager] removeItemAtURL:destinationURL error:nil];
	[[NSFileManager defaultManager] copyItemAtURL:sourceURL toURL:destinationURL error:nil];
}

@end
