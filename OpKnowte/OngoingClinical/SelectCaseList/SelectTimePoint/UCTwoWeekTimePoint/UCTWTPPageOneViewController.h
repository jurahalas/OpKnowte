//
//  UCTWTPPageOneViewController.h
//  MZUroCapture
//
//  Created by Omer on 5/9/13.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UCTWTPPageTwoViewController.h"

@interface UCTWTPPageOneViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate, UIAlertViewDelegate>
{
    IBOutlet UILabel *headerLbl_;
    BOOL isSummary;
}

@property (nonatomic) BOOL isComingFromUrl;
@property (nonatomic, retain) NSString *urlCaseID;
@property (nonatomic, retain) NSString *urlUserID;
@property (nonatomic, retain) NSString *urlTimepointID;
@property (nonatomic, retain) NSString *urlProcedureID;


@property (nonatomic, retain) NSMutableDictionary *weeksDictionary;
@property (nonatomic, retain) NSMutableDictionary *SummaryDictionary;
@property (nonatomic, retain) NSString *pickerCheck;
@property (nonatomic, retain) NSMutableArray *pickerArray;
@property (nonatomic, retain) NSMutableDictionary *caseData;
@property (nonatomic, retain) NSDictionary *timePoint;
@property (nonatomic, retain) NSMutableDictionary *onGoingData;
@property (nonatomic, retain) IBOutlet UIPickerView *picker;
@property (nonatomic, retain) IBOutlet UIToolbar * t_toolbar;

@property (nonatomic, retain) IBOutlet UITextField *TtextField;
@property (nonatomic, retain) IBOutlet UITextField *NtextField;
@property (nonatomic, retain) IBOutlet UITextField *MtextField;
@property (nonatomic, retain) IBOutlet UITextField *TCtextField;
@property (nonatomic, retain) IBOutlet UITextField *FGtextField;
@property (nonatomic, retain) IBOutlet UITextField *MargintextField;
@property (nonatomic, retain) IBOutlet UITextField *DMtextField;


@property (nonatomic, retain) IBOutlet UILabel *tLbl;
@property (nonatomic, retain) IBOutlet UILabel *tSelectLbl;
@property (nonatomic, retain) IBOutlet UILabel *nLbl;
@property (nonatomic, retain) IBOutlet UILabel *nSelectLbl;
@property (nonatomic, retain) IBOutlet UILabel *mLbl;
@property (nonatomic, retain) IBOutlet UILabel *mSelectLbl;
@property (nonatomic, retain) IBOutlet UILabel *tcLbl;
@property (nonatomic, retain) IBOutlet UILabel *tcSelectLbl;
@property (nonatomic, retain) IBOutlet UILabel *fgLbl;
@property (nonatomic, retain) IBOutlet UILabel *fgSelectLbl;
@property (nonatomic, retain) IBOutlet UILabel *marginLbl;
@property (nonatomic, retain) IBOutlet UILabel *marginSelectLbl;
@property (nonatomic, retain) IBOutlet UILabel *dmLbl;
@property (nonatomic, retain) IBOutlet UILabel *dmSelectLbl;

- (IBAction)homeButtonPressed:(id)sender;
- (IBAction)backButtonPressed:(id)sender;
-(IBAction)SettingsView:(id)sender;
@end
