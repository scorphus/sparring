//
//  AlbumDetailsViewController.h
//  iMusic
//
//  Created by Bob McCune.
//  Copyright (c) 2012 TapHarmonic, LLC. All rights reserved.
//

#import "Album.h"

@interface AlbumDetailsViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIImageView *albumImageView;
@property (nonatomic, weak) IBOutlet UILabel *albumNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *artistNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *genreLabel;
@property (nonatomic, weak) IBOutlet UILabel *priceLabel;
@property (nonatomic, weak) IBOutlet UILabel *dateLabel;
@property (nonatomic, weak) IBOutlet UIButton *saveToListButton;
@property (nonatomic, weak) IBOutlet UIButton *openInITunesButton;

@property (nonatomic, strong) Album *album;
@property (nonatomic, assign) BOOL saveToListEnabled;

- (IBAction)saveToList:(id)sender;
- (IBAction)openInITunes:(id)sender;

@end
