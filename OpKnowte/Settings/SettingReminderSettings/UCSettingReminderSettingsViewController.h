//
//  UCSettingReminderSettingsViewController.h
//  MZUroCapture
//
//  Created by Omer on 4/30/13.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UCSettingReminderSettingsViewController : UIViewController<UITextFieldDelegate,UIPickerViewDelegate>
{
    IBOutlet UILabel *headerLbl_;
    IBOutlet UILabel *daysLbl_;
    IBOutlet UITextField *dayTxt_;
    IBOutlet UIPickerView *picker_;
    IBOutlet UIToolbar *t_toolbar;
    NSMutableArray * daysAray;

}

@property (nonatomic, retain) NSString *patientID;
@property (nonatomic, retain) NSMutableArray *reminderContacts;


- (IBAction)backButtonPressed:(id)sender;
- (IBAction)daysButtonPressed:(id)sender;
- (IBAction)donePressed:(id)sender;
@end
