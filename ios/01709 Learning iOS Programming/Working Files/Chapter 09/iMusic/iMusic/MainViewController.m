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

@synthesize logoView;
@synthesize viewListButton;
@synthesize aboutButton;

#pragma mark - View Lifecycle

- (void)viewDidLoad {
	[super viewDidLoad];
	
	UIImage *logoImage = [UIImage imageNamed:@"logo"];
	logoView.image = logoImage;
	
	UIImage *bgImage = [UIImage imageNamed:@"background"];
	self.view.backgroundColor = [UIColor colorWithPatternImage:bgImage];
	
	self.viewListButton.backgroundColor = [UIColor clearColor];
	self.aboutButton.backgroundColor = [UIColor clearColor];
	UIEdgeInsets insets = UIEdgeInsetsMake(12.0f, 12.0f, 12.0f, 12.0f);
	UIImage *buttonImage = [[UIImage imageNamed:@"buttonbg"] resizableImageWithCapInsets:insets];
	[self.viewListButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
	[self.aboutButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
	
	
}

#pragma mark - Action Methods

- (IBAction)showAboutView:(id)sender {
	id controller = [[AboutViewController alloc] initWithNibName:@"AboutView" bundle:nil];
	[self presentViewController:controller animated:YES completion:NULL];
	
}

- (IBAction)showList:(id)sender {
	NSLog(@"Show List");
}

@end
