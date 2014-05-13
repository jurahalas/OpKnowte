//
//  UCNationalPerformanceCaseList.h
//  MZUroCapture
//
//  Created by Atif Joyia on 24/06/2013.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UCNationalPerformanceCaseList : UIViewController<UITableViewDataSource, UITableViewDelegate>{
    IBOutlet UILabel * l_Header;
    NSDateFormatter * dateformater;
    IBOutlet UIToolbar * t_toolbar;
}

//@property (nonatomic, retain) NSMutableArray *cases;
@property (nonatomic, retain) NSMutableArray *selectedCases;
@property (nonatomic, retain) NSMutableArray *sortedArray;

@property (nonatomic, retain) IBOutlet UILabel *procedureLbl;
@property (nonatomic, retain) IBOutlet UILabel *fromDateLbl;
@property (nonatomic, retain) IBOutlet UILabel *toDateLbl;

@property (nonatomic, retain) NSString *procedureName;
@property (nonatomic, retain) NSString *fromDate;
@property (nonatomic, retain) NSString *toDate;
@property (nonatomic, retain) NSString *fromCase;
@property (nonatomic, retain) NSString *toCase;

@property (nonatomic, retain) IBOutlet UITableView *casesTable;

@property (nonatomic, retain) IBOutlet UIDatePicker *datePicker;
@property (nonatomic, retain) IBOutlet UIButton *fromDateBtn;
@property (nonatomic, retain) IBOutlet UIButton *toDateBtn;
@property (nonatomic, retain) NSString *procedureID;
@property (nonatomic, retain) NSString *labelName;


@property (nonatomic, retain) NSString *surgeonFromDate;
@property (nonatomic, retain) NSString *surgeonToDate;
@property (nonatomic) BOOL isNational;
@property (nonatomic, retain) NSMutableArray *surgeonCasesDatas;
@property (nonatomic, retain) NSMutableArray *nationalCaseDatas;
@property (nonatomic, retain) NSMutableArray *surgeonClicicalDatas;
@property (nonatomic, retain) NSMutableArray *nationalClinicalDatas;




@end
