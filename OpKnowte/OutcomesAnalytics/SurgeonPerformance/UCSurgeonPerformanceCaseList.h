//
//  UCSurgeonPerformanceCaseList.h
//  MZUroCapture
//
//  Created by Atif Joyia on 19/06/2013.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UCSurgeonPerformanceCaseList : UIViewController<UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate>{
    IBOutlet UILabel * l_Header;
    NSDateFormatter * dateformater;
    IBOutlet UIToolbar * t_toolbar;
    
}

@property (nonatomic, retain) NSMutableArray *cases;
@property (nonatomic, retain) NSMutableArray *selectedCases;
@property (nonatomic, retain) NSMutableArray *sortedArray;

@property (nonatomic, retain) IBOutlet UILabel *procedureLbl;
@property (nonatomic, retain) IBOutlet UILabel *fromDateLbl;
@property (nonatomic, retain) IBOutlet UILabel *toDateLbl;
@property (nonatomic, retain) IBOutlet UILabel *fromCaseNumLbl;
@property (nonatomic, retain) IBOutlet UILabel *toCaseNumLbl;

@property (nonatomic, retain) IBOutlet UIButton *doneBtn;

@property (nonatomic, retain) NSString *procedureName;
@property (nonatomic, retain) NSString *fromDate;
@property (nonatomic, retain) NSString *toDate;
@property (nonatomic, retain) NSString *fromCase;
@property (nonatomic, retain) NSString *toCase;

@property (nonatomic, retain) NSString *parent;

@property (nonatomic, retain) IBOutlet UITableView *casesTable;

@property (nonatomic, retain) IBOutlet UIDatePicker *datePicker;
@property (nonatomic, retain) IBOutlet UITextField *fromCaseTF;
@property (nonatomic, retain) IBOutlet UITextField *toCaseTF;
@property (nonatomic, retain) IBOutlet UIButton *fromDateBtn;
@property (nonatomic, retain) IBOutlet UIButton *toDateBtn;
@property (nonatomic, retain) NSString *labelName;
@property (nonatomic, retain) NSString *procedureID;



- (BOOL)isDateValid;
- (IBAction)datePickerDone:(id)sender;
-(IBAction)selectProcedure:(id)sender;
@end
