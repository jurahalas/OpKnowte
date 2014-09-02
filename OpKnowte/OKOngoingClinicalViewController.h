//
//  OKOngoingClinicalViewController.h
//  OpKnowte
//
//  Created by Olegek on 28.04.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OKAppDelegate.h"

@class OKOngoingData;

@interface OKOngoingClinicalViewController : OKBaseViewController

@property (strong, nonatomic) OKOngoingData *ongoingData;
@property (nonatomic, assign) enum OKProcedureSummaryDetailPeriod detailPeriod;
@property (strong, nonatomic) NSString *cameFromVC;
@property (strong, nonatomic) NSString *procID;
@property (strong, nonatomic) NSString *caseNumber;
@property (strong, nonatomic) NSString *stonesCount;

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




@end