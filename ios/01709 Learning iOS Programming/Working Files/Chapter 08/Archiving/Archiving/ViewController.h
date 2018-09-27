//
//  ViewController.h
//  Archiving
//
//  Created by Bob McCune.
//  Copyright (c) 2012 TapHarmonic, LLC. All rights reserved.
//

@interface ViewController : UIViewController

@property (nonatomic, strong) NSURL *fileURL;

- (IBAction)writeArchivedData:(id)sender;
- (IBAction)readArchivedData:(id)sender;

@end
