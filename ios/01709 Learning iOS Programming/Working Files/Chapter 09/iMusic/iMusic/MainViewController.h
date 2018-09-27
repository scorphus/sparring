//
//  MainViewController.h
//  iMusic
//
//  Created by Bob McCune.
//  Copyright (c) 2012 TapHarmonic, LLC. All rights reserved.
//

@interface MainViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *logoView;
@property (weak, nonatomic) IBOutlet UIButton *viewListButton;
@property (weak, nonatomic) IBOutlet UIButton *aboutButton;

- (IBAction)showAboutView:(id)sender;
- (IBAction)showList:(id)sender;

@end
