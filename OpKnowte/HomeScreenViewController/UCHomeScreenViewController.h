//
//  UCHomeScreenViewController.h
//  MZUroCapture
//
//  Created by Ahmed Sadiq on 3/5/13.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UCHomeScreenViewController : UIViewController {
    IBOutlet UIView *homeView;
    IBOutlet UIView *introView_;
}

- (IBAction)SettingsView:(id)sender;
- (IBAction)dataCollectionButtonPressed:(id)sender;
- (IBAction)analyticsButtonPressed:(id)sender;
- (IBAction)settingsButtonPressed:(id)sender;
- (IBAction)skipIntroPressed:(id)sender;
- (IBAction)logOff:(id)sender;
- (void)displayIntroductionScreen:(BOOL)isIntroScreenShown;
- (IBAction)introductionButtonPressed:(id)sender;

@end
