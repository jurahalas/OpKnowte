//
//  UCLRPNPageFourViewController.h
//  MZUroCapture
//
//  Created by Ahmed Sadiq on 3/20/13.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCSwitchOnOff.h"
#import "UCLRPNPageOneViewController.h"
@interface UCLRPNPageFourViewController : UIViewController<UIPickerViewDelegate,UITextFieldDelegate, UIAlertViewDelegate>
{
    RCSwitchOnOff* prevAbdominal;
    BOOL prevAbdominalFlag;
    IBOutlet UILabel *tumorLbl_;
    IBOutlet UITextField *tumorTxt_;
    IBOutlet UITextField *locationTxt_;
    IBOutlet UILabel *locationLbl_;
    IBOutlet UILabel *charcteristicLbl_;
    IBOutlet UITextField *characteristicTxt_;
    IBOutlet UIButton *pickerDoneBtn_;
    IBOutlet UIPickerView *picker_;
    IBOutlet UIToolbar * t_toolbar;
     IBOutlet UILabel * l_Header;
    BOOL isLocationPressed;
    BOOL isExtraLocationPressed;
    NSMutableArray *locations;
    IBOutlet UILabel *bmiSelectLbl_;
    
    IBOutlet UITextField *bmiTxt_;
    IBOutlet UILabel *bmiLbl_;
    
    BOOL isCharacteristicPressed;
    NSArray *characteristic;

    
    UCLRPNPageOneViewController *parent;
}
-(IBAction)SettingsView:(id)sender;
- (IBAction)backButtonPressed:(id)sender;
- (IBAction)locationBtnPressed:(id)sender;
- (IBAction)forwardButtonPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *characteristicBtnPresed;
- (IBAction)pickerDonePressed:(id)sender;
- (IBAction)characteristicBtnPressed:(id)sender;
@property (strong, nonatomic) UCLRPNPageOneViewController *parent;
- (IBAction)homeButtonPressed:(id)sender;

@property (nonatomic, strong) IBOutlet UILabel *extraLocation;
@property (nonatomic, strong) IBOutlet UIButton *bmiButton;
@property (nonatomic, strong) IBOutlet UIScrollView *scroller;
@property (nonatomic, strong) IBOutlet UITextField *extraLocationTF;
@property (nonatomic, strong) IBOutlet NSMutableArray *locations;
@property (nonatomic, strong) IBOutlet NSMutableArray *extraLocations;

@end
