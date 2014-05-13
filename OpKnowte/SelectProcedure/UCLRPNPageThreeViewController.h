//
//  UCLRPNPageThreeViewController.h
//  MZUroCapture
//
//  Created by Ahmed Sadiq on 3/20/13.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UCLRPNPageOneViewController.h"
//#import "UCWebServerHandler.h"
@interface UCLRPNPageThreeViewController : UIViewController<UITextFieldDelegate> {
    IBOutlet UITextField *surgeonTxt_;
    IBOutlet UILabel *surgeonLbl_;
    IBOutlet UITextField *assistantTxt_;
    IBOutlet UILabel *assistantLbl_;
    IBOutlet UITextField *anestTxt_;
    IBOutlet UILabel *anestLbl_;
    
    IBOutlet UILabel * l_Header;
    
    UIPickerView *myPickerView;
    
    NSMutableArray *ethnicity;
    NSMutableArray *sex;
    
    BOOL isAssistantPressed;
    BOOL isAnesthesPressed;
    BOOL isSexPreseed;
    BOOL isEthnicityPressed;
    
    UCLRPNPageOneViewController *parent;
//    UCWebServerHandler *serviceHandler;

    IBOutlet UIToolbar * t_toolbar;
}

@property (nonatomic, retain) id assisantSelected;
@property (nonatomic, retain) id anesthesiologistSelected;
@property (nonatomic) BOOL isAssistantSelection;
@property (nonatomic) BOOL isAnesthesiologistSelection;
@property (nonatomic, retain) NSString *selecting;

- (IBAction)SettingsView:(id)sender;
- (IBAction)forwardButtonPressed:(id)sender;
- (IBAction)backButtonPressed:(id)sender;
- (IBAction)expandAssistant:(id)sender;
- (IBAction)expandAnesthes:(id)sender;
- (IBAction)homeButtonPressed:(id)sender;

@property (strong, nonatomic) UCLRPNPageOneViewController *parent;
@end
