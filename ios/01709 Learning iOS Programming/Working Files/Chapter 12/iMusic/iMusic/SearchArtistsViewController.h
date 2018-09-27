//
//  SearchArtistsViewController.h
//  iMusic
//
//  Created by Bob McCune.
//  Copyright (c) 2012 TapHarmonic, LLC. All rights reserved.
//

@interface SearchArtistsViewController : UITableViewController <UISearchBarDelegate>

@property (nonatomic, weak) IBOutlet UISearchBar *searchBar;

- (IBAction)closeDialog:(id)sender;

@end
