//
//  BrowseAlbumsViewController.h
//  iMusic
//
//  Created by Bob McCune.
//  Copyright (c) 2012 TapHarmonic, LLC. All rights reserved.
//

@class Artist;

@interface BrowseAlbumsViewController : UITableViewController

@property (nonatomic, strong) Artist *artist;

- (IBAction)closeDialog:(id)sender;

@end
