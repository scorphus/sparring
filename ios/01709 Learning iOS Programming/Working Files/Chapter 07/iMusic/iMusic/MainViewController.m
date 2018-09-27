//
//  MainViewController.m
//  iMusic
//
//  Created by Bob McCune.
//  Copyright (c) 2012 TapHarmonic, LLC. All rights reserved.
//

#import "MainViewController.h"
#import "AboutViewController.h"

@implementation MainViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
	[super viewDidLoad];
}

- (IBAction)showAboutView:(id)sender {
	id controller = [[AboutViewController alloc] initWithNibName:@"AboutView" bundle:nil];
	[self presentViewController:controller animated:YES completion:NULL];
}

- (IBAction)showList:(id)sender {
	NSLog(@"Show List");
}
@end
