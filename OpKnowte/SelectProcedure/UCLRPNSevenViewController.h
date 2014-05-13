//
//  UCLRPNSevenViewController.h
//  MZUroCapture
//
//  Created by Ahmed Sadiq on 3/21/13.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCSwitchOnOff.h"
#import "UCLRPNPageOneViewController.h"

@interface UCLRPNSevenViewController : UIViewController<UITextFieldDelegate>
{
    RCSwitchOnOff* transfusion;
    
    BOOL transfusionFlag;
    IBOutlet UITextField *transfusionDetailTxt_;
    IBOutlet UILabel *transfusionDetailLbl_;
    IBOutlet UILabel *couslLbl_;
    IBOutlet UITextField *counslTxt_;
    IBOutlet UILabel *counslSelectLbl_;
    IBOutlet UITextField *roomTimeTxt_;
    IBOutlet UILabel *roomTimeLbl_;
    IBOutlet UILabel *roomTimeSelectLbl_;
    IBOutlet UITextField *complationsTxt_;
    IBOutlet UILabel *complationsSelectLbl_;
    IBOutlet UILabel *complationsLbl_;
    IBOutlet UILabel *ccLbl_;
    IBOutlet UITextField *ccTxt_;
    IBOutlet UITextField *faxTxt_;
    IBOutlet UILabel *ccSelectLbl_;
    
    
    UCLRPNPageOneViewController *parent;
    
    
     IBOutlet UILabel * l_Header;
    
      IBOutlet UIToolbar * t_toolbar;

}
-(IBAction)SettingsView:(id)sender;
- (IBAction)forwardButtonPressed:(id)sender;
- (IBAction)backButtonPressed:(id)sender;
- (IBAction)createOperativeNote:(id)sender;
- (NSArray *)getEmailsArray:(NSArray *)ContactsArray;

@property (strong, nonatomic) IBOutlet UIScrollView *scroller;

@property (strong, nonatomic) IBOutlet UILabel *ccLbl_;
@property (strong, nonatomic) UCContactInfoModel *contactInfo;
@property (strong, nonatomic) IBOutlet UITextField *ccTxt_;
@property (strong, nonatomic) UCLRPNPageOneViewController *parent;
@property (nonatomic, retain) NSMutableArray *selectedContacts;

@end
