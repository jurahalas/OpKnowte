//
//  UCSettingReminderToViewController.h
//  MZUroCapture
//
//  Created by Omer on 5/2/13.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UCSettingReminderSettingsViewController.h"

@interface UCSettingReminderToViewController : UIViewController
{
     IBOutlet UILabel *headerLbl_;
}

@property (nonatomic, retain) UCSettingReminderSettingsViewController *reminderParent;

- (IBAction)homeButtonPressed:(id)sender;
- (IBAction)backButtonPressed:(id)sender;
-(IBAction)SettingsView:(id)sender;
@end
