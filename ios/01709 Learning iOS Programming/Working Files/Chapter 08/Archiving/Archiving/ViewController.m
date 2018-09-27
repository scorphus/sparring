//
//  ViewController.m
//  Archiving
//
//  Created by Bob McCune.
//  Copyright (c) 2012 TapHarmonic, LLC. All rights reserved.
//

#import "ViewController.h"
#import "Artist.h"
#import "Album.h"

@implementation ViewController

@synthesize fileURL = _fileURL;

- (void)viewDidLoad {
    [super viewDidLoad];
	NSArray *urls = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
	self.fileURL = [[urls lastObject] URLByAppendingPathComponent:@"iMusic.data"];
}

- (IBAction)writeArchivedData:(id)sender {

	NSMutableArray *items = [NSMutableArray array];
	
	[items addObject:@"Hello"];
	[items addObject:[NSDate date]];
	[items addObject:[NSNumber numberWithFloat:12.0f]];

	NSData *fileData = [NSKeyedArchiver archivedDataWithRootObject:items];
	[fileData writeToURL:self.fileURL atomically:YES];
}

- (IBAction)readArchivedData:(id)sender {
	NSData *data = [NSData dataWithContentsOfURL:self.fileURL];
	NSMutableArray *items = [NSKeyedUnarchiver unarchiveObjectWithData:data];
	NSLog(@"%@", items);
}

@end
