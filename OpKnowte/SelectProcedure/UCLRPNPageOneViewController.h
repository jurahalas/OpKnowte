//
//  UCLRPNPageOneViewController.h
//  MZUroCapture
//
//  Created by Ahmed Sadiq on 3/13/13.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UCLRPNModel.h"
#import "UCDataCaptureViewController.h"

@interface UCLRPNPageOneViewController : UIViewController<UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate> {
    
    UCLRPNModel *parentModel;
    UCDataCaptureViewController *home;
    
    BOOL isDOBSelected;
    BOOL isSexSelection;
    BOOL isRecordSelection;
    
    IBOutlet UILabel * l_Header;
    IBOutlet UIToolbar * t_toolbar;
    NSDateFormatter * dateformater;
    UITextField * t_textField;
    BOOL isEnterText_;
    int datePickerIndex;
    
}

@property (nonatomic, retain) NSString *timePoint;
@property (nonatomic) BOOL isComingFromUrl;
@property (nonatomic, retain) NSString *urlCaseID;
@property (nonatomic, retain) NSString *urlUserID;
@property (nonatomic, retain) NSString *urlTimepointID;
@property (nonatomic, retain) NSString *urlProcedureID;
@property (nonatomic, retain) NSString *urlPatientName;
@property (nonatomic, retain) NSString *urlPatientDOB;
@property (nonatomic, retain) NSString *urlPatientMR;
@property (nonatomic, retain) NSString *urlPatientGender;
@property (nonatomic, retain) NSString *urlPatientDOS;
@property (nonatomic, retain) NSString *urlStonesCount;

@property (strong, nonatomic) IBOutlet UILabel *patientNameTitle;
@property (strong, nonatomic) IBOutlet UITextField *txtPatientName;
@property (strong, nonatomic) IBOutlet UITextField *txtMedicalRecordNo;
@property (strong, nonatomic) IBOutlet UILabel *lblDateOfService;
@property (strong, nonatomic) IBOutlet UILabel *lblPatientDOB;
@property (strong, nonatomic) IBOutlet UILabel *lblSex;

@property (strong, nonatomic) IBOutlet UIImageView *bgSex;
@property (strong, nonatomic) IBOutlet UIButton *disclosoryBtnSex;

@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) IBOutlet UIButton *datePickerDoneButton;

@property (strong, nonatomic) NSMutableArray *sex;
@property (strong, nonatomic) UIPickerView *sexPicker;

@property (strong, nonatomic) UCLRPNModel *parentModel;
@property (strong, nonatomic) ESWLModel *ESWLparentModel;
@property (strong, nonatomic) UCDataCaptureViewController *home;

- (IBAction)datePickerDone:(id)sender;
- (IBAction)SettingsView:(id)sender;
- (IBAction)forwardButtonPressed:(id)sender;
- (IBAction)patientDOBExpandPressed:(id)sender;
- (IBAction)dateOfServiceExpandPressed:(id)sender;
- (IBAction)backButtonPressed:(id)sender;
- (IBAction)homeButtonPressed:(id)sender;

@end
