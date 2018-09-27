//
//  MusicListViewController.m
//  iMusic
//
//  Created by Bob McCune.
//  Copyright (c) 2012 TapHarmonic, LLC. All rights reserved.
//

#import "MusicListViewController.h"
#import "Album.h"
#import "MusicListCell.h"
#import "AlbumDetailsViewController.h"

@interface MusicListViewController ()
@property (nonatomic, strong) NSMutableArray *albums;
@property (nonatomic, strong) AlbumDetailsViewController *detailViewController;
@end

@implementation MusicListViewController

@synthesize albums = _albums;
@synthesize detailViewController = _detailViewController;

- (void)viewDidLoad {
	[super viewDidLoad];
	self.title = @"iMusic List";
	self.detailViewController = (AlbumDetailsViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];

	self.albums = [NSMutableArray arrayWithArray:[Album findAllAlbums]];
	if (self.albums.count > 0) {
		self.detailViewController.album = [self.albums objectAtIndex:0];	
	}
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	self.albums = [NSMutableArray arrayWithArray:[Album findAllAlbums]];
	[self.tableView reloadData];
}

- (void)viewDidUnload {
	[super viewDidUnload];

}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.albums.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	MusicListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AlbumCell"];

	Album *album = [self.albums objectAtIndex:indexPath.row];

	cell.albumImageView.image = album.albumImage;
	cell.albumNameLabel.text = album.albumName;
	cell.artistNameLabel.text = album.artist.artistName;
	
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([segue.identifier isEqualToString:@"showDetails"]) {
		NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
		Album *album = [self.albums objectAtIndex:indexPath.row];
		AlbumDetailsViewController *controller = [segue destinationViewController];
		controller.album = album;
	}
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
		self.detailViewController.album = [self.albums objectAtIndex:indexPath.row];	
	}
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
	return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
}

@end
