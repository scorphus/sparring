//
//  SearchArtistsViewController.m
//  iMusic
//
//  Created by Bob McCune.
//  Copyright (c) 2012 TapHarmonic, LLC. All rights reserved.
//

#import "SearchArtistsViewController.h"
#import "Artist.h"
#import "BrowseAlbumsViewController.h"

@interface SearchArtistsViewController ()
@property (nonatomic, strong) NSMutableArray *artists;
@end

@implementation SearchArtistsViewController

@synthesize searchBar = _searchBar;
@synthesize artists = _artists;

- (void)viewDidLoad {
	[super viewDidLoad];
	self.artists = [NSMutableArray array];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self.navigationController setNavigationBarHidden:YES animated:YES];	
}

- (IBAction)closeDialog:(id)sender {
	[self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
	self.searchBar.text = @"";
	[self.searchBar resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
	[self.searchBar resignFirstResponder];
	[self.artists addObject:[Artist artistWithID:47123955 name:@"Trivium"]];
	[self.tableView reloadData];
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.artists.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ArtistCell"];

	Artist *artist = [self.artists objectAtIndex:indexPath.row];
	cell.textLabel.text = artist.artistName;

	return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([segue.identifier isEqualToString:@"browseAlbums"]) {
		BrowseAlbumsViewController *controller = [segue destinationViewController];
		NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
		controller.artist = [self.artists objectAtIndex:indexPath.row];
	}
}

@end
