//
//  AlbumDetailsViewController.m
//  iMusic
//
//  Created by Bob McCune.
//  Copyright (c) 2012 TapHarmonic, LLC. All rights reserved.
//

#import "AlbumDetailsViewController.h"
#import "MusicStoreService.h"

@implementation AlbumDetailsViewController

@synthesize albumImageView = _albumImageView;
@synthesize albumNameLabel = _albumNameLabel;
@synthesize artistNameLabel = _artistNameLabel;
@synthesize genreLabel = _genreLabel;
@synthesize priceLabel = _priceLabel;
@synthesize dateLabel = _dateLabel;
@synthesize saveToListButton = _saveToListButton;
@synthesize openInITunesButton = _openInITunesButton;

@synthesize album = _album;
@synthesize saveToListEnabled = _saveToListEnabled;

#pragma mark - View lifecycle

- (void)viewDidLoad {
	[super viewDidLoad];
	
	if (!self.album.albumImage) {
		MusicStoreService *service = [[MusicStoreService alloc] init];
		[service fetchArtworkForAlbum:self.album completionBlock:^(id result, NSError *error) {
			self.album.albumImage = result;
			self.albumImageView.image = result;	
		}];
	} else {
		self.albumImageView.image = self.album.albumImage;	
	}
	self.albumNameLabel.text = self.album.albumName;
	self.artistNameLabel.text = self.album.artist.artistName;
	self.genreLabel.text = self.album.genre;
	self.priceLabel.text = [NSString stringWithFormat:@"$%@", self.album.price];
	
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateStyle:NSDateFormatterShortStyle];
	self.dateLabel.text = [formatter stringFromDate:self.album.releaseDate];
	
	self.saveToListButton.enabled = self.saveToListEnabled;
}

- (IBAction)saveToList:(id)sender {
	[self.album saveAlbum];
	[self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)openInITunes:(id)sender {
	NSURL *url = [NSURL URLWithString:self.album.iTunesURLString];
	[[UIApplication sharedApplication] openURL:url];
}

@end
