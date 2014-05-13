//
//  UCLRPNPageSixViewController.h
//  MZUroCapture
//
//  Created by Ahmed Sadiq on 3/21/13.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCSwitchOnOff.h"
#import "UCLRPNPageOneViewController.h"
@interface UCLRPNPageSixViewController : UIViewController<UITextFieldDelegate>
{
    RCSwitchOnOff* ultraSound;
    RCSwitchOnOff* margin;
    RCSwitchOnOff* congulants;
    RCSwitchOnOff* rentalCollection;
    
     IBOutlet UILabel * l_Header;
    
    BOOL ultraSoundFlag;
    BOOL marginFlag;
    BOOL congulantsFlag;
    BOOL rentalCollectinFlag;
    IBOutlet UITextField *clampTxt_;
    IBOutlet UILabel *clampLbl_;
    IBOutlet UILabel *clampSelectLbl_;
    IBOutlet UITextField *estimatedBloodLossTxt_;
    IBOutlet UILabel *estimatedBloodLossLbl_;
    IBOutlet UILabel *estimatedBloodLossSelectLbl_;
    
      IBOutlet UIToolbar * t_toolbar;
    
    UCLRPNPageOneViewController *parent;
}

@property (strong, nonatomic) UCLRPNPageOneViewController *parent;
@property (strong, nonatomic) IBOutlet UITextField *congTF;

@property (strong, nonatomic) IBOutlet UIScrollView *scroller;

-(IBAction)SettingsView:(id)sender;
- (IBAction)forwardButtonPressed:(id)sender;
- (IBAction)backButtonPressed:(id)sender;
- (IBAction)homeButtonPressed:(id)sender;

@end
