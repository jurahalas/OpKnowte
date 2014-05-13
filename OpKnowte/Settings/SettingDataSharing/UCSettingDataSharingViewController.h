//
//  UCSettingDataSharingViewController.h
//  MZUroCapture
//
//  Created by Jawad ali on 4/27/13.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCSwitchOnOff.h"

@interface UCSettingDataSharingViewController : UIViewController<UITextFieldDelegate>
{
    RCSwitchOnOff* DataShareSwitch;
    
    IBOutlet UIView * shareDataPopup;
    
    IBOutlet UITextField * t_password;
}

- (IBAction)homeButtonPressed:(id)sender;

- (IBAction)backButtonPressed:(id)sender;

-(IBAction)SettingsView:(id)sender;

-(IBAction)ShareButtonPress:(id)sender;
@end
