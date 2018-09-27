//
//  MusicListViewController.m
//  iMusic
//
//  Created by Bob McCune.
//  Copyright (c) 2012 TapHarmonic, LLC. All rights reserved.
//

#import "MusicListViewController.h"
#import "Album.h"

@interface MusicListViewController ()
@property (nonatomic, strong) NSMutableArray *albums;
@end

@implementation MusicListViewController

@synthesize albums = _albums;

- (void)viewDidLoad {
	[super viewDidLoad];
	self.title = @"iMusic List";
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	self.albums = [NSMutableArray arrayWithArray:[Album findAllAlbums]];
}

- (void)viewDidUnload {
	[super viewDidUnload];

}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.albums.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"Cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	}

	Album *album = [self.albums objectAtIndex:indexPath.row];
	cell.imageView.image = album.albumImage;
	cell.textLabel.text = album.albumName;

	return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
		Album *album = [self.albums objectAtIndex:indexPath.row];
		[album deleteAlbum];
		[self.albums removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
}

#pragma mark - UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	Album *album = [self.albums objectAtIndex:indexPath.row];
	NSString *message = [NSString stringWithFormat:@"Artist: %@\nAlbum: %@", album.artist.artistName, album.albumName];
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Selection" 
														message:message 
													   delegate:nil 
											  cancelButtonTitle:@"OK" 
											  otherButtonTitles:nil];
	[alertView show];
}


@end
