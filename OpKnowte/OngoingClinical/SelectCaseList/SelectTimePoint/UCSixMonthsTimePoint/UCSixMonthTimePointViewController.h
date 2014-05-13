//
//  UCSixMonthTimePointViewController.h
//  MZUroCapture
//
//  Created by Atif Joyia on 13/06/2013.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UCSixMonthTimePointViewController : UIViewController<UIAlertViewDelegate>
{
    IBOutlet UILabel *headerLbl_;
    BOOL isSummary;
}

@property (nonatomic) BOOL isComingFromUrl;
@property (nonatomic, retain) NSString *urlCaseID;
@property (nonatomic, retain) NSString *urlUserID;
@property (nonatomic, retain) NSString *urlTimepointID;
@property (nonatomic, retain) NSString *urlProcedureID;

@property (nonatomic, retain) IBOutlet UIScrollView *scroller;

@property (nonatomic, retain) NSMutableDictionary *caseData;
@property (nonatomic, retain) NSDictionary *timePoint;
@property (nonatomic, retain) NSMutableDictionary *onGoingData;
@property (nonatomic, retain) NSString *pickerCheck;
@property (nonatomic, retain) NSMutableArray *pickerArray;

@property (nonatomic, retain) IBOutlet UIPickerView *picker;
@property (nonatomic, retain) IBOutlet UIToolbar * t_toolbar;


@property (nonatomic, retain) IBOutlet UITextField *XRayTF;
@property (nonatomic, retain) IBOutlet UITextField *BunTF;
@property (nonatomic, retain) IBOutlet UITextField *CreatinineTF;
@property (nonatomic, retain) IBOutlet UITextField *LiverTF;
@property (nonatomic, retain) IBOutlet UITextField *HerniaTF;
@property (nonatomic, retain) IBOutlet UITextField *CTScanTF;
@property (nonatomic, retain) IBOutlet UITextField *OtherTF;

@property (nonatomic, retain) IBOutlet UILabel *xrayLbl;
@property (nonatomic, retain) IBOutlet UILabel *xraySelectLbl;
@property (nonatomic, retain) IBOutlet UILabel *bunLbl;
@property (nonatomic, retain) IBOutlet UILabel *bunSelectLbl;
@property (nonatomic, retain) IBOutlet UILabel *liverLbl;
@property (nonatomic, retain) IBOutlet UILabel *liverSelectLbl;
@property (nonatomic, retain) IBOutlet UILabel *herniaLbl;
@property (nonatomic, retain) IBOutlet UILabel *herniaSelectLbl;
@property (nonatomic, retain) IBOutlet UILabel *ctScanLbl;
@property (nonatomic, retain) IBOutlet UILabel *ctScanSelectLbl;
@property (nonatomic, retain) IBOutlet UILabel *otherLbl;
@property (nonatomic, retain) IBOutlet UILabel *otherSelectLbl;


- (IBAction)backButtonPressed:(id)sender;

@end
