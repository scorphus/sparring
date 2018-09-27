//
//  BrowseAlbumsViewController.m
//  iMusic
//
//  Created by Bob McCune.
//  Copyright (c) 2012 TapHarmonic, LLC. All rights reserved.
//

#import "BrowseAlbumsViewController.h"
#import "AlbumDetailsViewController.h"
#import "Album.h"
#import "MusicStoreService.h"

@interface BrowseAlbumsViewController ()
@property (nonatomic, strong) NSMutableArray *albums;
@end

@implementation BrowseAlbumsViewController

@synthesize artist = _artist;
@synthesize albums = _albums;

- (void)viewDidLoad {
	[super viewDidLoad];
	self.title = @"Albums";
	[self.navigationController setNavigationBarHidden:NO animated:YES];

	MusicStoreService *service = [[MusicStoreService alloc] init];

	[service loadAlbumsForArtist:self.artist completionBlock:^(id result, NSError *error) {
		if (error) {
			UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Loading" 
																message:@"Unable to load albums.  Please try again." 
															   delegate:nil 
													  cancelButtonTitle:@"OK" 
													  otherButtonTitles:nil];
			[alertView show];
			return;
		}
		// Set Artists and refresh result list
		self.albums = result;
		[self.tableView reloadData];
	}];
}

- (IBAction)closeDialog:(id)sender {
	[self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.albums.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AlbumCell"];
	cell.textLabel.text = [[self.albums objectAtIndex:indexPath.row] albumName];
	return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([segue.identifier isEqualToString:@"showDetails"]) {
		AlbumDetailsViewController *controller = [segue destinationViewController];
		NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
		controller.album = [self.albums objectAtIndex:indexPath.row];
		controller.saveToListEnabled = YES;
	}
}

@end
