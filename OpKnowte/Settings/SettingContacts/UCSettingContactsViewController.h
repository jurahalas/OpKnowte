//
//  UCSettingContactsViewController.h
//  MZUroCapture
//
//  Created by Omer on 5/7/13.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UCSettingContactsViewController : UIViewController
{
    IBOutlet UILabel *headerLbl_;
    IBOutlet UITextField *selectedContactTxt;
    IBOutlet UILabel *selectedContactLbl;
}

@property(nonatomic) NSString *selectedVal;
@property(nonatomic) BOOL isSelected;
- (IBAction)homeButtonPressed:(id)sender;
- (IBAction)backButtonPressed:(id)sender;
- (IBAction)selectContactsButtonPressed:(id)sender;
-(IBAction)SettingsView:(id)sender;
@end
