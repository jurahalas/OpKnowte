//
//  UCLRPNPagetwoViewController.h
//  MZUroCapture
//
//  Created by Ahmed Sadiq on 3/14/13.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCSwitchOnOff.h"
#import "UCLRPNPageOneViewController.h"
@interface UCLRPNPagetwoViewController : UIViewController<UITextFieldDelegate,UIPickerViewDelegate, UIAlertViewDelegate>
{
    RCSwitchOnOff* cytoswitch;
    IBOutlet UIPickerView *picker_;
    
    IBOutlet UIButton *pickerDoneBtn_;
    UCLRPNPageOneViewController *parent;
    IBOutlet UILabel *postOxLbl_;
     IBOutlet UILabel *preOxLbl_;
    IBOutlet UITextField *postOxTxt_;
    
    NSMutableArray * PreArray;
    
        IBOutlet UITextField *preOxTxt_;
    
    BOOL left;
    BOOL right;
    BOOL cyto;
    
     IBOutlet UILabel * l_Header;
    
      IBOutlet UIToolbar * t_toolbar;
}
-(IBAction)SettingsView:(id)sender;
- (IBAction)preButtonPressed:(id)sender;
- (IBAction)donePressed:(id)sender;
- (IBAction)backButtonPressed:(id)sender;
- (IBAction)forwardButtonPressed:(id)sender;
- (IBAction)homeButtonPressed:(id)sender;
- (IBAction)postButtonPressed:(id)sender;
@property (strong, nonatomic) UCLRPNPageOneViewController *parent;
@end
