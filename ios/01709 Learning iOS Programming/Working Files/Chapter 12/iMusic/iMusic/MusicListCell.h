//
//  MusicListCell.h
//  iMusic
//
//  Created by Bob McCune.
//  Copyright (c) 2012 TapHarmonic, LLC. All rights reserved.
//

@interface MusicListCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *albumImageView;
@property (nonatomic, weak) IBOutlet UILabel *albumNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *artistNameLabel;

@end
