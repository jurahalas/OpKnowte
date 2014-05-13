//
//  UCSurgeonPerformanceFilter.h
//  MZUroCapture
//
//  Created by Atif Joyia on 18/06/2013.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UCSurgeonPerformanceFilter : UIViewController<UITextFieldDelegate>
{
    IBOutlet UILabel * l_Header;
    NSDateFormatter * dateformater;
    IBOutlet UIToolbar * t_toolbar;
}

@property (nonatomic, retain) NSString *labelName;
@property (nonatomic, retain) NSString *parent;

@property (nonatomic, retain) IBOutlet UIDatePicker *datePicker;
@property (nonatomic, retain) NSString *procedureID;
@property (nonatomic, retain) NSString *fromDate;
@property (nonatomic, retain) NSString *toDate;
@property (nonatomic, retain) NSString *fromCase;
@property (nonatomic, retain) NSString *toCase;
@property (nonatomic, retain) IBOutlet UIScrollView *scroller;

@property (nonatomic, retain) IBOutlet UILabel *procedureLbl;
@property (nonatomic, retain) IBOutlet UILabel *fromDateLbl;
@property (nonatomic, retain) IBOutlet UILabel *toDateLbl;
@property (nonatomic, retain) IBOutlet UITextField *fromCaseTF;
@property (nonatomic, retain) IBOutlet UITextField *toCaseTF;

@property (nonatomic, retain) IBOutlet UIButton *fromDateBtn;
@property (nonatomic, retain) IBOutlet UIButton *toDateBtn;

@property (nonatomic, retain) IBOutlet UILabel *caseNumLbl;

@end
