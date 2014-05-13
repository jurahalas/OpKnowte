//
//  UCTWTPPageTwoViewController.h
//  MZUroCapture
//
//  Created by Omer on 5/10/13.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UCTWTPPageOneViewController.h"
@class UCTWTPPageOneViewController;
@interface UCTWTPPageTwoViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate>
{
    IBOutlet UILabel *headerLbl_;
    BOOL isUp;
}

@property (nonatomic, retain) UCTWTPPageOneViewController *parent;

@property (nonatomic, retain) IBOutlet UIPickerView *picker;
@property (nonatomic, retain) IBOutlet UIToolbar * t_toolbar;

@property (nonatomic, retain) IBOutlet UITextField *NightTF;
@property (nonatomic, retain) IBOutlet UITextField *ComplicationsTF;
@property (nonatomic, retain) IBOutlet UITextField *PreOpBUNTF;
@property (nonatomic, retain) IBOutlet UITextField *PreOpCreatinineTF;
@property (nonatomic, retain) IBOutlet UITextField *PostOpBUNTF;
@property (nonatomic, retain) IBOutlet UITextField *PostOpCreatinineTF;
@property (nonatomic, retain) IBOutlet UITextField *AdditionalDiagTF;

@property (nonatomic, retain) IBOutlet UILabel *nightLbl;
@property (nonatomic, retain) IBOutlet UILabel *nightSelectLbl;
@property (nonatomic, retain) IBOutlet UILabel *complicationsLbl;
@property (nonatomic, retain) IBOutlet UILabel *complicationsSelectLbl;
@property (nonatomic, retain) IBOutlet UILabel *preOPLbl;
@property (nonatomic, retain) IBOutlet UILabel *preOPSelectLbl;
@property (nonatomic, retain) IBOutlet UILabel *postOPLbl;
@property (nonatomic, retain) IBOutlet UILabel *postOPSelectLbl;
@property (nonatomic, retain) IBOutlet UILabel *addDiagLbl;
@property (nonatomic, retain) IBOutlet UILabel *addSiagSelectLbl;

@property (nonatomic, retain) IBOutlet UIButton *nightsBtn;
@property (nonatomic, retain) IBOutlet UIButton *complicationsBtn;



- (IBAction)backButtonPressed:(id)sender;
- (IBAction)pickerDonePressed:(id)sender;

-(IBAction)expandNights:(UIButton *)sender;
-(IBAction)expandComplications:(UIButton *)sender;
-(IBAction)update:(UIButton *)sender;

@end
