//
//  AppDelegate.m
//  iMusic
//
//  Created by Bob McCune.
//  Copyright (c) 2012 TapHarmonic, LLC. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"

@implementation AppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
	
	id controller = [[MainViewController alloc] initWithNibName:@"MainView" bundle:nil];
	id navController = [[UINavigationController alloc] initWithRootViewController:controller];
	self.window.rootViewController = navController;

    [self.window makeKeyAndVisible];
    return YES;
}

@end
