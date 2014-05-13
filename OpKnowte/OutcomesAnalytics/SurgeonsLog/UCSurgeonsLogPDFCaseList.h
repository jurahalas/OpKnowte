//
//  UCSurgeonsLogPDFCaseList.h
//  MZUroCapture
//
//  Created by Atif Joyia on 25/06/2013.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface UCSurgeonsLogPDFCaseList : UIViewController<UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate>{
    IBOutlet UILabel * l_Header;
    BOOL emailSent;
}

@property (nonatomic, retain) NSMutableArray *selectedCases;
@property (nonatomic, retain) NSMutableDictionary *caseSelected;

@property (nonatomic, retain) IBOutlet UILabel *procedureLbl;
@property (nonatomic, retain) IBOutlet UILabel *fromDateLbl;
@property (nonatomic, retain) IBOutlet UILabel *toDateLbl;
@property (nonatomic, retain) IBOutlet UILabel *fromCaseNumLbl;
@property (nonatomic, retain) IBOutlet UILabel *toCaseNumLbl;

@property (nonatomic, retain) NSString *procedureName;
@property (nonatomic, retain) NSString *fromDate;
@property (nonatomic, retain) NSString *toDate;
@property (nonatomic, retain) NSString *fromCase;
@property (nonatomic, retain) NSString *toCase;

@property (nonatomic, retain) IBOutlet UITableView *casesTable;
@property (strong, nonatomic) NSMutableArray *templateVariables;
@property (strong, nonatomic) UCTemplateResponseModel *templateModel;
@property (strong, nonatomic) NSMutableArray *caseDataArray;

@property (strong, nonatomic) NSString *indicationTxt;
@property (strong, nonatomic) NSString *procedureTxt;


@end
