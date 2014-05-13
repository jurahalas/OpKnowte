//
//  UCLRPNPageFiveViewController.h
//  MZUroCapture
//
//  Created by Ahmed Sadiq on 3/20/13.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCSwitchOnOff.h"
#import "UCLRPNPageOneViewController.h"
@interface UCLRPNPageFiveViewController : UIViewController<UIPickerViewDelegate, UITextFieldDelegate>
{
    RCSwitchOnOff* intraAbdominal;
    RCSwitchOnOff* vascular;
    BOOL intraAbdominalFlag;
    BOOL vascularFlag;
    IBOutlet UITextField *intraAbdominalDescTxt_;
    IBOutlet UITextField *vascularDescTxt_;
    IBOutlet UILabel *intraAbdominalLbl;
    IBOutlet UILabel *vascularDescLbl;
    IBOutlet UITextField *adhesiolysis;
    IBOutlet UILabel *adhesiolysisSelectLbl_;
    
    NSMutableArray *adhesiolysisArray;
    IBOutlet UIPickerView *picker_;
    IBOutlet UIButton *pickerDone_;
    UCLRPNPageOneViewController *parent;
    
    
      IBOutlet UILabel * l_Header;
    
      IBOutlet UIToolbar * t_toolbar;
}
- (IBAction)homeButtonPressed:(id)sender;
- (IBAction)pickerDonePressed:(id)sender;
- (IBAction)forwardButtonPressed:(id)sender;
- (IBAction)backButtonPressed:(id)sender;
- (IBAction)adhesiolysisExpandPressed:(id)sender;
-(IBAction)SettingsView:(id)sender;
@property (strong, nonatomic) UCLRPNPageOneViewController *parent;

@end
