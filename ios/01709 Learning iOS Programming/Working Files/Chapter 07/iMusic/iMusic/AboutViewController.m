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
@end
