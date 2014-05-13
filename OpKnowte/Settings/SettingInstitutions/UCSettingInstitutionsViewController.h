//
//  UCSettingInstitutionsViewController.h
//  MZUroCapture
//
//  Created by Omer on 5/7/13.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UCSettingInstitutionsViewController : UIViewController
{
    IBOutlet UILabel *headerLbl_;
    IBOutlet UITextField *selectedInstituteTxt;
    IBOutlet UILabel *selectedInstituteLbl;
    
}

@property (nonatomic, retain) NSString *selectedProcedureID;
@property (nonatomic, retain) IBOutlet UITextField *selectedInstituteTxt;
@property (nonatomic, retain) IBOutlet UILabel *selectedInstituteLbl;
@property(nonatomic) NSString *selectedVal;
@property(nonatomic) BOOL isSelected;

- (IBAction)homeButtonPressed:(id)sender;
- (IBAction)backButtonPressed:(id)sender;
- (IBAction)selectInstituteButtonPressed:(id)sender;
- (IBAction)SettingsView:(id)sender;

@end
